class CartItemsController < ApplicationController
    before_action :authorize_request
    before_action :set_restaurant_id, only: :create
    before_action :set_dish_id, only: :create
    before_action :set_cart
    before_action :set_cart_item, except: [:index, :create]

    # GET /cart_items
    def index
        @cart_items = @cart.cart_items

        render json: @cart_items
    end

    # POST /cart_items
    def create
        @cart_item = @cart.add_item(@dish_id, cart_item_params[:quantity])

        if @cart_item.save
            render json: @cart_item, status: :created
        else
            render json: @cart_item.errors, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /cart_items/1
    def update
        if @cart_item.update(dish_params)
            render json: @cart_item.errors
        else
            render json: @cart_item.errors.errors, status: :unprocessable_entity
        end
    end

    # DELETE /dishes/1
    def destroy
        @cart_item.destroy
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_cart
            @cart = @current_user.cart
            unless @cart
                @cart = @current_user.build_cart(discount: 0, restaurant_id: @restaurant_id)
                begin
                    @cart.save!
                rescue ActiveRecord::RecordInvalid => invalid
                    render json: invalid.record.errors, status: :unprocessable_entity
                end
            end
        end

        def set_cart_item
            @cart_item = @cart.cart_items.find(params[:id])
        end

        def set_restaurant_id
            @restaurant_id = params[:restaurant_id]
        end

        def set_dish_id
            @dish_id = params[:dish_id]
        end

        # Only allow a list of trusted parameters through.
        def cart_item_params
            params.require(:cart_item).permit(:quantity)
        end
end
