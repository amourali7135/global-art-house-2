class OrdersController < ApplicationController
  def index
  end

  def new
  end

  def create
    # art = Art.find(params[:art_id])
    art = Art.find(params[:id])
    # art_photos = []
    # Art.find(params[:art_id]).photos.each do |pic|
    # art_photos << pic
    # end

    order  = Order.create!(art: art, art_sku: art.sku, amount: art.price_cents, state: 'pending', user: current_user)

    session = Stripe::Checkout::Session.create(
    payment_method_types: ['card'],
    line_items: [{
    name: art.title,
    images: [art.photos.first],
    # each do |photo|
    # cl_image_tag(photo.photo, width: 500, height: 400, crop: :fill)
    # end,
    amount: art.price_cents * 100,
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
    @order = current_user.orders.find(params[:id])
    # raise
  end

  def update
  end

  def delete
  end

  def edit
    @order = current_user.orders.find(params[:id])
  end
end
