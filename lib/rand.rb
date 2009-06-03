class String
  def self.random_string(length)
    chars ||= ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
    (0...length).collect { chars[Kernel.rand(chars.size-1)] }.join
  end
  def my_func
    puts "Hello"
  end
end

module Rand
  def self.period_date( date_from, period )
    delta = (Date.today.to_datetime - date_from.to_datetime).to_i
    period = delta if period > delta
    period_date = rand(60*24*(period)).minutes.since( date_from )
  end
end
