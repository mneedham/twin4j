RUBY_ENGINE == 'opal' ? (require 'youtube-macro/extension') : (require_relative 'youtube-macro/extension')

Asciidoctor::Extensions.register do
  if (@document.basebackend? 'html') && (@document.safe < SafeMode::SECURE)
    block_macro YouTubeBlockMacro
  end
end
