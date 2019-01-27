# frozen_string_literal: true

require 'rails_helper'

feature 'Authentication' do
  before { visit login_path }

  include_examples 'title page', 'Hacker News Clone | Account Login'

  context 'with valid params' do
    let!(:user) { create(:user) }

    scenario 'User sign in to system' do
      event = Page::SignIn.new(attributes_for(:user))

      event.sign_in

      expect(event).to be_success
    end
  end

  context 'with invalid params' do
    scenario 'Hacker sign in to system' do
      event = Page::SignIn.new(attributes_for(:user, username: 'hacker'))

      event.sign_in

      expect(event).to be_error_credentials
    end
  end
end

module Page
  class SignIn < BaseTest
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
