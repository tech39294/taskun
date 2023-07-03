require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'PUT /users/:id' do
    before do
      @user = FactoryBot.create(:user)
    end

    context '更新内容に問題ない場合' do
      it 'usernameを編集できる' do
        sign_in @user
        new_username = 'newuser'
        patch "/users/#{@user.id}", params: { user: { username: new_username } }
        expect(response).to redirect_to(user_path(@user)) 
        follow_redirect!  
        expect(response).to have_http_status(:ok)
        expect(@user.reload.username).to eq(new_username)
      end

      it 'emailを編集できる' do
        sign_in @user
        new_email = 'newemail@email'
        patch "/users/#{@user.id}", params: { user: { email: new_email } }
        expect(response).to redirect_to(user_path(@user))  
        follow_redirect!  # リダイレクトを追跡
        expect(response).to have_http_status(:ok)
        expect(@user.reload.email).to eq(new_email)
      end
    end
  end

  describe 'DELETE /users/:id' do
    before do
      @user = FactoryBot.create(:user)
      sign_in @user
    end

    it 'アカウントを論理削除できる' do
      patch withdrawal_path(@user)
      expect(@user.reload.is_deleted).to be true   
      expect(response).to redirect_to(root_path)  
    end
  end

end