class ProductsController < InheritedResources::Base

	def cost
		@data = "data"
	end


  private

    def product_params
      params.require(:product).permit(:name)
    end
end

