echo 'include::{url}[]' > template.adoc
asciidoctor -a allow-uri-read \
  -a url='https://docs.google.com/a/neotechnology.com/document/export?format=txt&id=1KhRCqkEwcrXCRVHga6REWboC2W6HsIUUyDjDiS3_5jQ' \
  template.adoc \
  -T blog-templates \
  -o -
