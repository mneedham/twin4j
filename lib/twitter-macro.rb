RUBY_ENGINE == 'opal' ? (require 'twitter-macro/extension') : (require_relative 'twitter-macro/extension')

Asciidoctor::Extensions.register do
  if (@document.basebackend? 'html') && (@document.safe < SafeMode::SECURE)
    block_macro TwitterBlockMacro
  end
end
