class Web::Account::PasswordsController < Web::ApplicationController

  def edit
    @user = UserPasswordEditType.new
  end

  def update
    @token = User::AuthToken.find_by_authentication_token(params[:auth_token])
    @user = @token.user
    if @token && !@token.expired?
      if @user.update_attributes(params[:user])
        flash_success
        redirect_to root_path
      end
    else
      flash_error
      render :edit
    end
  end

end