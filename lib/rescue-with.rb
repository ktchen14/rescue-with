class Array
  def with
    any? { |e| e === $! } ? yield($!) : fail
  end
end

def StandardError.with
  self === $! ? yield($!) : fail
end
