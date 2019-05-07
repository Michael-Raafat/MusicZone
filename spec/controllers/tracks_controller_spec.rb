require 'rails_helper'

RSpec.describe TracksController, type: :controller do
  include Devise::TestHelpers
  let(:user) { FactoryBot.create(:user) }

  before do
      sign_in user
  end

  describe "GET #index" do
     it "redirect when user have no tags" do
       get :index
       expect(response).to have_http_status(:redirect)
     end

     it "redirect if not logged in" do
       sign_out user
       get :index
       expect(response).to redirect_to(new_user_session_path)
     end

    it "show tracks of user" do
      new_tracks = FactoryBot.create_list(:track, 4)
      new_tags = FactoryBot.create_list(:tag, 6)
      TrackTag.create(:track => new_tracks[0], :tag => new_tags[0])
      TrackTag.create(:track => new_tracks[2], :tag => new_tags[0])
      TrackTag.create(:track => new_tracks[1], :tag => new_tags[2])
      UserTag.create(:user => user, :tag => new_tags[0])
      get :index
      expect(assigns(:tracks)).to match_array([new_tracks[0], new_tracks[2]])
    end

    it "search tracks for single track" do
      new_tracks = FactoryBot.create_list(:track, 4)
      get :index, :params => {track: new_tracks[0].title}
      expect(assigns(:tracks)).to match_array([new_tracks[0]])
    end

    it "search tracks for multi track" do
      new_tracks = FactoryBot.create_list(:track, 6)
      new_tracks[1].title = new_tracks[0].title + 'a'
      new_tracks[2].title = 'a' + new_tracks[0].title
      new_tracks[3].title = 'a' + new_tracks[0].title + 'a'
      new_tracks[1].save
      new_tracks[2].save
      new_tracks[3].save
      get :index, :params => {track: new_tracks[0].title}
      expect(assigns(:tracks)).to match_array([new_tracks[0], new_tracks[1], new_tracks[2], new_tracks[3]])
    end

    it "search tracks for no track" do
      new_tracks = FactoryBot.create_list(:track, 4)
      get :index, :params => {track: 'wrong unmatched title #201231203'}
      expect(assigns(:tracks)).to match_array([])
    end

  end
end
