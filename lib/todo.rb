require "chronic"
require "./lib/modules/listable"
require "./lib/modules/completable"

class TodoItem
  VALID_PRIORITY_TYPES = ["high", "medium", "low"]

  include Listable
  include Completable

  attr_reader :description, :due, :priority
  attr_accessor :completion_status

  def initialize(description, options={})
    @description = description
    @due = Chronic.parse(options[:due]) || options[:due]
    @priority = set_priority(options[:priority]) if options[:priority]
    @completion_status = :not_complete
  end

  def details
    format_item_type(self) +
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
