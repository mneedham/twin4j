echo 'include::{url}[]' > template.adoc
asciidoctor -a allow-uri-read \
  -a url='https://docs.google.com/a/neotechnology.com/document/export?format=txt&id=1_Kg6SF_uHi-A97wFzVbB6IJeuDWsXppahnVRUux1ytc' \
  template.adoc \
  -T newsletter-templates \
  -o -
