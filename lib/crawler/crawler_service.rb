require 'rubygems'
require 'mechanize'
require 'open-uri'
require 'nokogiri'
require "selenium-webdriver"

module Crawler::Crawler_Service

  def get_data_from_img content, page_source
    raw_datas = content.css('img')

    raw_datas.each do |raw_data|
      next unless raw_data.attributes.keys.include?("data-original")
      product_image_link = raw_data.attributes["data-original"].value
      # image_file = open('image.png', 'wb') { |file| file << open(product_image_link).read }

      next if raw_data.next_element.nil?
      product_name = raw_data.next_element.children.text
      next if raw_data.next_element.next_element.nil?
      product_price = convert_special_character(raw_data.next_element.next_element.children.text, page_source).to_i

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

  def convert_special_character string, page_source
    @replacements =
      case page_source
      when "thegioididong", "fptshop"
         [ ["₫", ""], [".", ""] ]
      when "vienthonga"
        [ ["₫", ""], [",", ""] ]
      end
    @replacements.each {|replacement| string.gsub!(replacement[0], replacement[1])}
    string
  end
end