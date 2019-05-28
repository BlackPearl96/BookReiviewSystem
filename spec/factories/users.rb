FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password {"1234567899"}
    password_confirmation {"1234567899"}
  end

  factory :invalid_users, parent: :user do
    name {nil}
    email {nil}
    password {""}
    password_confirmation {""}
  end
end

FactoryBot.define do
  factory :admin, class: User do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password {"1234567899"}
    password_confirmation {"1234567899"}
    role {1}
  end
end

FactoryBot.define do
  factory :invalid_user, class: User do
    name {"CuongTanPhu"}
    email {"lqcuong.qt@gmail.com"}
    password {"1234567899"}
    password_confirmation {"1234567899"}
  end
end
