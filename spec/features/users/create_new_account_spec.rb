# frozen_string_literal: true

require 'rails_helper'

feature 'Account Register' do
  before do
    visit new_user_path
  end

  include_examples 'title page', 'Hacker News Clone | Account Register'

  context 'with valid params' do
    scenario 'User creates new account' do
      sign_up = Page::Event.new(attributes_for(:user))

      sign_up.create

      expect(sign_up).to be_success
    end
  end

  context 'with invalid params' do
    context 'without username' do
      scenario "User got 'username can't be blank' error message" do
        sign_up = Page::Event.new(attributes_for(:user, username: nil))

        sign_up.create

        expect(sign_up).to be_error_username_cant_be_blank
      end
    end

    context 'without password' do
      scenario "User got 'password can't be blank' error message" do
        sign_up = Page::Event.new(attributes_for(:user, password: nil))

        sign_up.create

        expect(sign_up).to be_error_password_cant_be_blank
      end
    end

    context 'without password confirmation' do
      scenario "User got 'password_confirmation doesn't match' error message" do
        sign_up = Page::Event.new(
          attributes_for(:user, password_confirmation: nil)
        )

        sign_up.create

        expect(sign_up).to be_error_password_confirmation_doesnt_match
      end
    end
  end
end

module Page
  class Event < BaseTest
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
      has_content? 'Account has been succesfully registered'
    end

    def error_username_cant_be_blank?
      has_content? "Username can't be blank"
    end

    def error_password_cant_be_blank?
      has_content? "Password can't be blank"
    end

    def error_password_confirmation_doesnt_match?
      has_content? "Password confirmation doesn't match"
    end
  end
end
