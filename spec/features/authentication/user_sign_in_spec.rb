# frozen_string_literal: true

require 'rails_helper'

feature 'Authentication' do
  before { visit login_path }

  include_examples 'title page', 'Hacker News Clone | Account Login'

  context 'with valid params' do
    let!(:user) { create(:user) }

    scenario 'User sign in to system' do
      event = Pages::SignIn.new(attributes_for(:user))

      event.sign_in

      expect(event).to be_success
    end
  end

  context 'with invalid params' do
    scenario 'Hacker sign in to system' do
      event = Pages::SignIn.new(attributes_for(:user, username: 'hacker'))

      event.sign_in

      expect(event).to be_error_credentials
    end
  end
end
