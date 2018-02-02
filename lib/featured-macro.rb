RUBY_ENGINE == 'opal' ? (require 'featured-macro/extension') : (require_relative 'featured-macro/extension')

Asciidoctor::Extensions.register do
  if (@document.basebackend? 'html') && (@document.safe < SafeMode::SECURE)
    block_macro FeaturedBlockMacro
  end
end
