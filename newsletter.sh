asciidoctor -a allow-uri-read \
  -a url='adoc/2017-06-17.adoc' \
  -a type=newsletter \
  -r ./lib/twitter-macro.rb \
  -r ./lib/youtube-macro.rb \
  template.adoc \
  -T newsletter-templates \
  -o -
