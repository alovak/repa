class Periodicity

  PERIODS = [
    [ 'Ежедневно',    1 ],
    [ 'Еженедельно',  7 ],
    [ 'Ежемесячно',   31 ],
    [ 'Ежеквартально', 93 ],
    [ 'Ежегодно',     365 ]
  ]

  attr_accessor :periodicity, :errors

  def initialize(periodicity)
    self.periodicity = periodicity
    @errors = ActiveRecord::Errors.new self
  end

  def self.periods
    PERIODS
  end

  def name
    PERIODS.find {|item| item[1] == @periodicity}[0]
  end

  def to_s
    PERIODS.find {|item| item[1] == @periodicity}[1]
  end

  def to_i
    PERIODS.find {|item| item[1] == @periodicity}[1]
  end

  def valid?
    return true if Periodicity.periods.map {|disp, period| period}.include?(@periodicity.to_i)

    @errors.add :periodicity, ActiveRecord::Errors.default_error_messages[:inclusion]
    return false
  end

  def self.human_attribute_name(attr)
    attr.humanize
  end

  # def new_record?
    # true
  # end
end
