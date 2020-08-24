FactoryBot.define do
  factory :service do
    title { "MyString" }
    description { "MyText" }
    price_cents { 1 }
    length { "MyString" }
    photo { "MyString" }
    artist { nil }
  end
end
