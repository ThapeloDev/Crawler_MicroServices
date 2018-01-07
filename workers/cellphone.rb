require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'capybara'
require 'selenium'
require 'capybara/dsl'
require 'open-uri'

class Cellphone
  include Crawler::Crawler_Service
  include Capybara::DSL
  def init_html
    visit 'https://cellphones.com.vn/mobile.html'
    page.driver.browser.manage.window.maximize
    page_content = Nokogiri::HTML(page.html)
    (1..14).each do |number|
      visit "https://cellphones.com.vn/mobile.html?p=#{number}"
      get_data(page_content, "cellphone")
    end
    page.driver.browser.close
    # @loadmore_exist = true
    # while @loadmore_exist
    #   sleep(2)
    #   begin
    #     load_more = page.find('#CategoryPager')
    #   rescue
    #     @loadmore_exist = false
    #     next
    #   end

    #   page.execute_script "$('#CategoryPager').click();"
    # end
    # page_content = Nokogiri::HTML(page.html)
    #
    # page_content
  end

  def get_data content, page_source
    raw_datas = content.css('.cols-5 li')
    raw_datas.each do |raw_data|
      next if raw_data.css(".lt-product-group-image img").first.nil?
      product_image_link = raw_data.css(".lt-product-group-image img").first.attributes["src"].value.to_s.strip
      product_link = raw_data.css("a").first.attributes["href"].value.to_s.strip
      # image_file = open("image.png", 'wb') { |file| file << open(URI.encode(product_image_link)).read }

      product_name = raw_data.css(".lt-product-group-info h3").first.text

      product_price = convert_special_character(raw_data.css(".price").text.to_s.delete("\n").strip, page_source).to_i

      new_product = ProductMobileData.create(
        product_title: product_name.split(" ").drop(1).join(" ").gsub(" Chính hãng",""),
        price: product_price,
        page_source: page_source,
        image_link: product_image_link,
        description: product_link,
        full_name: product_name
      )

      # new_product_photo = ProductMobileImage.new
      # new_product_photo.photo = File.open(image_file)
      # new_product_photo.product_mobile_data = new_product
      # new_product_photo.save
    end
  end
end