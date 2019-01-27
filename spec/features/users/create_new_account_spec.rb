# frozen_string_literal: true

require 'rails_helper'

feature 'Account Register' do
  before { visit new_user_path }

  include_examples 'title page', 'Hacker News Clone | Account Register'

  context 'with valid params' do
    scenario 'User creates new account' do
      sign_up = Page::SignUp.new(attributes_for(:user))

      sign_up.create

      expect(sign_up).to be_success
    end
  end

  context 'with invalid params' do
    context 'without username' do
      scenario "User got 'username can't be blank' error message" do
        sign_up = Page::SignUp.new(attributes_for(:user, username: nil))

        sign_up.create

        expect(sign_up).to be_error(:username)
      end
    end

    context 'without password' do
      scenario "User got 'password can't be blank' error message" do
        sign_up = Page::SignUp.new(attributes_for(:user, password: nil))

        sign_up.create

        expect(sign_up).to be_error(:password)
      end
    end

    context 'without password confirmation' do
      scenario "User got 'password_confirmation doesn't match' error message" do
        sign_up = Page::SignUp.new(
          attributes_for(:user, password_confirmation: nil)
        )

        sign_up.create

        expect(sign_up).to be_error(:password_confirmation)
      end
    end
  end
end

module Page
  class SignUp < BaseTest
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
