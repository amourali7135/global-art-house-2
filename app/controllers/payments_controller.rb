class PaymentsController < ApplicationController
  def index
  end

  def new
    @order = current_user.orders.where(state: 'pending').find(params[:order_id])
  end

  def create
  end

  def show
  end

  def update
  end

  def delete
  end

  def edit
  end
end
