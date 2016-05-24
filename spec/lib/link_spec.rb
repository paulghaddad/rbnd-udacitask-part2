require "spec_helper"

describe LinkItem do
  describe "#initialize" do
    it "has a description containing the URL" do
      url = "www.google.com"

      link_item = LinkItem.new(url)

      expect(link_item.description).to match(url)
    end

    context "site name provided" do
      it "has a site name" do
        site_name = "Google"

        link_item = create_link_item(site_name: site_name)
        expect(link_item.site_name).to eq(site_name)
      end
    end
  end

  describe "#format_name" do
    context "site name exists" do
      it "is the site name" do
        link_item = create_link_item(site_name: "Google")

        expect(link_item.format_name).to match(/Google/)
      end
    end

    context "site name does not exist" do
      it "is an empty string" do
        link_item = create_link_item

        expect(link_item.format_name).to eq("")
      end
    end
  end

  describe "#details" do
    it "is a formatted string of the item" do
      link_item = create_link_item(url: "www.google.com", site_name: "Google")

      expect(link_item.details).to eq("LinkItem: www.google.com                site name: Google")
    end
  end

  private

  def create_link_item(options = {})
    url = options[:url] || "www.google.com"
    site_name = options[:site_name]
    LinkItem.new(url, site_name: site_name)
  end
end
