class BookmarksController < ApplicationController
  def create
    bookmark = current_user.bookmarks.build(event_id: params[:event_id])
    bookmark.save
    redirect_to root_path
  end

  def destroy
    bookmark = Bookmark.find_by(event_id: params[:event_id], user_id: current_user.id)
    bookmark.destroy
    redirect_to root_path
  end

  
end
