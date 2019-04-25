require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  include Devise::TestHelpers
  let(:user) { FactoryBot.create(:user) }

  before do
      sign_in user
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template(:index)
    end

    it "redirect if not logged in" do
      sign_out user
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    it "has all tags in system" do
      tag = FactoryBot.create(:tag)
      get :index
      expect(assigns(:tags)).to match_array([tag])
    end

    it "has all tags in system" do
      tag = FactoryBot.create(:tag)
      get :index
      expect(assigns(:tags)).to match_array([tag])
    end

    it "user tags are correct" do
      new_tags = FactoryBot.create_list(:tag, 6)
      user.tags = [new_tags[1], new_tags[3], new_tags[5]]
      user.save
      get :index
      expect(assigns(:user).tags).to match_array([new_tags[1], new_tags[3], new_tags[5]])
    end
  end

  describe "POST #create" do
    it "edit tags correctly" do
      new_tags = FactoryBot.create_list(:tag, 6)
      user.tags = [new_tags[1], new_tags[3], new_tags[5]]
      user.save
      patch :create, params: { options: [new_tags[0], new_tags[1], new_tags[4]] }
      expect(user.reload.tags).to match_array([new_tags[0], new_tags[1], new_tags[4]])
    end
  end
end
