# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { 'pquest' }
    password { 'secret123' }
    password_confirmation { 'secret123' }
  end
end
