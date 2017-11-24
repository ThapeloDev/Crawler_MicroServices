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

      end
    end
  end
end
