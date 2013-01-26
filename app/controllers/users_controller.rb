#encoding: utf-8
class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def edit
    user_data = params[:users]
    user_data.each do |user_record|
      user = User.find(user_record[:id])
      user.update_attributes(user_record) 
      user.save!
    end
    redirect_to '/users/index', notice: "Данные пользователей успешно изменены."
  end
end
