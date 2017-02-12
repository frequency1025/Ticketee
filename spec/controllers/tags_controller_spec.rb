require 'rails_helper'

RSpec.describe TagsController, type: :controller do

  describe "GET #remove" do
    it "returns http success" do
      get :remove
      expect(response).to have_http_status(:success)
    end
  end

end
