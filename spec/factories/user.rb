FactoryBot.define do
  factory :user do
    first_name  "Carlos"
    second_name "Andres"
    last_name   "Torres"
    maiden_name "Lopez"
    email       "carlos@mail.com"
    password    12345678
  end
end
