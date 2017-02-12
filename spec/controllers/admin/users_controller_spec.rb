require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do

let(:user){FactoryGirl.create(:user)}

 before do
 	allow(controller).to receive(:authenticate_user!)
 	allow(controller).to receive(:current_user).and_return(user) #stubbing he current_user
 end

 context "non_admin users" do
 	it "are not able to access the index action" do
 		get :index

 		expect(response).to redirect_to "/"
 		expect(flash[:alert]).to eq "You must be an admin to do that."
 	end
 end

=begin 
  describe "GET #index" do
    it "returns http success" do

      get :index
      expect(response).to have_http_status(:success)
    end
  end
=end

end
