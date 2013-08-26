class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if params[:user]
      @user = User.new(params[:user])
    else
      @user = User.new_guest
    end

    if @user.save
      session[:user_id] = @user.id

      if params[:create_character]
        redirect_to new_character_url
      else
        redirect_to root_url, notice: "Signed up successfully."
      end
    else
      render :new
    end
  end
end
