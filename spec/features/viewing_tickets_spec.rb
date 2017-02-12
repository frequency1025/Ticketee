require "rails_helper"
require "support/authorization_helpers.rb"

RSpec.feature "Users can view tickets" do

  before do
    
    author = FactoryGirl.create(:user)


  	sublime = FactoryGirl.create(:project, name: "Sublime Text 3")
    assign_role!(author, :viewer, sublime)
  	FactoryGirl.create(:ticket, project: sublime, author: author,
  		name: "Make it shiny!",
  		description: "Gardients! Starbursts! Oh my!")

  	ie = FactoryGirl.create(:project, name: "Internet Explorer")
    assign_role!(author, :viewer, ie)
  	FactoryGirl.create(:ticket, project: ie, author: author,
  		name: "Standards compliance", description: "Isn't a joke.")

    login_as(author)

  	visit "/"

  end

  scenario "for a given project" do
  	
    click_link "Sublime Text 3"
  	
  	expect(page).to have_content "Make it shiny!"

  end
	
end