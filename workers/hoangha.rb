require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'capybara'
require 'selenium'
require 'capybara/dsl'
require 'open-uri'

class Hoangha
  include Crawler::Crawler_Service
  include Capybara::DSL
  def init_html
    visit 'https://hoanghamobile.com/dien-thoai-di-dong-c14.html'
    page.driver.browser.manage.window.maximize
    page_content = Nokogiri::HTML(page.html)
    (1..15).each do |number|
      visit "https://hoanghamobile.com/dien-thoai-di-dong-c14.html?sort=11&p=#{number}"
      get_data(page_content, "hoanghamobile")
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
    raw_datas = content.css('.list-item')
    raw_datas.each do |raw_data|
      product_image_link = raw_data.css(".mosaic-backdrop img").first.attributes["src"].value.to_s.strip
      product_link = raw_data.css(".mosaic-block a").first.attributes["href"].value.to_s.strip
      # image_file = open("image.png", 'wb') { |file| file << open(URI.encode(product_image_link)).read }

      product_name = raw_data.css(".product-name a").first.text

      product_price = convert_special_character(raw_data.css(".product-price").text.to_s.delete("\n").strip, page_source).to_i
      new_product = ProductMobileData.create(
        product_title: product_name.split(" ").drop(1).join(" ").gsub(" - Chính Hãng","").gsub(" - Chính hãng","").gsub(" - Digiworld ( Rom Tiếng Việt Gốc )","").gsub(" - CPO ( Certified Pre-Owned)","").gsub(" - Chống nước",""),
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