class Symbol
  def to_a
    [self]
  end
end

class Array
  # Ruby 1.8.5 doesn't have count method
  def count
    self.size
  end

  def collect_non_nil(&block)
    collect {|item| block.call(item)}.delete_if {|item| item.nil?}
  end
end

class Hash
  def deep_symbolize_keys
      self.inject({}) do |result, (key, value)|
      value = value.deep_symbolize_keys if value.is_a? Hash
      result[(key.to_sym rescue key) || key] = value
      result
    end
  end
end
