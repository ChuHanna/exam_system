class QuestionsExamsController < ApplicationController
  before_action :find_by_questions_exam, only: %i(show destroy)
  authorize_resource

  def show
    @exam = @questions_exam.exam
  end

  def create
    params = questions_exam_params
    if @exam && @exam.questions << Question.find(params[:question_id])
      flash[:success] = t "success_question"

      redirect_to questions_path
    else
      flash[:danger] = t "fail_question"
      render :new
    end
  end

  def destroy
    if @questions_exam.destroy
      flash[:success] = t "deleted_question"
    else
      flash[:danger] = t "fail_delete"
    end
    redirect_to request.referer || root_url
  end

  private
  def questions_exam_params
    params.require(:questions_exam).permit QuestionsExam::QUESTIONS_EXAM_PARAMS
  end

  def find_by_questions_exam
    @questions_exam = QuestionsExam.find_by id: params[:id]
    return if @questions_exam

    flash[:danger] = t "question_not_found"
    redirect_to questions_path
  end
end
