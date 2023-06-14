FactoryBot.define do
  factory :task_template do
    task_template_title { Faker::Lorem.sentence }
    task_template_days { Faker::Number.between(from: 1, to: 30) }
    user { association(:user) }
  end
end

