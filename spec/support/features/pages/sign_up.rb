# frozen_string_literal: true

module Pages
  class SignUp < BaseEvent
    def initialize(user_params)
      @username = user_params[:username]
      @password = user_params[:password]
      @password_confirmation = user_params[:password_confirmation]
    end

    def create
      fill_in :user_username, with: @username
      fill_in :user_password, with: @password
      fill_in :user_password_confirmation, with: @password_confirmation

      click_button 'Create new account'
    end

    def success?
      success_message? && stored?
    end

    def success_message?
      has_content? 'Account has been succesfully registered'
    end

    def stored?
      User.last.username == @username
    end

    def error?(attributes)
      send("error_#{attributes}?")
    end

    def error_username?
      has_content? "Username can't be blank"
    end

    def error_password?
      has_content? "Password can't be blank"
    end

    def error_password_confirmation?
      has_content? "Password confirmation doesn't match"
    end
  end
end