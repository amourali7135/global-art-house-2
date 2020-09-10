class Subscription < ApplicationRecord
  # after_create :send_email_to_new_subscribers
  # skip_before_action :authenticate_user!, only: [:new, :create, :destroy ]

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  private

  # def send_email_to_new_subscribers
  #   Subscription.all.each do |subscriber|
  #     SubscriptionMailer.send_email(subscriber.email,self)
  #   end
  # end

end
