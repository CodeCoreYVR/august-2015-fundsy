FactoryGirl.define do
  factory :campaign do
    sequence(:title)        { Faker::Company.bs      }
    sequence(:description)  { Faker::Lorem.paragraph }
    sequence(:goal)         { 10 + rand(100000000)   }
    sequence(:end_date)     { Time.now + 30.days     }
  end
end
