module ApplicationHelper
  def full_title page_title = ""
    if page_title.empty?
      t(".ruby")
    else
      page_title + " | " + t(".ruby")
    end
  end
end
