FactoryBot.define do
  factory :subtask do
    subtask_title { Faker::Lorem.sentence(word_count: 3) }
    subtask_deadline { Faker::Date.forward(days: 30) }
    association :task 
  end
end
