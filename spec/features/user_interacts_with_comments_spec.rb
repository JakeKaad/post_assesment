require 'rails_helper'

describe "User interacting with comments" do

  it "creates a comment" do
    go_home
    create_post

    expect(page).to have_content "Comments (0)"

    create_comment

    expect(page).to have_content "Comments (1)"
    expect(page).to have_content "comment content"
  end

  it "deletes a comment" do
    go_home
    create_post
    create_comment

    click_link "Delete Comment"
    expect(page).to have_content "Comments (0)"
  end
end

