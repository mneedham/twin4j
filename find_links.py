from neo4j.v1 import GraphDatabase
from flask import render_template
from flask import Flask
from ago import human

import datetime

app = Flask(__name__)
driver = GraphDatabase.driver("bolt://138.197.15.1:7687", auth=("all", "readonly"))

def github_links(tx):
    records = []
    for record in tx.run("""\
        MATCH (n:Repository) WHERE EXISTS(n.created) AND n.updated > timestamp() - 7 * 60 * 60 * 24 * 1000
        WITH n
        ORDER BY n.updated desc
        MATCH (n)<-[:CREATED]-(user) WHERE NOT (user.name IN ["neo4j", "neo4j-contrib"])
        RETURN n.title, n.url, n.created, n.favorites, n.updated, user.name, n.created_at, n.updated_at
        ORDER BY n.updated desc
        """):
        records.append(record)
    return records

def twitter_links(tx):
    records = []
    for record in tx.run("""\
        WITH ((timestamp() / 1000) - (7 * 24 * 60 * 60)) AS oneWeekAgo
        MATCH (l:Link)<--(t:Tweet:Content)
        WHERE not(t:Retweet) AND toInt(t.created) is not null AND t.created > oneWeekAgo AND not l.url contains "neo4j.com"
        WITH l, t, oneWeekAgo
        MATCH (l)<--(tweet:Tweet:Content)
        WITH l, t, tweet, oneWeekAgo
        ORDER BY l.url, tweet.created
        WITH l, t, COLLECT(tweet)[0] AS earliestMention, oneWeekAgo
        WHERE earliestMention.created > oneWeekAgo
        WITH l, t, earliestMention
        MATCH (t)<-[:POSTED]-(user)
        WITH l.url AS url,
        sum(size((t)<-[:RETWEETED]-())) + sum(t.favorites) as score, earliestMention.created * 1000 AS dateCreated, COLLECT(DISTINCT user.screen_name) AS users
        RETURN url, sum(score) AS score, users, dateCreated
        order by score desc
        """):
        records.append(record)
    return records

@app.template_filter('humanise')
def humanise_filter(value):
    return human(datetime.datetime.fromtimestamp(value / 1000), precision=1)

@app.route("/")
def home():
    github_records, twitter_records = [], []
    with driver.session() as session:
        for record in session.read_transaction(github_links):
            github_records.append(record)

        for record in session.read_transaction(twitter_links):
            twitter_records.append(record)

    return render_template('index.html', github_records=github_records, twitter_records=twitter_records)


if __name__ == "__main__":
    app.run()
