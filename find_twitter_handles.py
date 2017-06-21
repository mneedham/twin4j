from bs4 import BeautifulSoup

f = open('adoc/2017-06-17.html', 'r')

soup = BeautifulSoup(f.read(), 'html.parser')

twitter_handles = [link["href"] for link in soup.select("a") if "twitter.com" in link["href"]]

for twitter_handle in twitter_handles:
    handle = twitter_handle.split("/")[3]
    if not handle in ["hashtag", "twitterapi", "markhneedham"]:
        print(handle)
