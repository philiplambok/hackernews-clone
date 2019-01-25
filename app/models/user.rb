# frozen_string_literal: true

#== Schema Information
# id              : integer
# username        : string
# password_digest : string
#
class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: true
end
