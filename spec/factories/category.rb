FactoryBot.define do
  factory :category do
    name {Faker::Name}
    deleted_at {""}
  end

  factory :invalid_category, parent: :category do
    name {nil}
    deleted_at {""}
  end
end
