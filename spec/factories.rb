FactoryGirl.define do 
  factory :user do
    name "Rui Cheng"
    email "ktei2008@gmail.com"
    password "blizzard"
  end

  sequence :email do |n|
    "user-#{n}@test.com"
  end
end