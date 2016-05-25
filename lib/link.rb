class LinkItem
  include Listable
  include Completable

  attr_reader :description, :site_name
  attr_accessor :completion_status

  def initialize(url, options={})
    @description = url
    @site_name = options[:site_name]
    @completion_status = :not_complete
  end

  def format_name
    site_name || ""
  end

  def details
    format_item_type(self) +
    format_description(description) +
    "site name: " +
    format_name
  end
end
