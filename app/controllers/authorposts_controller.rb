class AuthorpostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @authorpost = current_user.authorposts.build authorpost_params

    if @authorpost.save
      flash[:success] = t ".post_success"
      redirect_to root_url
    else
      flash.now[:danger] = t ".post_error"
      @feed_items = []
      render "static_pages/home"
    end
  end

  def destroy
    if @authorpost.destroy
      flash[:success] = t ".delete_success"
      redirect_to request.referrer || root_url
    else
      flash.now[:danger] = t ".delete_error"
      render "static_pages/home"
    end
  end

  private

  def authorpost_params
    params.require(:authorpost).permit :content, :picture
  end

  def correct_user
    @authorpost = current_user.authorposts.find_by id: params[:id]

    redirect_to root_url if @authorpost.nil?
  end
end
