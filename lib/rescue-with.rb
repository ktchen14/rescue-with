def StandardError.with
  self === $! ? yield($!) : fail
end
