class TopicsController < ApplicationController
  before_action :find_by_topic, only: %i(edit destroy)
  before_action :logged_in_user

  def index
    @topics = Topic.includes(:user).all
  end

  def edit; end

  def show; end

  def new
    @topic = topic.new
  end

  def create
    @topic = current_user.topics.build topic_params
    if @topic.save
      flash[:success] = t "success_topic"
      redirect_to topic_url
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
    params.require(:topic).permit topic::TOPIC_PARAMS
  end

  def find_by_topic
    @topic = topic.find_by id: params[:id]
    return if @topic

    flash[:danger] = t "topic_not_found"
    redirect_to topics_path
  end
end
