FactoryBot.define do
  factory :subtask do
    subtask_title { Faker::Lorem.sentence(word_count: 3) }
    subtask_deadline { 3.days.from_now.to_date }
    association :task
  end
end
