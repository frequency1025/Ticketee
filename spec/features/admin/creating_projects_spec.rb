require "rails_helper"

RSpec.feature "Users can create new projects" do

  before do 
    login_as(FactoryGirl.create(:user, :admin))
  end


  scenario "with valid attributes" do
  	visit "/"

  	click_link "New Project"

  	fill_in "Name", with: "Sublime Text 3"
  	fill_in "Description", with: "A text editor for everyone"
  	click_button "Create Project"

  	expect(page).to have_content "Project has been created."

  	project = Project.find_by(name: "Sublime Text 3")
  	expect(page.current_url).to eq project_url(project)

  	title = "Sublime Text 3 - Projects - Ticketee"
  	expect(page).to have_title title

  end

  scenario "when providing invalid attributes" do

    visit "/"

    click_link "New Project"
    click_button "Create Project"

    expect(page).to have_content "Project has not been created."
    expect(page).to have_content "Name can't be blank"

  end
	
end