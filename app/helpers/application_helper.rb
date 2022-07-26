module ApplicationHelper
  include Pagy::Frontend

  def full_title page_title
    base_title = t("base_title")
    page_title.empty? ? base_title : [page_title, base_title].join(" | ")
  end

  def pagy_t key, **opts
    ::I18n.t(key, **opts)
  end

  def toastr_flash type
    case type
    when "alert"
      "toastr.error"
    when "notice"
      "toastr.success"
    else
      "toastr.info"
    end
  end
end
