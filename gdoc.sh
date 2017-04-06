echo 'include::{url}[]' > template.adoc
asciidoctor -a allow-uri-read \
  -a url='https://docs.google.com/a/neotechnology.com/document/export?format=txt&id=1fWi-8IIkeLHvp9FxGlg6EODKu6Gs4GKIv65t3HybooI' \
  template.adoc \
  -T blog-templates \
  -o -
