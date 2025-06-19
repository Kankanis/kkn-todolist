FactoryBot.define do
  factory :quest do
    name { "My Default Quest" }
    status { false }
    trait :completed do
      status { true }
    end
  end
end
