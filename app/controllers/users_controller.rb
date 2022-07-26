class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_by_user, only: %i(show edit destroy)
  authorize_resource

  def index
    @pagy, @users = pagy(User.all, items: Settings.show_10)
  end

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new user_params
    ActiveRecord::Base.transaction do
      @user.save!
      flash[:success] = t(".save_user")
      redirect_to users_path
    end
  rescue StandardError => e
    flash.now[:danger] = t ".fail_save"
    render :new
  end

  def edit; end

  def update
    if user.update user_params
      flash.now[:success] = t(".save_user")
      render :show
    else
      flash[:danger] = t ".fail_save"
      redirect_to root_path
    end
  end

  private
  def user_params
    params.require(:user).permit User::USER_PARAMS
  end

  def find_by_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "user_not_found"
    redirect_to root_path
  end
end
