FactoryBot.define do
  factory :task do
    task_title { Faker::Lorem.sentence(word_count: 3) }
    task_deadline { Faker::Date.forward(days: 30) }
    importance_status_id { Faker::Number.between(from: 1, to: 2) }
    memo { Faker::Lorem.paragraph }
    association :user
  end
end
