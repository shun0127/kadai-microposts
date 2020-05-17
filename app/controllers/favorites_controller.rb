class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  def create
    add_micropost = Micropost.find(params[:micropost_id])
    micropost_user = User.find(add_micropost.user_id)
    current_user.add_favorite(add_micropost)
    flash[:success] = "お気に入りに追加しました。"
    redirect_to micropost_user
  end

  def destroy
    rm_micropost = Micropost.find(params[:micropost_id])
    micropost_user = User.find(rm_micropost.user_id)
    current_user.rm_favorite(rm_micropost)
    flash[:success]="お気に入りから削除しました。"
    if params[:message_from] == "from_micropost"
      redirect_to micropost_user
    elsif params[:message_from] == "from_favorites_list"
      redirect_to likes_user_path(current_user)
    else
      redirect_to root_url
    end
  end
end
