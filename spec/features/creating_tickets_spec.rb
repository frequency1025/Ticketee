require "rails_helper"
require "support/authorization_helpers.rb"

RSpec.feature "Users can create new tickets" do

  let(:user) {FactoryGirl.create(:user)}
  let!(:state) {FactoryGirl.create :state, name: "New", default: true }

  before do

    login_as(user)
    
    project = FactoryGirl.create(:project, name: "Internet Explorer")
    

    assign_role!(user, :editor, project)

    visit project_path(project)
    click_link "New Ticket"
  end

  scenario "with valid attributes" do

    fill_in "Name" , with: "Non-standard compliance"
    fill_in "Description", with: "My pages are ugly"
    click_button "Create Ticket"

    expect(page).to have_content "Ticket has been created."
    expect(page).to have_content "State: New"
  end

  scenario "when providing invalid attributes" do
    click_button "Create Ticket"

    expect(page).to have_content "Ticket has not been created."
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Description can't be blank"
  end

  scenario "with an invalid description" do
    fill_in "Name" , with: "Non-standard compliance"
    fill_in "Description", with: "Tt sucks"
    click_button "Create Ticket"

    expect(page).to have_content "Ticket has not been created."
    expect(page).to have_content "Description is too short"
  end

  scenario "with an invalid description" do
    fill_in "Name" , with: "Non-standard compliance"
    fill_in "Description", with: "My pages are ugly!"
    click_button "Create Ticket"

    expect(page).to have_content "Ticket has been created."
    within("#ticket") do
      expect(page).to have_content "Author: #{user.email}"
    end
  end


  scenario "with associated tags" do
    fill_in "Name", with: "Non-standard compliance"
    fill_in "Description", with: "My pages are ugly!"
    fill_in "Tags", with: "brower visual"
    click_button "Create Ticket"

    expect(page).to have_content "Ticket has been created."
    within("#ticket") do
      expect(page).to have_content "brower"
      expect(page).to have_content "visual"
    end
  end


  


=begin
  scenario "with an attachment" do

    fill_in "Name" , with: "Add documentation for blink tag"
    fill_in "Description", with: "The blink tag has a speed attribute"
    attach_file "File", "spec/fixtures/speed.txt"

    click_button "Create Ticket"

    expect(page).to have_content "Ticket has been created."

    within("#ticket .attachment") do #此处有一个空格才能正确的获取css选择器
      expect(page).to have_content "speed.txt"
    end
  end


  scenario "persisting file uploads across form displays" do
    attach_file "File #1", "spec/fixtures/speed.txt"
    click_button "Create Ticket"

    fill_in "Name", with: "Add documentation for blink tag"
    fill_in "Description", with: "The blink tag has a speed attribute"

    click_button "Create Ticket"

    within("#ticket .attachment") do #此处有一个空格才能正确的获取css选择器
      expect(page).to have_content "speed.txt"
    end
  end


  scenario "with multiple attachments" do
    fill_in "Name", with: "Add documentation for blink tag"
    fill_in "Description", with: "The blink tag has a speed attribute"

    attach_file "File #1", Rails.root.join("spec/fixtures/speed.txt")
    attach_file "File #2", Rails.root.join("spec/fixtures/spin.txt")
    attach_file "File #3", Rails.root.join("spec/fixtures/gradient.txt")
    
    click_button "Create Ticket"

    within("#ticket .attachments") do #此处有一个空格才能正确的获取css选择器
      expect(page).to have_content "speed.txt"
      expect(page).to have_content "spin.txt"
      expect(page).to have_content "gradient.txt"
    end
  end



  scenario "with multiple attachments", js: true do
    fill_in "Name" , with: "Add documentation for blink tag"
    fill_in "Description", with: "Blink tag's speed attribute"
    
    attach_file "File #1", Rails.root.join("spec/fixtures/speed.txt")
    click_link "Add another file"

    attach_file "File #2", Rails.root.join("spec/fixtures/spin.txt")

    click_button "Create Ticket"

    expect(page).to have_content "Ticket has been created."

    
      within("#ticket .attachments") do
        expect(page).to have_content "speed.txt"
        expect(page).to have_content "spin.txt"
      end
  end
=end

end