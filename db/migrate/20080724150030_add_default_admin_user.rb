class AddDefaultAdminUser < ActiveRecord::Migration
  def self.up
    User.create!(:name => 'Admin', :email => 'admin@admin.com', :password => '123456', :password_confirmation => '123456', :is_admin => true)
  end

  def self.down
    User.delete_all "email = 'admin@admin.com'" 
  end
end
