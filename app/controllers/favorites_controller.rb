class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  def create
    add_micropost = Micropost.find(params[:micropost_id])
    micropost_user = User.find(add_micropost.user_id)
    current_user.add_favorite(add_micropost)
    flash[:success] = "お気に入りに追加しました。"
    if params[:call_favorite_from] == "from_show"
      redirect_to micropost_user
    elsif params[:call_favorite_from] == "from_index"
      redirect_to root_url
    else
      redirect_to root_url
    end
  end

  def destroy
    rm_micropost = Micropost.find(params[:micropost_id])
    micropost_user = User.find(rm_micropost.user_id)
    current_user.rm_favorite(rm_micropost)
    flash[:success]="お気に入りから削除しました。"
#binding.pry
    if params[:call_favorite_from] == "from_show"
      redirect_to micropost_user
    elsif params[:call_favorite_from] == "from_favorites_list"
      redirect_to likes_user_path(current_user)
    elsif params[:call_favorite_from] == "from_index"
      redirect_to root_url
    else
      redirect_to root_url
    end
  end
end
