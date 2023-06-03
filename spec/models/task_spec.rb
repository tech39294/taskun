require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    @task = FactoryBot.build(:task)
  end

  describe 'タスク作成機能' do
    context 'タスクが作成できるとき' do
      it '全ての項目が存在すれば作成できる' do
        expect(@task).to be_valid
      end

      it 'メモが空でも作成できる' do
        @task.memo = ''
        expect(@task).to be_valid
      end
    end

    context 'タスクが作成できないとき' do
      it 'タイトルが空では作成できない' do
        @task.task_title = ''
        @task.valid?
        expect(@task.errors.full_messages).to include("Task title can't be blank")
      end

      it '期限が空では作成できない' do
        @task.task_deadline = ''
        @task.valid?
        expect(@task.errors.full_messages).to include("Task deadline can't be blank")
      end

      it '重要度が空では作成できない' do
        @task.importance_status_id = ''
        @task.valid?
        expect(@task.errors.full_messages).to include("Importance status can't be blank")
      end

      it '重要度が1または2以外では作成できない' do
        @task.importance_status_id = 3
        @task.valid?
        expect(@task.errors.full_messages).to include('Importance status is not included in the list')
      end

      it 'ユーザーが関連付けられていなければ作成できない' do
        @task.user = nil
        @task.valid?
        expect(@task.errors.full_messages).to include('User must exist')
      end
    end
  end
end
