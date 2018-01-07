module Api
  module V1
    class ProductMobileDataController < ApplicationController
      include ActionView::Helpers::NumberHelper
      respond_to :json
      def index
        @hello_world_props = { name: "Stranger" }
      end

      def show
        last_craw = ProductMobileData.last.created_at.to_date
        sql_raw = "SELECT distinct on (product_title) * FROM product_mobile_data
          WHERE product_mobile_data.created_at > '#{last_craw.beginning_of_day}'
          LIMIT 20"
        result = ProductMobileData.find_by_sql(sql_raw)
        render json: result.map{|product| single_product_mobile_data(product)}
      end

      def search
        last_craw = ProductMobileData.last.created_at.to_date
        original_page_source = params["page_source"]
        if params["search"].present?
          sql_raw = "SELECT * FROM product_mobile_data
            WHERE product_mobile_data.created_at > '#{last_craw.beginning_of_day}'
            AND product_mobile_data.product_title ILIKE '#{custom_search_params(params)}'
            LIMIT 20"
        else
          sql_raw = "SELECT distinct on (product_title) * FROM product_mobile_data
          WHERE product_mobile_data.created_at > '#{last_craw.beginning_of_day}'
          LIMIT 20"
        end

        similar_product_result = ProductMobileData.find_by_sql(sql_raw)

        render json: similar_product_result.map{|product| single_product_mobile_data(product)}
      end

      def similar_product
        last_craw = ProductMobileData.last.created_at.to_date
        original_page_source = params["page_source"]
        sql_raw = "SELECT distinct on (full_name) * FROM product_mobile_data
          WHERE product_mobile_data.created_at > '#{last_craw.beginning_of_day}'
          AND product_mobile_data.product_title ILIKE '#{custom_similar(params)}'
          LIMIT 20"

        similar_product_result = ProductMobileData.find_by_sql(sql_raw)

        render json: similar_product_result.map{|product| single_product_mobile_data(product)}
      end

      private
        def custom_search_params search_params
          search_string = "%" + search_params["search"] + "%"
        end

        def custom_similar search_params
          "%" + search_params["search"].split(" ").join("%") + "%"
        end

        def single_product_mobile_data product_mobile_data
          shop = Shop.find_by_page_source_id(product_mobile_data.page_source)
          {
            id: product_mobile_data.id,
            category_id: product_mobile_data.category_id,
            product_title: product_mobile_data.product_title,
            price: number_to_currency(product_mobile_data.price.to_i, :unit => "₫").to_s.gsub("₫","").gsub(".00",""),
            description: product_mobile_data.description.to_s,
            extra_bonus: product_mobile_data.extra_bonus,
            page_source: product_mobile_data.page_source,
            image_link: product_mobile_data.image_link,
            shop_logo_link: shop.logo_link,
            shop_name: shop.full_name,
            price_to_compare: product_mobile_data.price.to_i,
            full_name: product_mobile_data.full_name
          }
        end
    end
  end
end
