FactoryBot.define do
  factory :invite do
    association :admin
    association :company
    name { Faker::Lorem.word }
  end
end
