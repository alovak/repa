ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require 'turn'
require 'mocha'

class ActionController::TestCase
  def skip_login
    @controller.send('current_user=', users(:user))
    @controller.class.skip_filter :authorize
  end
end
class ActiveSupport::TestCase
  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  #
  # The only drawback to using transactional fixtures is when you actually 
  # need to test transactions.  Since your test is bracketed by a transaction,
  # any transactions started in your code will be automatically rolled back.
  self.use_transactional_fixtures = true

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = true

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  #def assert_invalid(model, attribute, message, message_value = nil)
    #assertion = model.errors.on(attribute).to_a.include?( full_message(message) % message_value ) 
    #assert( assertion, model.errors.on(attribute) )  
  #end

  #def full_message(message)
    #I18n.t(message, {:scope => 'activerecord.errors.messages'})
  #end

  def assert_error_on(model, attribute, message = nil, message_value = {}, errors_count = nil)
    model.valid?
    attribute.to_a.each do |attribute|
      assert(error_on(model, attribute, message, message_value), "no '#{full_message(message, message_value) || 'any'}' error on #{attribute}" )
      assert_equal(errors_count, model.errors[attribute.to_s].to_a.count, "wrong errors count") if errors_count && model.errors[attribute.to_s]
    end
  end

  def assert_no_error_on(model, attribute, message = nil, message_value = {})
    model.valid?
    attribute.to_a.each do |attribute|
      value = model.respond_to?(attribute.to_sym) ? model.send(attribute.to_sym) : model.attributes[attribute.to_s]
      assert(!error_on(model, attribute, message, message_value), "there is '#{full_message(message, message_value) || 'some'}' error on #{attribute} (#{value})")
    end
  end

  def error_on(model, attribute, message = nil, message_value = {})
    message ? model.errors.on(attribute).to_a.include?(full_message(message, message_value)) : model.errors.on(attribute)
  end

  def full_message(message, message_value)
    I18n.t(message, {:scope => 'activerecord.errors.messages'}.update(message_value)) if message
  end
end
