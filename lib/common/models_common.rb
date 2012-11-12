module ModelsCommon

  def find_user_items(user_id, params = {})
    params[:user_id] = user_id
    return self.where(params)
  end
  
  def find_user_item(user_id, id)
    return self.find_user_items(user_id, {:id => id}).first
  end
end