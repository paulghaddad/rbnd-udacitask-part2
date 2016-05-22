class TodoItem
  VALID_PRIORITY_TYPES = ["high", "medium", "low"]

  include Listable

  attr_reader :description, :due, :priority

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Date.parse(options[:due]) : options[:due]
    @priority = set_priority(options[:priority]) if options[:priority]
  end

  def details
    format_description(description) + "due: " +
    format_date(due) +
    format_priority(priority)
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
