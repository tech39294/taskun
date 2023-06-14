require 'rails_helper'

RSpec.describe TaskTemplate, type: :model do
  before do
    @task_template = FactoryBot.build(:task_template)
  end

  describe 'タスクテンプレート作成機能' do
    context 'タスクテンプレートが作成できるとき' do
      it '全ての項目が存在すれば作成できる' do
        expect(@task_template).to be_valid
      end
    end

    context 'タスクテンプレートが作成できないとき' do
      it 'タイトルが空では作成できない' do
        @task_template.task_template_title = ''
        @task_template.valid?
        expect(@task_template.errors.full_messages).to include("Task template title can't be blank")
      end

      it '日数が空では作成できない' do
        @task_template.task_template_days = ''
        @task_template.valid?
        expect(@task_template.errors.full_messages).to include("Task template days can't be blank")
      end

      it 'サブタスクの日数だけでは保存できない' do
        @task_template.subtask_templates = [FactoryBot.build(:subtask_template, subtask_template_title: Faker::Lorem.sentence, subtask_template_days: nil)]
        @task_template.valid?
        expect(@task_template.errors.full_messages).to include("Subtask templates base Subtask title and deadline must be both present or absent")
      end
    
      it 'サブタスクのタイトルだけでは保存できない' do
        @task_template.subtask_templates = [FactoryBot.build(:subtask_template, subtask_template_title: nil, subtask_template_days: Faker::Number.between(from: 1, to: 30))]
        @task_template.valid?
        expect(@task_template.errors.full_messages).to include("Subtask templates base Subtask title and deadline must be both present or absent")
      end
    end
  end
end
