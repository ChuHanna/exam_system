class TopicsController < ApplicationController
  before_action :find_by_topic, only: %i(show edit destroy)
  authorize_resource

  def index
    @q = Topic.ransack(params[:q])
    @pagy, @topics = pagy(@q.result(distinct: true).order_by_created_at.includes([:user,:subject]), items: Settings.show_5)
  end

  def edit; end

  def show; end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.build topic_params
    if @topic.save
      flash[:success] = t "success_topic"
      redirect_to topics_path
    else
      flash[:danger] = t "fail_topic"
      render :new
    end
  end

  def update; end

  def destroy
    if @topic.destroy
      flash[:success] = t "deleted"
    else
      flash[:danger] = t "fail_delete"
    end
    redirect_to request.referer || topics_path
  end

  private
  def topic_params
    params.require(:topic).permit Topic::TOPIC_PARAMS
  end

  def find_by_topic
    @topic = topic.find_by id: params[:id]
    return if @topic

    flash[:danger] = t "topic_not_found"
    redirect_to topics_path
  end
end
