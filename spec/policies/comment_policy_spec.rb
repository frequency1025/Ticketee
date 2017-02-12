require "rails_helper"
require "support/authorization_helpers.rb"
require "support/pundit_matcher.rb"

RSpec.describe CommentPolicy do

  context "permissions" do
    
    subject { CommentPolicy.new(user,comment) }

    let(:user) { FactoryGirl.create(:user) }
    let(:project) { FactoryGirl.create(:project) }
    let(:ticket) { FactoryGirl.create(:ticket, project: project) }
    let(:comment) { FactoryGirl.create(:comment, ticket: ticket)}

    context "for anonymous users" do 
      let(:user) { nil }
      it { should_not permit_action :create }
    end

    context "for viewers of project" do 
      before { assign_role!(user, :viewer, project) }
      it { should_not permit_action :create }
    end

    context "for editors of project" do 
      before { assign_role!(user, :editor, project) }
      it { should permit_action :create }
    end

    context "for managers of project" do 
      before { assign_role!(user, :manager, project) }
      it { should permit_action :create }
    end

    context "for managers of ohter projects" do 
      before { assign_role!(user, :manager, FactoryGirl.create(:project)) }
      it { should_not permit_action :create }
    end

    context "for administrators" do 
      let(:user) {FactoryGirl.create :user, :admin }
      it { should permit_action :create }
    end
  end
end
