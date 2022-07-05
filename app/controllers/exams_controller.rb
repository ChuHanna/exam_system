class ExamsController < ApplicationController
  before_action :find_by_exam, only: %i(show update destroy)
  before_action :logged_in_user
  before_action :load_questions, only: %i(new create show)

  def index
    # @q = Exam.all
    @pagy, @exams = pagy(Exam.order_by_created_at, items: Settings.show_5)
  end

  def show
    @questions_exams = @exam.questions_exams.includes(:topic, :user)
                            .page(params[:page])
                            .per Settings.show_5
  end

  def new
    @exam = Exam.new
  end

  def edit; end

  def create
    @exam = Exam.new exam_params
    @exam.user.id = current_user.id
    if @exam.save
      flash[:success] = t "success_exam"
      redirect_to exams_path
    else
      flash[:danger] = t "fail_exam"
      render :new
    end
  end

  def update; end

  def destroy
    if @exam.destroy
      flash[:success] = t "deleted_exam"
    else
      flash[:danger] = t "fail_delete_exam"
    end
    redirect_to request.referer || exams_path
  end

  private
  def exam_params
    params.require(:exam).permit Exam::EXAM_PARAMS
  end

  def find_by_exam
    @exam = Exam.find_by id: params[:id]
    return if @exam

    flash[:danger] = t "exam_not_found"
    redirect_to exams_path
  end

  def load_questions
    @questions = Question.get_list
  end
end
