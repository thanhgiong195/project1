module ApplicationHelper
  def full_title page_title = ""
    if page_title.empty?
      t(".title")
    else
      page_title + " | " + t(".title")
    end
  end
end
