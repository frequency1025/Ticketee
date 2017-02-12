require "rails_helper"
require "support/authorization_helpers.rb"

RSpec.feature "Users can delete tickets" do
	let(:author) { FactoryGirl.create(:user)}
	let(:project) { FactoryGirl.create(:project) }
	let(:ticket) { FactoryGirl.create(:ticket,project: project,author: author) }

	before do
		login_as(author)
		assign_role!(author, :manager, project)
		visit project_ticket_path(project,ticket)
	end

	scenario "with valid attributes" do

		click_link "Delete Ticket"

		expect(page).to have_content "Ticket has been deleted."
		expect(page.current_url).to eq project_url(project)
	end
end