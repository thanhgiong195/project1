class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      flash[:success] = t ".welcome"
      redirect_to root_url
    else
      flash.now[:danger] = t ".login_fail"
      render :new
    end
  end

  def destroy
    flash[:success] = t ".good_bye"
    log_out if logged_in?
    redirect_to root_url
  end
end
