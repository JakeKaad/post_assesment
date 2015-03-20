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

end