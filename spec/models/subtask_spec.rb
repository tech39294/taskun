require 'rails_helper'

RSpec.describe Subtask, type: :model do
  before do
    @subtask = FactoryBot.build(:subtask)
  end

  describe 'サブタスク作成機能' do
    context 'サブタスクが作成できるとき' do
      it '全ての項目が存在すれば作成できる' do
        expect(@subtask).to be_valid
      end

      it 'タイトルと期限が両方空でも作成できる' do
        @subtask.subtask_title = ''
        @subtask.subtask_deadline = ''
        expect(@subtask).to be_valid
      end
    end

    context 'サブタスクが作成できないとき' do
      it 'タイトルだけが存在するときは作成できない' do
        @subtask.subtask_title = 'Test Subtask'
        @subtask.subtask_deadline = ''
        @subtask.valid?
        expect(@subtask.errors.full_messages).to include('Subtask title and deadline must be both present or absent')
      end

      it '期限だけが存在するときは作成できない' do
        @subtask.subtask_title = ''
        @subtask.subtask_deadline = '2023-06-10'
        @subtask.valid?
        expect(@subtask.errors.full_messages).to include('Subtask title and deadline must be both present or absent')
      end

      it 'タスクが関連付けられていなければ作成できない' do
        @subtask.task = nil
        @subtask.valid?
        expect(@subtask.errors.full_messages).to include('Task must exist')
      end
    end
  end
end
