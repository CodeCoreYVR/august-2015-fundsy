FactoryGirl.define do
  factory :reward do
    sequence(:description) { Faker::Company.catch_phrase }
    sequence(:amount)      { 1 + rand(500)               }
  end

end
