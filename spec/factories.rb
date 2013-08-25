FactoryGirl.define do 
  factory :user do
    name "Rui Cheng"
    email "ktei2008@gmail.com"
    password "blizzard"
  end

  sequence :email do |n|
    "user-#{n}@test.com"
  end

  factory :album do |album|
    album.title "foobar"
    album.description "foobar desc"
    album.association :user
  end

  factory :photo do |photo|
    photo.description "foobar desc"
    photo.association :album
  end
end