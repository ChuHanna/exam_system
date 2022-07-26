class SlackChannelsController < ApplicationController
  before_action :load_subject, :load_topics, only: :index

  def index
    return unless request.xhr?

    respond_to do |format|
      format.json{render json: {channels: @channels}}
    end
  end

  private
  def load_topics
    return @topics = [] if @subject.blank?

    @topics = Topic.find_by subject_id: @subject.id
    return @topics if @topics.empty?

    @topics.map!{|item| {id: item[:id], name: item[:name]}}
  end

  def load_subject
    @subject = Subject.find_by id: params[:subject_id]
  end
end
