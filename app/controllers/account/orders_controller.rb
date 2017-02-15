class Account::OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    @orders = current_user.orders.order("created_at DESC")
  end

  def show
    @order = current_user.orders.find_by_token(params[:id])
    @product_lists = @order.product_lists
  end

  def apply_to_cancel
    @order = Order.find_by_token(params[:id])
    OrderMailer.apply_cancel(@order).deliver!
    flash[:notice] = "已提交申请"
    redirect_to :back
  end

end
