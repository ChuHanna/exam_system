class ExamsController < ApplicationController
  before_action :find_by_exam, only: %i(show)
  authorize_resource

  def index
    @q = Exam.ransack(params[:q])
    @pagy, @exams = pagy(@q.result(distinct: true).includes([:user,:topic,:result]).order_by_created_at, items: Settings.show_5)
  end

  def show
    @questions_exams = @exam.questions.includes(:answers)
    @user_answer_ids = @exam.records.pluck(:answer_id)
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@exam.user.name}_#{@exam.id}_#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}",
          template: "exams/show.html.erb",
          disposition: "attachment",
          layout: "pdf",
          orientation: "Landscape",
          encoding: "UTF-8"
      end
    end
  end

  def edit; end

  def new
    @exam = Exam.new
  end

  def create
    @exam = current_user.exams.new(topic_id: params[:exam][:topic_id], time_start: Time.zone.now)
    @exam.save!
    flash[:success] = t "suscess_message"
    redirect_to exams_path
  rescue ActiveRecord::ActiveRecordError
    flash.now[:danger] = t "fail_message"
    redirect_to topics_path
  end

  def destroy
    if @exam.destroy
      flash[:success] = t "deleted_exam"
    else
      flash[:danger] = t "fail_delete_exam"
    end
    redirect_to request.referer || exams_path
  end

  private
  def find_by_exam
    @exam = Exam.find_by id: params[:id]
    return if @exam

    flash[:danger] = t "exam_not_found"
    redirect_to exams_path
  end
end
