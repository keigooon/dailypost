class LikesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @post = Post.find(params[:post_id])
    current_user.like(@post)
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    current_user.remove_like(@post)
  end
  
end
