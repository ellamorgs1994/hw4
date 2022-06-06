class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by({ "email" => params["email"] })
    if @user
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Hello. You've logged in"
        redirect_to "/places"
      else
        flash["notice"] = "Unsuccessful login. Try again."
        redirect_to "/sessions/new"
      end
    else
      flash["notice"] = "Unsuccessful login. Try again."
      redirect_to "/sessions/new"
    end
  end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "Goodbye."
    redirect_to "/sessions/new"
  end
end