require 'rails_helper'

describe PostsController do
  describe 'GET index' do
    it "sets @posts" do
      post = Fabricate(:post, user_id: 1)
      get :index
      expect(assigns(:posts)).to eq([post])
    end
  end

  describe 'GET show' do
    let(:post) { Fabricate(:post, user_id: 1) }
    before { get :show, id: post.id }

    it "sets @post to the correct post" do
      expect(assigns(:post)).to eq(post)
    end

    it "doesn't set @post to the incorrect post" do
      not_post = Fabricate(:post)
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
      before { post :create, post: Fabricate.attributes_for(:post) }

      it "should save a new post object" do
        expect(Post.all).to_not be_empty
      end

      it "redirects to the post show page" do
        expect(response).to redirect_to post_path(Post.last)
      end

      it "sets a flash notice" do
        expect(flash[:notice]).to_not be_blank
      end
    end

    context "with invalid input" do
      before {  post :create, post: { title: "test" } }
      it "should render the new template" do
        expect(response).to render_template(:new)
      end

      it "shouldn't save a post object" do
        expect(Post.all).to be_empty
      end

      it "should set a flash alert" do
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
      let(:new_post) { Fabricate(:post) }
      before { post :update, id: new_post.id, post: { title: "Second", content: "New Body"} }
      it "sets the correct post" do
        expect(assigns(:post)).to eq new_post
      end

      it "redirects to the post page" do
        expect(response).to redirect_to post_path(new_post)
      end

      it "sets the flash notice" do
        expect(flash[:notice]).to_not be_blank
      end

      it "updates the post" do
        expect(new_post.reload.title).to eq("Second")
      end
    end

    context "with invalid input" do
      let(:new_post) { Fabricate(:post, title: "First") }
      before { post :update, id: new_post.id, post: { title: "", content: "New Body"} }

      it "doesn't update the post" do
        expect(new_post.reload.title).to eq "First"
      end

      it "sets the flash alert" do
        expect(flash[:alert]).to_not be_blank
      end

      it "renders the edit template" do
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
