require 'rails_helper'

RSpec.describe "Tasks", type: :request do

  describe "GET /tasks" do
    before do
      @user = FactoryBot.create(:user)
      @task = FactoryBot.create(:task, user: @user)
      @subtask = FactoryBot.create(:subtask, task: @task)
    end

    # ユーザーがログインしていない場合のテスト
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされる' do
        get tasks_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    # ユーザーがログインしている場合のテスト
    context 'ログインしている場合' do
      before do
        sign_in @user
        get tasks_path
      end

      it 'レスポンスが正常に表示される' do
        expect(response.status).to eq 200
      end

      it '投稿されているタスクが一覧で表示される' do
        expect(response.body).to include(@task.task_title)
        expect(response.body).to include(@task.task_deadline.strftime("%Y-%m-%d"))
      end

      it '重要度が高いタスクはパトランプが表示される' do
        @task.importance_status_id = 1 
        expect(response.body).to include('important-image')
      end
      
      it '緊急度が高いタスクは緊急アイコンが表示される' do
        @subtask.update(subtask_deadline: 2.days.from_now.to_date)
        expect(response.body).to include("pato-image")
      end
      
    end
  end
end
