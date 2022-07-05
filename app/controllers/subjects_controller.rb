class SubjectsController < ApplicationController
  before_action :find_by_subject, only: %i(edit destroy)
  before_action :logged_in_user

  def index
    @subjects = Subject.includes(:user).all
  end

  def edit; end

  def show; end

  def new
    @subject = Subject.new
  end

  def create
  end

  def update; end

  def destroy
  end

  private
  def subject_params
    params.require(:subject).permit Subject::SUBJECT_PARAMS
  end

  def find_by_subject
    @subject = Subject.find_by id: params[:id]
    return if @subject

    flash[:danger] = t "subject_not_found"
    redirect_to subjects_path
  end
end
