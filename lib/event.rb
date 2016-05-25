require "./lib/modules/listable"
require "./lib/modules/completable"

class EventItem
  include Listable
  include Completable

  attr_reader :description, :start_date, :end_date
  attr_accessor :completion_status

  def initialize(description, options={})
    @description = description
    @start_date = Date.parse(options[:start_date]) if options[:start_date]
    @end_date = Date.parse(options[:end_date]) if options[:end_date]
    @completion_status = :not_complete
  end

  def details
    format_item_type(self) +
    format_description(description) +
    "event dates: " +
    format_date(start_date, end_date)
  end
end
