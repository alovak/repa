class AddTestUsersData < ActiveRecord::Migration
  def self.up
    # User.create!(:name => 'Test', :email => 'test@test.com', :password => '123456', :password_confirmation => '123456')
  end

  def self.down
    # User.delete_all
  end
end
