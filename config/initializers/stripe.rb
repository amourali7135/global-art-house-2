Rails.configuration.stripe = {
  publishable_key: ENV['pk_test_6OtMVbzY1od1kVYNuzBJX0nK00bGeHEneH'],
  secret_key:      ENV['sk_test_2nSBnvRu8MsAzjXm08x9eIgw00D9Fgss4H']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]