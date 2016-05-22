class UdaciList
  VALID_TYPES = ["todo", "event", "link"]

  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title]
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

  private

  def parse_type(type)
    type = type.downcase
    unless VALID_TYPES.include?(type)
      raise UdaciListErrors::InvalidItemTypeError, "#{type} is not a supported item type."
    end
    type
  end
end
