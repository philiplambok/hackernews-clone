# frozen_string_literal: true

module Pages
  class SignIn < BaseEvent
    def initialize(auth_params)
      @username = auth_params[:username]
      @password = auth_params[:password]
    end

    def sign_in
      fill_in :username, with: @username
      fill_in :password, with: @password

      click_button 'Login'
    end

    def success?
      to_root_path? && has_content?(@username)
    end

    def error_credentials?
      to_login_page? && has_content?('Credentials was invalid')
    end

    private

    def to_root_path?
      page.current_path == root_path
    end

    def to_login_page?
      page.current_path == login_path
    end
  end
end