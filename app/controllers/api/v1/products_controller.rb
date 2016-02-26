module Api
  module V1
    class ProductsController < ApplicationController
      respond_to :json
      before_action :authenticate_with_token!, only: [:create, :update]

      def show
        respond_with Product.find(params[:id])
      end

      def index
        respond_with Product.search(params)
      end

      def create
        product = current_user.products.new(product_params)
        if product.save
          render json: product, status: 201, location: [:api, product]
        else
          render json: { errors: product.errors }, status: 422
        end
      end

      def update
        product = current_user.products.find(params[:id])
        if product.update(product_params)
          render json: product, status: 200, location: [:api, product]
        else
          render json: { errors: product.errors }, status: 422
        end
      end

      def destroy
        product = current_user.products.find(params[:id])
        product.destroy
        head 204
      end

      private

      def product_params
        params.require(:product).permit(:title, :price, :published)
      end
    end
  end
end
