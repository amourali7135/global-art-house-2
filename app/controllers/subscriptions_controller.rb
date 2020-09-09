class SubscriptionsController < ApplicationController

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new
  end

  # POST /subscriptions
  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.save
      flash[:notice] = "You've been successfully added to our subscription list'!"
      redirect_to root_path
    else
      flash[:notice] = "There was an error, please try again!"
      redirect_to root_path
    end
    raise
  end

  # DELETE /subscriptions/1
  def destroy
    @collaboration = Collaboration.find(params[:id])
    # @collaboration = Collaboration.find(params[:id])
    @collaboration.destroy
    flash[:notice] = "Your collaboration was successfully deleted!"
    redirect_to dashboard_path
  end



  private

  # Only allow a trusted parameter "white list" through.
  def subscription_params
    params.require(:subscription).permit(:email)
  end

end
