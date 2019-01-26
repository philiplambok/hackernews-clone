# frozen_string_literal: true

# Application Helper

module ApplicationHelper
  # To setting title page
  def title_page(title = nil)
    app_name = 'Hacker News Clone'

    title = [app_name].push(title).compact

    content_for(:title, title.join(' | '))
  end
end
