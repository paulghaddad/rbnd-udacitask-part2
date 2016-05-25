module Completable
  def complete_item
    self.completion_status = :complete
  end

  def completed?
    if completion_status == :complete
      true
    elsif completion_status == :not_complete
      false
    end
  end
end
