# echo 'include::{url}[]' > template.adoc
asciidoctor -a allow-uri-read \
  -a url='https://docs.google.com/a/neotechnology.com/document/export?format=txt&id=1oFP3ru1edMmPMR9kqY-hBAOCQYTOI_r9quuGSPI4id4' \
  template.adoc \
  -a type=web \
  -r ./lib/twitter-macro.rb \
  -r ./lib/youtube-macro.rb \
  -T blog-templates \
  -o -
