class LikesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    post = Post.find(params[:post_id])
    current_user.like(post)
    flash[:success] = 'likeしました'
    redirect_to root_url
  end
  
  def destroy
    post = Post.find(params[:post_id])
    current_user.remove_like(post)
    flash[:success] = 'likeを取り消しました'
    redirect_to root_url
  end
  
end
