module ControllerMacros
  def login_user
    before :each do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @user = User.create!({:email => 'aaa@bbb.com', :password => 'qwerty', :password_confirmation => 'qwerty'})
      @user.confirm!
      sign_in :user, @user
    end
  end
end