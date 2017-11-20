#!/bin/bash

# echo 'include::{url}[]' > template.adoc

: ${doc_id:=${1:-"1UXKNXCAL1S-fj6tBh3xMZKFcgEzQF8flYXwxXTkuLGM"}}

asciidoctor -a allow-uri-read \
  -a url="https://docs.google.com/a/neotechnology.com/document/export?format=txt&id=${doc_id}" \
  template.adoc \
  -a type=web \
  -r ./lib/twitter-macro.rb \
  -r ./lib/youtube-macro.rb \
  -T blog-templates \
  -o -
