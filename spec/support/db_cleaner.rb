# RSpec.configure do |config|
#   config.before(:suite) do |example_group|
#     DatabaseCleaner.clean_with :truncation
#   end

#   config.before(:each) do
#     DatabaseCleaner.strategy = Capybara.current_driver != :rack_test ? :truncation : :transaction
#     DatabaseCleaner.start
#   end

#   config.after(:each) do
#     DatabaseCleaner.clean
#   end
# end