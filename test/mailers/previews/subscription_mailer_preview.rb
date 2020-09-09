class SubscriptionMailerPreview < ActionMailer::Preview

  def success
    subscription = Subscription.first
    # This is how you pass value to params[:subscription] inside mailer definition!
    SubscriptionMailer.with(subscription: subscription).success
  end

end
