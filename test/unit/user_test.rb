require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_user_creation
    assert @user.valid?, 'Invalid fixture user'
    assert create_user.valid?, 'Invalid manually created user'
  end

  def test_should_require_password
    user = create_user :password => nil
    assert user.errors.on(:password)
    assert_equal user.errors.size, 1

    user.password = user.password_confirmation = String.random_string(Policy['password']['min_length'])
    assert user.valid? 
  end

  def test_user_authentication
    @user.password = @user.password_confirmation = String.random_string(Policy['password']['min_length']) 
    @user.save
    assert_equal @user.id, User.authenticate(@user.email, @user.password).id
  end

  def test_min_max_password_length
    invalid_passwords = [ 
      { :length   => Policy['password']['min_length'] - 1, :message => :too_short, :should_be => Policy['password']['min_length'] },
      { :length   => Policy['password']['max_length'] + 1, :message => :too_long, :should_be => Policy['password']['max_length'] },
    ]

    invalid_passwords.each do |password_params|
      @user.password = @user.password_confirmation = String.random_string(password_params[:length])
      assert_error_on(@user, :password, password_params[:message], { :count => password_params[:should_be] }, 1)
    end
  end

  def test_email_format
    @user.email = '123'
    assert !@user.valid?

    @user.email = String.random_string(5) + "@test.com"
    assert @user.valid?
  end

  def test_uniqe_email
    user = create_user(:email => @user.email)
    assert_error_on(user, :email, :taken)
  end

  protected
  def create_user(options = {})
    password = String.random_string(Policy['password'][ 'min_length' ] + 1)
    user = User.create( { 
      :name                   => 'John Doe', 
      :email                  => 'john@example.com', 
      :password               => password, 
      :password_confirmation  => password 
    }.merge( options ) )
  end
end
