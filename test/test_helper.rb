ENV["RAILS_ENV"] ||= "test"
#require 'simplecov'
#SimpleCov.start 'rails'
#puts 'required simplecov'

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails/capybara'



class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
  include Capybara::DSL
  include Capybara::Assertions
  include Rails.application.routes.url_helpers

  fixtures :all

end
