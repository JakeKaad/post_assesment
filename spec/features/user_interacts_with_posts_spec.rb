require 'rails_helper'

describe "user interacts with posts" do
  it "has a home page" do
    go_home
    expect(page).to have_content "All"

    click_link "New Post"
    expect(page).to have_content "New"

    click_link "Posts"
    expect(page).to have_content "All"
  end

  it "creates a new post" do 
    go_home
    create_post

    expect(page).to have_content "First"
    expect(page).to have_content "Some content"
  end

  it "deletes a post" do 
    go_home
    create_post

    click_link "Delete"
    expect(page).to_not have_content "First"
  end

  it "edits a post" do 
    go_home
    create_post

    click_link "Edit"
    fill_in "Title", with: "Second"
    fill_in "Content", with: "New content."
    click_on "Update Post"

    expect(page).to have_content "Second"
    expect(page).to have_content "New content."
  end
end


def go_home
  visit '/'
end

def create_post
  click_link "New Post"
  fill_in "Title", with: "First"
  fill_in "Content", with: "Some content."
  click_on "Create Post"
end