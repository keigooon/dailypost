class ApplicationController < ActionController::Base
  
  include SessionsHelper

  
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def not_logged_in
    if logged_in?
      redirect_to posts_path
    end
  end
  
  def counts_user(user)
    @count_posts = user.posts.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_like_posts = user.like_posts.count
  end
  
  
end
