# frozen_string_literal: true

require 'rails_helper'

describe User do
  it { is_expected.to have_secure_password }

  context 'validations' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username) }
  end
end
