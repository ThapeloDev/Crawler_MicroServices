require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'capybara'
require 'selenium'
require 'capybara/dsl'

class Thegioididong
  include Crawler::Crawler_Service
  include Capybara::DSL
  def init_html
    visit 'https://www.thegioididong.com/dtdd'
    @loadmore_exist = true
    while @loadmore_exist
      sleep(2)
      begin
        load_more = page.find('.viewmore')
      rescue
        @loadmore_exist = false
        next
      end
      load_more.click()
    end
    page_content = Nokogiri::HTML(page.html)
    page.driver.browser.close
    page_content
  end

  def fetch_data_from_html
    page_content = init_html
    get_data_from_img(page_content)
  end
end