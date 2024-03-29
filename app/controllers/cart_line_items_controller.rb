# frozen_string_literal: true

class CartLineItemsController < StoreController
  helper 'spree/products', 'orders'

  respond_to :html

  before_action :store_guest_token

  include SolidusSubscriptions::SubscriptionLineItemBuilder
  after_action :handle_subscription_line_items, only: :create, if: -> { params[:subscription_line_item] }

  # Adds a new item to the order (creating a new order if none already exists)
  def create
    @order = current_order(create_order_if_necessary: true)
    authorize! :update, @order, cookies.signed[:guest_token]

    variant  = Spree::Variant.find(params[:variant_id])
    quantity = params[:quantity].present? ? params[:quantity].to_i : 1
    # interval_length = params[:interval_length]
    # interval_units = params[:interval_units]
    # subscribable_id = params[:subscribable_id]
    # need to pass all 4 parameters

    # 2,147,483,647 is crazy. See issue https://github.com/spree/spree/issues/2695.
    if !quantity.between?(1, 2_147_483_647)
      @order.errors.add(:base, t('spree.please_enter_reasonable_quantity'))
    else
      begin
        @line_item = @order.contents.add(variant, quantity)
      rescue ActiveRecord::RecordInvalid => error
        @order.errors.add(:base, error.record.errors.full_messages.join(", "))
      end
    end

    respond_with(@order) do |format|
      format.html do
        if @order.errors.any?
          flash[:error] = @order.errors.full_messages.join(", ")
          redirect_back_or_default(root_path)
          return
        else
          redirect_to edit_cart_path
        end
      end
    end
  end

  # def create_subscription_line_item(line_item)
  # end

  private

  def store_guest_token
    cookies.permanent.signed[:guest_token] = params[:token] if params[:token]
  end

  def handle_subscription_line_items
    line_item = @current_order.line_items.find_by(variant_id: params[:variant_id])
    create_subscription_line_item(line_item)
  end
end
