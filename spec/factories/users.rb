FactoryGirl.define do
  factory :user do
    name { FFaker::Name.name }
    email "prueba@alumnos.upm.es"
    password "12345678"
    password_confirmation "12345678"
  end
end
