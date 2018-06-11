FactoryBot.define do
  factory :interest do
    first_name  "Arte"
    user { User.first || association(:user) }
  end
end
