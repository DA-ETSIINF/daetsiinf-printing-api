FactoryGirl.define do
  factory :user do
    name { FFaker::Name.name }
    email { "#{('a'..'z').to_a.shuffle[0..7].join}@alumnos.upm.es" }
    password "12345678"
    password_confirmation "12345678"
  end
end
