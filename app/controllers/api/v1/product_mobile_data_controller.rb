module Api
  module V1
    class ProductMobileDataController < ApplicationController
      respond_to :json
      def index
        @hello_world_props = { name: "Stranger" }
      end

      def show
        render json: ProductMobileData.all
      end

      def search
        search_string = "%" + params["search"].split("").join("%") + "%"
        search_result = ProductMobileData.where("product_title ILIKE ?", search_string)
        render json: search_result
      end
    end
  end
end
