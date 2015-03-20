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

end