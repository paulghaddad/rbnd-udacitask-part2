module UdaciListErrors
  class InvalidItemTypeError < StandardError
  end

  class IndexExceedsListSize < StandardError
  end

  class InvalidPriorityValue < StandardError
  end
end
