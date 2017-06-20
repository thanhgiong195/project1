class UsersController < ApplicationController
  before_action :load_user, except: [:new, :create, :index]
  before_action :logged_in_user, except: [:new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".welcome"
      redirect_to @user
    else
      flash.now[:danger] = t ".error"
      render :new
    end
  end

  def show
    @authorposts = @user.authorposts.feed_sort.page(params[:page]).
      per_page Settings.authorpost.number
  end

  def edit
  end

  def index
    @users = User.order(:name).page(params[:page]).
      per_page Settings.user.user_show
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".update_success"
      redirect_to @user
    else
      flash.now[:danger] = t ".update_fail"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".delete_success"
      redirect_to users_url
    else
      flash[:danger] = t ".delete_error"
      redirect_back fallback_location: users_url
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]

    check_url_user @user
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user.current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.is_admin?
  end
end
