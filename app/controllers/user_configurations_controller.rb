class UserConfigurationsController < ApplicationController
  before_action :set_user_configuration

  def edit
  end

  def update
    if @user_configuration.update(user_configuration_params)
      redirect_to root_path, notice: 'User configuration were successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_user_configuration
    @user_configuration = current_user.user_configuration
  end

  def user_configuration_params
    params.require(:user_configuration).permit(:developer_public_key, :member_token)
  end
end
