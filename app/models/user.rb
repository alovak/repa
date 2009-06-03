require 'digest/sha1'

class User < ActiveRecord::Base
  has_and_belongs_to_many   :groups
  has_many :tasks
  has_many  :works, :foreign_key => :owner_id


  validates_presence_of     :email
  validates_uniqueness_of   :email
  validates_format_of       :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :unless => 'email.blank?'

  validates_presence_of     :name
  validates_length_of       :name, :maximum => 50, :unless => 'name.blank?'


  validates_presence_of     :password, :on => :create
  validates_length_of       :password, :in => Policy['password']['min_length']..Policy['password']['max_length'], :unless => 'password.blank?'

  attr_accessor :password_confirmation
  validates_confirmation_of :password, :unless => 'password.blank?'

  def password
    @password
  end

  def groups_works(args = {})
    Work.search( :page => args[:page], :conditions => ["group_id IN (?)", group_ids] )
  end

  def password=(pwd)
    return if pwd.blank?
    @password = pwd
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    if user
      expected_password = encrypted_password(password, user.salt)
      user = nil if user.hashed_password != expected_password
    end
    user
  end

  private

  def self.encrypted_password(password, salt)
    string_to_hash = password + "supper pupper" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
end
