class Symbol
  def to_a
    [self]
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
