echo 'include::{url}[]' > template.adoc
asciidoctor -a allow-uri-read \
  -a url='https://docs.google.com/a/neotechnology.com/document/export?format=txt&id=1cZAFPFB_JgXuMWfAGMPL9KRA24fJXmdLOyY5q13xAGM' \
  template.adoc \
  -T blog-templates \
  -o -
