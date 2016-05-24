require "./lib/todo"
require "./lib/event"
require "./lib/link"

class UdaciList
  VALID_TYPES = ["todo", "event", "link"]
  TYPE_TO_CLASS_MAPPING = { "todo" => TodoItem,
                            "event" => EventItem,
                            "link" => LinkItem }

  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] || "Untitled List"
    @items = []
  end

  def add(type, description, options={})
    type= parse_type(type)
    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
  end

  def delete(index)
    if index > items.length
      raise UdaciListErrors::IndexExceedsListSize, "No item exists at position #{index} in the list"
    end
    @items.delete_at(index - 1)
  end

  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end

  def filter(item_type)
    filtered_items = items.select do |item|
      item.class == item_class(item_type)
    end
    if filtered_items.empty?
      raise UdaciListErrors::ItemDoesNotExistError, "There are no #{item_type.capitalize} items in this list."
    end
    filtered_items
  end

  private

  def parse_type(type)
    type = type.downcase
    unless VALID_TYPES.include?(type)
      raise UdaciListErrors::InvalidItemTypeError, "#{type} is not a supported item type."
    end
    type
  end

  def item_class(item_type)
    TYPE_TO_CLASS_MAPPING[item_type]
  end
end
