require 'asciidoctor/extensions' unless RUBY_ENGINE == 'opal'

require 'webdriver-user-agent'
require 'selenium-webdriver'

include ::Asciidoctor

# A block macro that embeds a Tweet into a document
#
# Usage
#
#   tweet::12345[]
#
class TwitterBlockMacro < Extensions::BlockMacroProcessor
  use_dsl

  named :tweet

  def process parent, target, attrs

    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--ignore-certificate-errors')
    options.add_argument('--disable-popup-blocking')
    options.add_argument('--disable-translate')
    options.add_argument('--user-agent=iphone')
    options.add_argument('--window-size=414,600')

    image_location = "adoc/images/#{target}.png"
    tweet_location = "https://twitter.com/twin4j/status/#{target}"

    driver = Selenium::WebDriver.for :chrome, options: options
    driver.navigate.to "https://twitter.com/twin4j/status/#{target}"
    driver.save_screenshot image_location

    driver.quit

    html = %(<div class="content">
    <a class="image" href="#{tweet_location}" target="_blank">
      <img src="#{image_location}" width="100%" />
    </a>
</div>)

    create_pass_block parent, html, attrs, subs: nil
  end
end
