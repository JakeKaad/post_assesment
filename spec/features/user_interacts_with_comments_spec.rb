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


def go_home
  visit '/'
end

def create_post
  click_link "New Post"
  fill_in "Title", with: "First"
  fill_in "Content", with: "Some content."
  click_on "Create Post"
end

def create_comment
  fill_in "New Comment", with: "comment content" 
  click_on "Create"
end