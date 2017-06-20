class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @authorpost = current_user.authorposts.build
      @feed_items = current_user.feed.feed_sort.page(params[:page]).
        per_page Settings.authorpost.number
    end
  end

  def about
  end

  def contact
  end
end
