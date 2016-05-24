module UdaciListErrors
  class InvalidItemTypeError < StandardError
  end

  class IndexExceedsListSize < StandardError
  end

  class InvalidPriorityValue < StandardError
  end

  class ItemDoesNotExistError < StandardError
  end
end
