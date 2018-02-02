require 'asciidoctor/extensions' unless RUBY_ENGINE == 'opal'

include ::Asciidoctor

class FeaturedBlockMacro < Extensions::BlockMacroProcessor
  use_dsl

  named :featured

  def process parent, target, attrs
    name = attrs["name"]

    html = %(<div class="imageblock image-heading">
                <div class="content">
                    <img src="#{target}" alt="#{name} - This Week’s Featured Community Member" width="800" height="400">
                </div>
            </div>
            <p style="font-size: .8em; line-height: 1.5em;" align="center">
              <strong>#{name} - This Week's Featured Community Member</strong>
            </p>)

    create_pass_block parent, html, attrs, subs: nil
  end
end
