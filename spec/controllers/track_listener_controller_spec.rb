require 'rails_helper'

RSpec.describe TrackListenerController, type: :controller do
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

  end

end
