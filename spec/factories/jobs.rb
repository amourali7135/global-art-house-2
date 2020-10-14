FactoryBot.define do
  factory :job do
    title { "MyString" }
    description { "MyText" }
    requirements { "MyText" }
    salary { "MyString" }
    photo { "MyString" }
    remote { false }
    city { "MyString" }
    country { "MyString" }
    latitude { 1.5 }
    longitude { 1.5 }
    company { "MyString" }
    seniority { "MyString" }
    industry { "MyString" }
    benefits { "MyText" }
    why { "MyText" }
    frequency { "MyString" }
    preferred { "MyText" }
    user { nil }
  end
end
