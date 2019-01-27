# frozen_string_literal: true

module Pages
  # Super class of page object.
  class BaseEvent
    include Rails.application.routes.url_helpers
    include Capybara::DSL
  end
end
