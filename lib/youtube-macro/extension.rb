require 'asciidoctor/extensions' unless RUBY_ENGINE == 'opal'

require 'webdriver-user-agent'
require 'selenium-webdriver'
require 'open-uri'

include ::Asciidoctor

# A block macro that embeds a Tweet into a document
#
# Usage
#
#   tweet::12345[]
#
class YouTubeBlockMacro < Extensions::BlockMacroProcessor
  use_dsl

  named :youtube

  def process parent, target, attrs

    if attrs["type"] == "web"
      html = %(<div class="content">
      <iframe width="560" height="315" src="https://www.youtube.com/embed/#{target}" frameborder="0" allowfullscreen></iframe>
      <br /><br />
      </div>)
    else
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--ignore-certificate-errors')
      options.add_argument('--disable-popup-blocking')
      options.add_argument('--disable-translate')
      options.add_argument('--user-agent=iphone')
      options.add_argument('--window-size=414,600')

      image_location = "adoc/images/youtube/#{target}.png"
      youtube_location = "https://www.youtube.com/embed/#{target}"
      youtube_link = "https://www.youtube.com/watch?v=#{target}"
      s3_location = "https://s3-eu-west-1.amazonaws.com/twin4j-newsletter-images/youtube/#{target}.png"

      driver = Selenium::WebDriver.for :chrome, options: options
      driver.navigate.to youtube_location
      driver.save_screenshot image_location

      driver.quit

      html = %(<div class="content">
      <a class="image" href="#{youtube_link}" target="_blank">
        <img src="#{s3_location}" width="100%" />
      </a>
      </div>)
    end

    create_pass_block parent, html, attrs, subs: nil

  end
end
