class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  before_action :not_logged_in, only: [:new, :create, :edit, :update]

 
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page])
    @followings = @user.followings.page(params[:page])
    @followers = @user.followers.page(params[:page])
    @like_posts = @user.like_posts.page(params[:page])
    counts_user(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def update
    @user = User.find_by(id: params[:id])
    if current_user == @user
      image = params[:profile_image]
      if image
        #データベースに保存するファイル名はユーザーのid.jpgとする
        @user.profile_image = "#{@user.id}.jpg"
        File.binwrite("public/user_images/#{@user.profile_image}",image.read)
      end
      if @user.update(user_params)
        flash[:success] = "ユーザ情報を編集しました"
        redirect_to user_path
      else
        flash.now[:danger] = "ユーザ情報を編集できませんでした"
        render :edit
      end
    else
      redirect_to posts_path
    end
  end
    
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile, :profile_image)
  end
  
end
