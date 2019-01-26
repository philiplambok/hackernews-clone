# frozen_string_literal: true

# Class that handling users action
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to new_user_path, flash: { success: 'Account has been succesfully registered' }
    else
      redirect_to new_user_path, flash: { danger: @user.errors.full_messages }
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :username, :password, :password_confirmation
    )
  end
end
