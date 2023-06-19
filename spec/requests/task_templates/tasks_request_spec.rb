require 'rails_helper'

RSpec.describe 'TaskTemplates::Tasks', type: :request do
  before do
    @user = FactoryBot.create(:user) 
    @task_template = FactoryBot.create(:task_template)  
    sign_in @user 
  end

  describe 'POST /create' do
    context 'タスクが作成できるとき' do
      it '全ての項目が存在すれば作成できる' do
        task_attributes = FactoryBot.attributes_for(:task, user_id: @user.id, task_template_id: @task_template.id)
        expect {
          post task_template_tasks_path(@task_template), params: { task: task_attributes }
        }.to change(Task, :count).by(1)
        expect(response).to redirect_to(Task.last)
      end

      it 'メモが空でも作成できる' do
        task_attributes = FactoryBot.attributes_for(:task, user_id: @user.id, task_template_id: @task_template.id, memo: '')
        expect {
          post task_template_tasks_path(@task_template), params: { task: task_attributes }
        }.to change(Task, :count).by(1)
        expect(response).to redirect_to(Task.last)
      end
    end

    context 'タスクが作成できないとき' do
      it 'タスクのタイトルが空では作成できない' do
        task_attributes = FactoryBot.attributes_for(:task, user_id: @user.id, task_template_id: @task_template.id)
        task_attributes[:task_title] = ''
        expect {
          post task_template_tasks_path(@task_template), params: { task: task_attributes }
        }.not_to change(Task, :count)
        expect(response).to have_http_status(200)
      end
      

      it 'タスクの期限が空では作成できない' do
        task_attributes = FactoryBot.attributes_for(:task, user_id: @user.id, task_template_id: @task_template.id)
        task_attributes[:task_deadline] = nil
        expect {
          post task_template_tasks_path(@task_template), params: { task: task_attributes }
        }.not_to change(Task, :count)
        expect(response).to have_http_status(200)
      end  
    end
  end
end
