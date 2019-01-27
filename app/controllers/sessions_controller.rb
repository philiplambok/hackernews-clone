# frozen_string_literal: true

# Controller that will handling authentication.
class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(username: params[:username])

    if user&.authenticate(params[:password])
      sign_in(user)
      redirect_to root_path, flash: { success: 'User logged in' }
    else
      redirect_to root_path, flash: { error: 'Credentials was invalid!' }
    end
  end
end
