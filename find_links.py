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

@app.route("/")
def hello():
    result = "<table>"
    result += """
        <tr>
            <th>Project</th>
            <th>User</th>
            <th>Favourites</th>
            <th>Updated</th>
            <th>Created</th>
        </tr>
    """

    with driver.session() as session:
        for record in session.read_transaction(github_links):
            result += """
                <tr>
                    <td><a href="{2}" target="_blank">{0}</a></td>
                    <td><a href="http://github.com/{1}" target="_blank">{1}</a></td>
                    <td>{3}</td>
                    <td>{4}</td>
                    <td>{5}</td>
                </tr>""".format(\
                    record["n.title"], \
                    record["user.name"], \
                    record["n.url"], \
                    record["n.favorites"], \
                    human(datetime.datetime.fromtimestamp(record["n.updated"] / 1000), precision=1), \
                    human(datetime.datetime.fromtimestamp(record["n.created"] / 1000), precision=1))
    result += "</table>"
    
    return render_template('hello.html', name=name)


if __name__ == "__main__":
    app.run()
