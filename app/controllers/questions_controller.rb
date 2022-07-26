class QuestionsController < ApplicationController
  before_action :find_question, only: %i(edit update destroy)

  def index
    @q = Question.ransack(params[:q])
    @pagy, @questions = pagy @q.result.includes(:topic).sort_by_date, items: Settings.show_10
  end

  def new
    @question = Question.new
  end

  def create
    ActiveRecord::Base.transaction do
      @question = Question.new question_params
      check_answers_attributes if @question.question_type_single_choice?
      @question.save!
      flash[:success] = t ".message_success"
      redirect_to questions_path
    end
  rescue StandardError
    flash[:danger] = t ".message_fail"
    render :new
  end

  def edit; end

  def update
    ActiveRecord::Base.transaction do
      @question.update question_params
      check_answers_attributes if @question.question_type_single_choice?
      flash[:success] = t ".message_success"
      redirect_to questions_path
    end
  rescue StandardError
    flash[:danger] = t ".message_fail"
    render :edit
  end

  def import
    arr_file = Settings.import.arr_items
    if params[:file].blank?
      flash[:danger] = t ".import_blank"
    elsif arr_file.include? params[:file].original_filename.split(".").last
      import_file
    else flash[:danger] = t ".import_error"
    end
    redirect_to questions_path
  end

  def destroy
    if @question.destroy
      flash.now[:success] = t ".message_success"
      respond_to do |format|
        format.js
        format.html
      end
    else
      flash[:danger] = t ".message_fail"
      redirect_to questions_path
    end
  end

  private
  def find_question
    @question = Question.find_by id: params[:id]
    return if @question

    redirect_to questions_path
    flash[:danger] = t ".no_question"
  end

  def import_file
    if Question.import(params[:file])
      flash[:success] = t ".import_success"
    else
      flash[:danger] = t ".import_fail"
    end
  end

  def question_params
    params.require(:question).permit Question::QUESTION_PARAMS
  end

  def check_answers_attributes
    flag = false
    params[:question][:answers_attributes].values.each do |ans|
      if ans["check"] == "1"
        flash[:danger] = "Câu hỏi single_choice chỉ có một đáp án đúng"#t ".import_fail"
        raise "Câu hỏi single_choice chỉ có một đáp án đúng" if flag

        flag = true
      end
    end
    flag
  end
end
