class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def check_url_user object
    render file: "public/404.html", layout: false unless object
  end

  private

  def logged_in_user
    return if logged_in?
    flash[:danger] = t ".pl_login"
    redirect_to login_url
  end
end
