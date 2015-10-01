FactoryGirl.define do
  factory :pledge do
    user nil
campaign nil
amount 1
stripe_txn_id "MyString"
aasm_state "MyString"
  end

end
