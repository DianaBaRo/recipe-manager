class SessionsController < ApplicationController
  def new
  end

  def create
    
    if auth_hash = request.env['omniauth.auth']
      @user = User.find_or_create_by_omniauth(auth_hash)
      
      session[:user_id] = @user.id
      
      redirect_to user_path(@user)
    else
      #Normal login with Username and Password
      @user = User.find_by(:email => params[:user][:email])
      if @user && @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id

        redirect_to user_path(@user)
      else
        flash[:error] = "Sorry, login info was incorrect. Please try again."
        render :new
      end
    end
  end

  def destroy
    if current_user
      session.delete :user_id
      redirect_to root_url
    end
  end

end