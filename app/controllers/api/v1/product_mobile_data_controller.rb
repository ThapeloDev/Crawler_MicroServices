module Api
  module V1
    class ProductMobileDataController < ApplicationController
      respond_to :json
      def index
        @hello_world_props = { name: "Stranger" }
      end

      def show
        render json: ProductMobileData.all.limit(10).group_by("product_title").group_by("page_source")
      end

      def search
        search_result = ProductMobileData.where("product_title ILIKE ?", custom_search_params(params)).group_by("page_source")
        render json: search_result
      end

      def similar_product
        original_page_source = params["page_source"]
        similar_product_result = ProductMobileData
                                .where("product_title ILIKE :search_params AND page_source != :page_source", { search_params: custom_search_params(params), page_source: original_page_source })
                                .where("created_at >= ?", Time.zone.now.beginning_of_day)
        render json: similar_product_result
      end

      private
        def custom_search_params search_params
          search_string = "%" + search_params["search"].split("").join("%") + "%"
        end
    end
  end
end
