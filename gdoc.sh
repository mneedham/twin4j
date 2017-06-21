# echo 'include::{url}[]' > template.adoc
asciidoctor -a allow-uri-read \
  -a url='adoc/2017-06-17.adoc' \
  template.adoc \
  -T blog-templates \
  -o -
