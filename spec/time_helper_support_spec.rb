require 'rails_helper'

module LogAfterTeardown
  def after_teardown
    puts 'Ran after_teardown' if @log_after_teardown
    super
  end
end
ActiveSupport::Testing::TimeHelpers.prepend LogAfterTeardown

describe 'TimeHelpers' do
  it 'works' do
    freeze_time

    puts 'Make sure you see after_teardown! If not, no cleanup has occured!'
    @log_after_teardown = true

    time = Time.now
    sleep 0.01
    expect(Time.now).to eq(time)
  end
end
