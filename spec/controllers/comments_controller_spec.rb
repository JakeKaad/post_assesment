require 'rails_helper'

describe CommentsController do 
  describe "POST create" do 
    context "with valid input" do 
      it "redirects to the comment's post page" do 
        new_post = Fabricate(:post)
        post :create, comment: Fabricate.attributes_for(:comment), post_id: new_post.id
        expect(response).to redirect_to new_post
      end

      it "creates a new comment"
      it "sets the flash notice"
    end
  end

  context "with invalid input"
end
