module V1
  class ProductsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_store
    before_action :set_product, only: %i[update]

    def create
      @product = @store.products.new(product_params)

      if @product.save
        render :show, status: :created
      else
        render json: { errors: @product.errors.messages }, status: :bad_request
      end
    end

    def update
      if @product.update(product_params)
        render :show, status: :ok
      else
        render json: { errors: @product.errors.messages }, status: :bad_request
      end
    end

    private

    def product_params
      params.require(:product).permit(:name, :description, :price)
    end

    def set_store
      @store = @current_user.store
    end

    def set_product
      @product = @store.products.find_by(id: params[:id])

      head :not_found unless @product
    end
  end
end