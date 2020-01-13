require 'rails_helper'

module LogAfterTeardown
  def after_teardown
    puts 'Ran after_teardown' if @log_after_teardown
    super
  end
end
ActiveSupport::Testing::TimeHelpers.prepend LogAfterTeardown

# Types from https://github.com/rspec/rspec-rails#what-tests-should-i-write
# Spec type      Corresponding Rails test class
[
  :model,
  :controller, # ActionController::TestCase
  :mailer,     # ActionMailer::TestCase
  :job,
  :view,       # ActionView::TestCase
  :routing,
  :helper,     # ActionView::TestCase
  :request,    # ActionDispatch::IntegrationTest
  :feature,
  # This example Rails app was generated without Capybara, so cannot use system tests
  # :system,     # ActionDispatch::SystemTestCase
].each do |type|
  describe "TimeHelpers (type: :#{type})", type: type do
    it 'allows calling freeze_time' do
      freeze_time
    end
  end
end

describe 'TimeHelpers', type: :helper do
  it 'works' do
    freeze_time

    puts 'Make sure you see after_teardown! If not, no cleanup has occured!'
    @log_after_teardown = true

    time = Time.now
    sleep 0.01
    expect(Time.now).to eq(time)
  end
end
