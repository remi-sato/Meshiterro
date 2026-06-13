class UsersController < ApplicationController
  # 認証をスキップ：サインアップ(new,create)はログイン前に行うため
  allow_unauthenticated_access only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path, notice: "ユーザー登録が完了しました！続けてログインしてください。"
    else
      # エラー時はフォームを再表示
      render :new,status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    @post_images=@user.post_images.page(params[:page])
  end

  def edit
    @user=User.find(params[:id])
    if @user != Current.user
      redirect_to post_image_path
    end
    @user = User.find(params[:id])
  end

  def update
    user= User.find(params[:id])
    unless user.id == Current.user.id
      redirect_to post_image_path
    end

    @user=User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

 private

 def user_params
   # name,email_address,password,password_confirmationを許可
   params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
 end  

end

