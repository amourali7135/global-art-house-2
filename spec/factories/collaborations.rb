FactoryBot.define do
  factory :collaboration do
    title { "MyString" }
    description { "MyText" }
    goal { "MyText" }
    photo { "MyString" }
    artist { nil }
  end
end
