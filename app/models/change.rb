class Change < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  belongs_to :assignee_is, :class_name => 'User', :foreign_key => :assignee_id_is
  belongs_to :assignee_was, :class_name => 'User', :foreign_key => :assignee_id_was
  belongs_to :ticket

  default_scope :order => 'created_at DESC'
end
