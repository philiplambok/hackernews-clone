# frozen_string_literal: true

require 'rails_helper'

feature 'Account Register' do
  before { visit new_user_path }

  include_examples 'title page', 'Hacker News Clone | Account Register'

  context 'with valid params' do
    scenario 'User creates new account' do
      sign_up = Pages::SignUp.new(attributes_for(:user))

      sign_up.create

      expect(sign_up).to be_success
    end
  end

  context 'with invalid params' do
    context 'without username' do
      scenario "User got 'username can't be blank' error message" do
        sign_up = Pages::SignUp.new(attributes_for(:user, username: nil))

        sign_up.create

        expect(sign_up).to be_error(:username)
      end
    end

    context 'without password' do
      scenario "User got 'password can't be blank' error message" do
        sign_up = Pages::SignUp.new(attributes_for(:user, password: nil))

        sign_up.create

        expect(sign_up).to be_error(:password)
      end
    end

    context 'without password confirmation' do
      scenario "User got 'password_confirmation doesn't match' error message" do
        sign_up = Pages::SignUp.new(
          attributes_for(:user, password_confirmation: nil)
        )

        sign_up.create

        expect(sign_up).to be_error(:password_confirmation)
      end
    end
  end
end
