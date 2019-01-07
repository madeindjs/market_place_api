# app/controllers/api/v1/orders_controller.rb
class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_with_token!

  def index
    orders = current_user.orders.page(params[:page]).per(params[:per_page])
    render(
      json: orders,
      meta: pagination(orders)
    )
  end

  def show
    render json: current_user.orders.find(params[:id])
  end

  def create
    order = Order.create! user: current_user
    order.build_placements_with_product_ids_and_quantities(params[:order][:product_ids_and_quantities])

    if order.save
      order.reload # need to reload associations
      OrderMailer.send_confirmation(order).deliver
      render json: order, status: 201, location: [:api, current_user, order]
    else
      render json: { errors: order.errors }, status: 422
    end
  end
end
