# frozen_string_literal: true

# All page object test will inherit from this.
# If you have duplication in module or base class level,
# please extract to this class, thanks.
module Page
  # Class class.
  # How to use:
  # class Event < BaseTest
  #   def initialize; end
  # end
  #
  class BaseTest
    include Rails.application.routes.url_helpers
    include Capybara::DSL
  end
end
