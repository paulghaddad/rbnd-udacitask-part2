require "chronic"

class TodoItem
  VALID_PRIORITY_TYPES = ["high", "medium", "low"]

  include Listable

  attr_reader :description, :due, :priority
  attr_accessor :status

  def initialize(description, options={})
    @description = description
    @due = Chronic.parse(options[:due]) || options[:due]
    @priority = set_priority(options[:priority]) if options[:priority]
    @status = :not_completed
  end

  def details
    format_item_type(self) +
    format_description(description) + "due: " +
    format_date(due) +
    format_priority(priority)
  end

  def complete_item
    self.status = :completed
  end

  def completed?
    if @status == :completed
      true
    elsif @status == :not_completed
      false
    end
  end

  private

  def set_priority(priority)
    if VALID_PRIORITY_TYPES.include?(priority)
      priority
    else
      raise UdaciListErrors::InvalidPriorityValue, "#{priority} is not a valid priority type"
    end
  end
end
