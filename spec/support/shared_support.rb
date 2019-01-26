# frozen_string_literal: true

# Write all shared rspec to this file.
RSpec.shared_examples 'title page' do |title_page|
  subject { page }

  it { is_expected.to have_title title_page }
end
