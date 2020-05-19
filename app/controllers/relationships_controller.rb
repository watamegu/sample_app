class RelationshipsController < ApplicationController
  before_action :logged_in_user

  # POST /relatiomships
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js # => app/views/relationships/create.js.erbを呼び出す
    end
  end

  # DELETE /relatiomships/id;
  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
