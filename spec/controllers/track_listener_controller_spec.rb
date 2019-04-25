require 'rails_helper'

RSpec.describe TrackListenerController, type: :controller do
  include Devise::TestHelpers
  let(:user) { FactoryBot.create(:user) }
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "redirect if not logged in" do
      sign_out user
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    it "show tracks of user" do
      new_tracks = FactoryBot.create_list(:track, 4)
      new_tags = FactoryBot.create_list(:tag, 6)
      new_trackTags = FactoryBot.create_list(:track_tag, 5)
      new_trackTags[1].track_id = 1
      new_trackTags[1].tag_id = 1
      new_trackTags[2].track_id = 3
      new_trackTags[2].tag_id = 1
      new_trackTags[3].track_id = 2
      new_trackTags[3].tag_id = 2
      new_tracks[1].tags = [new_tags[1]]
      new_tracks[2].tags = [new_tags[2]]
      new_tracks[3].tags = [new_tags[1]]
      user.tags = [new_tags[1], new_tags[3], new_tags[5]]
      user.save
      get :index
      expect(assigns(:tracks)).to match_array([new_tracks[1], new_tracks[3]])
    end

  end

end
