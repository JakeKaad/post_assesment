require 'rails_helper'

describe PostsController do 
  describe 'GET index' do 
    it "sets @posts" do 
      post = Fabricate(:post)
      get :index
      expect(assigns(:posts)).to eq([post])
    end
  end

  describe 'GET show' do 
    it "sets @post to the correct post" do 
      post = Fabricate(:post)
      get :show, id: post.id 
      expect(assigns(:post)).to eq(post)
    end

    it "doesn't set @post to the incorrect post" do 
      post = Fabricate(:post)
      not_post = Fabricate(:post)
      get :show, id: post.id 
      expect(assigns(:post)).to_not eq(not_post)
    end
  end

  describe 'GET new' do 
    it "should set @post to a new post object" do 
      get :new
      expect(assigns(:post)).to be_instance_of(Post)
    end
  end

  describe 'POST create' do 
    context "with valid input" do 
      it "should save a new post object" do 
        post :create, post: Fabricate.attributes_for(:post)
        expect(Post.all).to_not be_empty
      end

      it "redirects to the post show page" do 
        post :create, post: Fabricate.attributes_for(:post)
        expect(response).to redirect_to post_path(Post.last)
      end

      it "sets a flash notice" do 
        post :create, post: Fabricate.attributes_for(:post)
        expect(flash[:notice]).to_not be_blank
      end
    end

    context "with invalid input" do 
      it "should render the new template" do 
        post :create, post: { title: "test" }
        expect(response).to render_template(:new)
      end

      it "shouldn't save a post object" do 
        post :create, post: { title: "test" }
        expect(Post.all).to be_empty
      end

      it "should set a flash alert" do 
        post :create, post: { title: "test" }
        expect(flash[:alert]).to_not be_blank
      end
    end
  end

  describe 'GET edit' do 
    it "sets the correct @post" do 
      post = Fabricate(:post)
      get :edit, id: post.id
      expect(assigns(:post)).to eq post
    end
  end

  describe 'POST update' do 
    context "with valid input" do 
      it "sets the correct post" do 
        new_post = Fabricate(:post)
        post :update, id: new_post.id, post: { title: "Second", content: "New Body"}
        expect(assigns(:post)).to eq new_post
      end

      it "redirects to the post page" do 
        new_post = Fabricate(:post)
        post :update, id: new_post.id, post: { title: "Second", content: "New Body"}
        expect(response).to redirect_to post_path(new_post)
      end

      it "sets the flash notice" do 
        new_post = Fabricate(:post)
        post :update, id: new_post.id, post: { title: "Second", content: "New Body"}
        expect(flash[:notice]).to_not be_blank
      end

      it "updates the post" do 
        new_post = Fabricate(:post, title: "First", content: "Old Body")
        post :update, id: new_post.id, post: { title: "Second", content: "New Body"}
        expect(new_post.reload.title).to eq("Second")
      end
    end

    context "with invalid input" do 
      it "doesn't update the post" do 
        new_post = Fabricate(:post, title: "First")
        post :update, id: new_post.id, post: { title: "", content: "New Body"}
        expect(new_post.reload.title).to eq "First"
      end

      it "sets the flash alert" do 
        new_post = Fabricate(:post, title: "First")
        post :update, id: new_post.id, post: { title: "", content: "New Body"}
        expect(flash[:alert]).to_not be_blank
      end

      it "renders the edit template" do 
        new_post = Fabricate(:post, title: "First")
        post :update, id: new_post.id, post: { title: "", content: "New Body"}
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE destroy" do 
    let(:post) { Fabricate(:post) }
    before { delete :destroy, id: post.id }

    it "redirects to the home page" do
      expect(response).to redirect_to root_path
    end

    it "sets the correct post" do 
      expect(assigns(:post)).to eq post
    end 

    it "deletes the post" do 
      expect(Post.all).to be_empty
    end

    it "sets the  flash alert" do 
      expect(flash[:notice]).to_not be_empty
    end
  end

end