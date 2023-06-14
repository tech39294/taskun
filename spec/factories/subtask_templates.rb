FactoryBot.define do
  factory :subtask_template do
    subtask_template_title { Faker::Lorem.sentence }
    subtask_template_days { Faker::Number.between(from: 1, to: 30) }
    task_template { association(:task_template) }
  end
end
