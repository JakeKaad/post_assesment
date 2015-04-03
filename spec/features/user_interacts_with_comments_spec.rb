require 'rails_helper'


describe "User interacting with comments", vcr: true do
  let(:user) { Fabricate(:user) }
  before { login_as(user, scope: :user) }

  it "creates a comment", js: true do
    visit root_path
    create_post

    expect(page).to have_content "Comments (0)"

    create_comment

    expect(page).to have_content "Comments (1)"
    expect(page).to have_content "comment content"
  end

  it "deletes a comment", vcr: true do
    visit root_path
    create_post
    create_comment

    click_link "Delete Comment"
    expect(page).to have_content "Comments (0)"
  end
end

