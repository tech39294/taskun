require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  describe 'GET /tasks' do
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
        expect(response.body).to include(@task.task_deadline.strftime('%Y-%m-%d'))
      end

      it '重要度が高いタスクはパトランプが表示される' do
        @task.importance_status_id = 1
        @task.save
        expect(response.body).to include('important-image')
      end

      it '緊急度が高いタスクは緊急アイコンが表示される' do
        @subtask.update(subtask_deadline: 2.days.from_now.to_date)
        expect(response.body).to include('pato-image')
      end
    end
  end

  describe 'GET #show' do
    before do
      @user = FactoryBot.create(:user)
      @task = FactoryBot.create(:task, user: @user)
      @subtask = FactoryBot.create(:subtask, task: @task)
    end

    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトすること' do
        get task_path(@task.id)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'ログインしている場合' do
      before do
        sign_in @user
      end

      context 'タスクの投稿者の場合' do
        it '詳細表示ページへ遷移すること' do
          get task_path(@task.id)
          expect(response.status).to eq 200
        end

        it 'タスクの詳細が表示されること' do
          get task_path(@task.id)
          expect(response.body).to include(@task.task_title)
          expect(response.body).to include(@task.task_deadline.to_s)
          expect(response.body).to include(@task.memo)
        end
      end
    end

    context 'タスクの投稿者ではない場合' do
      let(:other_user) { FactoryBot.create(:user) }
      let(:other_task) { FactoryBot.create(:task, user: other_user) }
      let(:other_subtask) { FactoryBot.create(:subtask, task: other_task) }

      it '一覧ページにリダイレクトすること' do
        sign_in other_user
        get task_path(@task.id)
        expect(response).to redirect_to(tasks_path)
      end
    end
  end

  describe "GET #edit" do
    before do
      @user = FactoryBot.create(:user)
      @task = FactoryBot.create(:task, user: @user)
      @another_task = FactoryBot.create(:task)
    end
    context '編集ができる場合' do
      it 'ログイン状態で自身が投稿したタスクの編集ページに遷移しようとした場合遷移できる' do
        sign_in @user
        get edit_task_path(@task)
        expect(response).to have_http_status(:ok)
      end

      it '必要な情報が適切に入力されていればタスク情報を編集できる' do
        sign_in @user
        patch task_path(@task), params: { task: { task_title: 'updated_title' } }
        expect(Task.find(@task.id).task_title).to eq 'updated_title'
      end

      it 'タスク詳細ページへ遷移する' do
        sign_in @user
        patch task_path(@task), params: { task: { title: 'updated_title' } }
        expect(response).to redirect_to task_path(@task)
      end
    end

    context '編集ができない場合' do

      it 'ログイン状態でも自身が投稿していないタスクの編集ページに遷移しようとした場合トップページに遷移する' do
        sign_in @user
        get edit_task_path(@another_task)
        expect(response).to redirect_to tasks_path
      end

      it 'ログアウト状態で編集ページに遷移しようとした場合ログインページに遷移する' do
        get edit_task_path(@task)
        expect(response).to redirect_to new_user_session_path
      end

      it '何も編集せずに更新を試みた場合元の状態が維持される' do
        original_title = @task.task_title
        sign_in @user
        patch task_path(@task), params: { task: { task_title: 'original_title' } }
        expect(Task.find(@task.id).task_title).to eq 'original_title'
      end

      it '空の入力欄がある場合編集できずにそのページに留まる' do
        sign_in @user
        patch task_path(@task), params: { task: { task_title: '' } }
        expect(@task.reload.task_title).not_to eq('')
      end
    end
  end
end
