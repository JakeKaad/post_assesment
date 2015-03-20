require 'rails_helper'

describe CommentsController do 
  describe "POST create" do 
    context "with valid input" do 
      let(:new_post) { Fabricate(:post) }
      before { post :create, comment: Fabricate.attributes_for(:comment), post_id: new_post.id }
      
      it "redirects to the comment's post page" do 
        expect(response).to redirect_to new_post
      end

      it "creates a new comment" do 
        expect(Comment.all).to_not be_empty
      end

      it "sets the flash notice" do 
        expect(flash[:notice]).to_not be_empty
      end
    end
  end

  context "with invalid input" do 
    let(:new_post) { Fabricate(:post) }
    before { post :create, comment: Fabricate.attributes_for(:comment, content: ""), post_id: new_post.id }

    it "redirects to the comment's post page" do 
      expect(response).to redirect_to new_post
    end

    it "doesn't save a new comment" do 
      expect(Comment.all).to be_empty
    end

    it "sets the flash alert" do 
      expect(flash[:alert]).to_not be_empty
    end
  end

  describe "DELETE destroy" do 
    let(:post) { Fabricate(:post) }
    let(:comment) { Fabricate(:comment, post_id: post.id) }
    before { delete :destroy, id: comment.id, post_id: post.id  }

    it "deletes the comment" do 
      expect(Comment.all).to be_empty
    end

    it "redirects to the post show page" do 
      expect(response).to redirect_to post
    end

    it "sets the flash alert" do 
      expect(flash[:alert]).to_not be_empty
    end
  end
end
