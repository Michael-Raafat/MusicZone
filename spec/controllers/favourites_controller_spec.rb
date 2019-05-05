require 'rails_helper'

RSpec.describe FavouritesController, type: :controller do
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

    it "gets the correct favourite tracks" do
      tracks = FactoryBot.create_list(:track, 4)
      favourite_tracks = [tracks[1], tracks[3]]
      user.favourites = favourite_tracks
      user.save
      get :index
      expect(assigns(:tracks)).to match_array(favourite_tracks)
    end
  end

  describe "POST #create" do
    it "add track to favourites correctly" do
      tracks = FactoryBot.create_list(:track, 4)
      patch :create, params: { trackId: tracks[2].id.to_s }
      expect(user.reload.favourites).to match_array([tracks[2]])
    end

    it "remove track from favourites correctly" do
      tracks = FactoryBot.create_list(:track, 4)
      user.favourites = [tracks[2], tracks[3]]
      patch :create, params: { trackId: tracks[2].id.to_s }
      expect(user.reload.favourites).to match_array([tracks[3]])
    end
  end
end
