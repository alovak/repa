class Work < ActiveRecord::Base
  composed_of (:status) {|params| Status.new(params[:status].to_i)}

  belongs_to :task
  belongs_to :owner, :class_name => 'User', :foreign_key => 'owner_id'
  belongs_to :group

  validates_associated :status

  def before_update
    self.owner = nil if self.status.name == 'new'
  end

  def self.search(args = {})
    paginate  :all, 
              :include => [:owner, :task, :group], 
              :page => args[:page], :per_page => 15, 
              :order => 'created_at DESC', 
              :conditions => args[:conditions]
  end

  def auto_close(owner_id)
    Work.record_timestamps = false
    self.updated_at = Rand.period_date( self.created_at, task.periodicity.periodicity )
    self.owner_id = owner_id
    self.status = Status.new(3)
    save
    Work.record_timestamps = true
  end
end
