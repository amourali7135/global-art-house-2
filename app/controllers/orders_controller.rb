class OrdersController < ApplicationController
  def index
  end

  def new
  end

  def create
    art = Art.find(params[:art_id])
    order  = Order.create!(art: art, art_sku: art.sku, amount: art.price, state: 'pending', user: current_user)

    session = Stripe::Checkout::Session.create(
    payment_method_types: ['card'],
    line_items: [{
    name: art.sku,
    images: [art.photo_url],
    amount: art.price_cents,
    currency: 'usd',
    quantity: 1
    }],
    success_url: order_url(order),
    cancel_url: order_url(order)
    )

    order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(order)
  end

  def show
  end

  def update
  end

  def delete
  end

  def edit
    @order = current_user.orders.find(params[:id])
  end
end
