require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'capybara'
require 'selenium'
require 'capybara/dsl'
class Vienthonga
  include Crawler::Crawler_Service
  include Capybara::DSL
  def init_html
    visit 'https://vienthonga.vn/dien-thoai-smartphones'
    page.driver.browser.manage.window.maximize

    @loadmore_exist = true
    while @loadmore_exist
      sleep(2)
      begin
        load_more = page.find('#CategoryPager')
      rescue
        @loadmore_exist = false
        next
      end

      page.execute_script "$('#CategoryPager').click();"
    end
    page_content = Nokogiri::HTML(page.html)
    page.driver.browser.close
    page_content
  end

  def fetch_data_from_html
    page_content = init_html
    get_data(page_content, "vienthonga")
  end

  def get_data content, page_source
    raw_datas = content.css('.masonry-item')
    raw_datas.each do |raw_data|
      begin
        product_image_link = raw_data.css(".product-image img").first.attributes["data-original"].value
      rescue
        product_image_link = raw_data.css(".product-image img").first.attributes["src"].value
      end
      # image_file = open('image.png', 'wb') { |file| file << open(product_image_link).read }

      product_name = raw_data.css(".product-name .name").first.children.to_s.delete("\n").strip
      product_link = "https://vienthonga.vn" + raw_data.css(".product-link").first.attributes["href"].value.to_s.strip

      product_price = convert_special_character(raw_data.css(".price .price-1").text.to_s.delete("\n").strip, page_source).to_i

      new_product = ProductMobileData.create(
        product_title: product_name,
        price: product_price,
        page_source: page_source,
        image_link: product_image_link,
        description: product_link,
        full_name: product_name
      )

      # new_product_photo = ProductMobileImage.new
      # new_product_photo.photo = File.open(image_file)
      # new_product_photo.product_mobile_data = new_product
      # new_product_photo.image_link = product_image_link
      # new_product_photo.save
    end
  end
end