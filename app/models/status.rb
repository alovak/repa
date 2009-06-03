class Status

  OPTIONS = [
    [ 'new',    1 ],
    [ 'opened', 2 ],
    [ 'closed', 3 ],
  ]

  attr_reader :status
  attr_accessor :errors

  def initialize(status)
    @status = status
    @errors = ActiveRecord::Errors.new self
  end

  def name
    OPTIONS.find {|item| item[1] == @status}[0]
  end

  def to_s
    OPTIONS.find {|item| item[1] == @status}[1]
  end

  def valid?
    return true if OPTIONS.map {|disp, value| value}.include?(@status.to_i)

    @errors.add :status, ActiveRecord::Errors.default_error_messages[:inclusion]
    return false
  end

  # def self.human_attribute_name(attr)
    # attr.humanize
  # end
end
