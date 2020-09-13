FactoryBot.define do
  factory :lesson do
    title { "MyString" }
    subdescription { "MyString" }
    description { "MyText" }
    learnings { "MyText" }
    rating { 1 }
    students { 1 }
    prerequisites { "MyText" }
    free { false }
    price_cents { 1 }
    artist { nil }
  end
end
