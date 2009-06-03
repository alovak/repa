class Task < ActiveRecord::Base
  belongs_to  :group
  has_many    :works, :dependent => :delete_all
  composed_of (:periodicity) {|params| Periodicity.new(params[:periodicity])}

  validates_presence_of :name, :description, :group_id, :start_on
  validates_length_of   :name, :maximum => 50
  validates_length_of   :description, :maximum => 2048 

  validates_associated  :group
  validates_associated  :periodicity, :message => nil

  attr_protected  :create_work_on

  def before_create
    self.create_work_on = start_on
  end

  def before_update
    self.create_work_on = start_on if start_on_changed?
  end

  def create_work
    work = Work.create(:task => self, :owner => nil, :group => group, :status => {:status => 1}, :created_at => create_work_on.to_datetime)
    update_attribute(:create_work_on,self.create_work_on + self.periodicity.periodicity) 
    work
  end

  def self.create_missed_works
    works_count = 0
    while !(tasks = Task.find_tasks_for_works).empty? 
      tasks.each do |task| 
        task.create_work
        works_count += 1
      end
    end
    works_count
  end

  def self.find_tasks_for_works
    find(:all, :conditions => [ 'create_work_on <= ?', Date.today ])
  end
end
