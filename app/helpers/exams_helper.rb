module ExamsHelper
  def load_name_topic
    Topic.pluck(:name, :id)
  end

  def load_content_question question
    question.pluck(:description, :id)
  end

  def get_action_exam exam
    if exam.active_status?
      fa_type = "window-close"
      btn_type = "danger"
      status = "inactive"
    else
      fa_type = "check"
      btn_type = "success"
      status = "active"
    end

    link_to(change_status_message_path(message, status: status),
            data: {"turbo-method": :put},
            class: "btn-#{btn_type} btn-circle btn-sm") do
      content_tag :i, "", class: "fas fa-#{fa_type}"
    end
  end

  def get_time_exam exam

  end
end
