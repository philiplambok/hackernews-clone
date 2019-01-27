# frozen_string_literal: true

require 'rails_helper'

feature 'Authentication' do
  context 'with valid params' do
    let!(:user) { create(:user) }

    scenario 'User sign in to system' do
      visit login_path

      fill_in :username, with: user.username
      fill_in :password, with: user.password

      click_button 'Login'

      expect(page.current_path).to eq root_path
      expect(page).to have_content user.username
    end
  end
end
