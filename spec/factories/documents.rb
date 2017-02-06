FactoryGirl.define do
  factory :document do
    name { FFaker::Name.name }
    url { FFaker::Internet.http_url }
    pages "15"
    folder
  end
end
