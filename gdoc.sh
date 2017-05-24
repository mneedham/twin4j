echo 'include::{url}[]' > template.adoc
asciidoctor -a allow-uri-read \
  -a url='https://docs.google.com/a/neotechnology.com/document/export?format=txt&id=1I34wc5zaHCQvbHQ5PGDtphs1OvRFCjCeR6A9yLC0xmA' \
  template.adoc \
  -T blog-templates \
  -o -
