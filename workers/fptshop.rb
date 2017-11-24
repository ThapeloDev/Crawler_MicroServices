require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'capybara'
require 'selenium'
require 'capybara/dsl'
require 'open-uri'

class Fptshop
  include Crawler::Crawler_Service
  include Capybara::DSL
  def init_html
    visit 'https://fptshop.com.vn/dien-thoai?sort=gia-cao-den-thap'
    page.driver.browser.manage.window.maximize
    page_content = Nokogiri::HTML(page.html)
    number_page = page_content.css(".f-cmtpaging .f-cmtpg-l").last.attributes["data-page"].value.to_i
    (1..number_page).each do |number|
    	visit "https://fptshop.com.vn/dien-thoai?sort=gia-cao-den-thap&trang=#{number}"
    	get_data(page_content, "fptshop")
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
    raw_datas = content.css('.fs-lpil')
    raw_datas.each do |raw_data|
      product_image_link = "https:" + raw_data.css(".fs-lpil-img img").first.attributes["data-original"].value.to_s.strip
      # image_file = open("image.png", 'wb') { |file| file << open(URI.encode(product_image_link)).read }

      product_name = raw_data.css(".fs-lpil-name").first.text

      product_price = convert_special_character(raw_data.css(".fs-lpil-price").text.to_s.delete("\n").strip, page_source).to_i

      new_product = ProductMobileData.create(
        product_title: product_name,
        price: product_price,
        page_source: page_source,
        image_link: product_image_link
      )

      # new_product_photo = ProductMobileImage.new
      # new_product_photo.photo = File.open(image_file)
      # new_product_photo.product_mobile_data = new_product
      # new_product_photo.save
    end
  end
end