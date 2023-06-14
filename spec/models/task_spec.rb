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

      it 'メモが空でも作成できる' do
        @task_template.memo = ''
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
    end
  end
end
