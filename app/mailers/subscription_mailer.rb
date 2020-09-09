class SubscriptionMailer < ApplicationMailer

  def success
    @subscription = params[:subscription] # Instance variable => available in view
    mail(to: @subscription.email, subject: 'Thanks for your interest!')
    # This will render a view in `app/views/user_mailer`!
  end

end
