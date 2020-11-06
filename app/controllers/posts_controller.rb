class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [ :edit, :update, :destroy ]
  
  def index
    @posts = Post.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '投稿しました。'
      redirect_to root_url
    else
      flash.now[:danger] = '投稿に失敗しました。'
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @post.update(post_params)
      flash[:success] = "投稿を編集しました"
      redirect_to root_url
    else
      flash.now[:danger] = "投稿を編集できませんでした"
      redirect_to :edit
    end
  end
  
  def destroy
    @post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to root_url
  end
  
  private
  
  def post_params
    params.require(:post).permit(:content)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
  
end
