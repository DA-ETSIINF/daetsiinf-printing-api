FactoryGirl.define do
  factory :folder do
    name { FFaker::Name.name }
    user
  end
end
