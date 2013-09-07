class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if params[:user]
      @user = User.new(params[:user].permit(:email, :password, :password_confirmation))
    else
      @user = User.new_guest
    end

    if @user.save
      current_user.move_to(@user) if current_user && current_user.guest?
      session[:user_id] = @user.id

      if params[:create_character]
        redirect_to character_build_url(:start, character_id: "new")
      else
        redirect_to root_url, notice: "Signed up successfully."
      end
    else
      render :new
    end
  end
end
