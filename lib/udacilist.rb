require "./lib/todo"
require "./lib/event"
require "./lib/link"
require "ruby-progressbar"

class UdaciList
  VALID_TYPES = ["todo", "event", "link"]
  ITEM_TYPE_TO_CLASS_MAPPING = { "todo" => TodoItem,
                                 "event" => EventItem,
                                 "link" => LinkItem }

  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] || "Untitled List"
    @items = []
  end

  def add(type, description, options={})
    type= parse_type(type)
    @items << ITEM_TYPE_TO_CLASS_MAPPING[type].new(description, options)
  end

  def delete(index)
    if index > items.length
      raise UdaciListErrors::IndexExceedsListSize, "No item exists at position #{index} in the list"
    end
    @items.delete_at(index - 1)
  end

  def all
    puts "-" * title.length
    puts title
    puts "-" * title.length
    items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
    puts
    puts print_progress_bar
  end

  def filter(item_type)
    filtered_items = filter_items(item_type)
    check_if_no_filtered_items(filtered_items, item_type) || filtered_items
  end

  def items_complete
    items.count(&:completed?)
  end

  private

  def parse_type(type)
    type = type.downcase
    check_if_valid_item_type(type) || type
  end

  def item_class(item_type)
    ITEM_TYPE_TO_CLASS_MAPPING[item_type]
  end

  def filter_items(item_type)
    items.select do |item|
      item.class == item_class(item_type)
    end
  end

  def check_if_no_filtered_items(filtered_items, item_type)
    if filtered_items.empty?
      raise UdaciListErrors::ItemDoesNotExistError, "There are no #{item_type.capitalize} items in this list."
    end
  end

  def check_if_valid_item_type(item_type)
    unless VALID_TYPES.include?(item_type)
      raise UdaciListErrors::InvalidItemTypeError, "#{item_type} is not a supported item type."
    end
  end

  def create_progress_bar
    ProgressBar.create(:title => "Progress",
                                 :total => items.size,
                                 :length => 50)
  end

  def increment_progress_bar(progress_bar)
    items_complete.times do
      progress_bar.increment
    end
  end

  def print_progress_bar
    progress_bar = create_progress_bar
    increment_progress_bar(progress_bar)
    progress_bar
  end
end
