asciidoctor -a allow-uri-read \
  -a url='https://docs.google.com/a/neotechnology.com/document/export?format=txt&id=1UzXNmTcRkOGk7sMXYGD_V9Woni9YEksICFrvp2-PwrY' \
  -a type=newsletter \
  -r ./lib/twitter-macro.rb \
  -r ./lib/youtube-macro.rb \
  template.adoc \
  -T newsletter-templates \
  -o -
