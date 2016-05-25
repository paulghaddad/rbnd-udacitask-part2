require "spec_helper"
require "date"

describe EventItem do
  describe "#initialize" do
    it "has a description" do
      description = "New event item"

      event_item = EventItem.new(description)

      expect(event_item.description).to eq(description)
    end

    context "start date provided" do
      it "has a start date" do
        start_date = "2016-05-01"

        event_item = create_event_item(start_date: start_date)

        expect(event_item.start_date).to eq(Date.new(2016, 5, 1))
      end
    end

    context "end date provided" do
      it "has a end date" do
        end_date = "2016-05-01"

        event_item = create_event_item(end_date: end_date)

        expect(event_item.end_date).to eq(Date.new(2016, 5, 1))
      end
    end

    it "has a completion status initially set to not_completed" do
      event_item = create_event_item

      expect(event_item.completion_status).to eq(:not_complete)
    end
  end

  describe "#details" do
    it "shows the details of the event item" do
      event_item = create_event_item(description: "New item",
                                     start_date: "2016-05-1",
                                     end_date: "2016-05-20")

      expect(event_item.details).to eq("Event:    New item                      event dates: 05/01/16 -- 05/20/16")
    end
  end

  private

  def create_event_item(options = {})
    description = options[:description] || "My new event item"
    start_date = options[:start_date]
    end_date = options[:end_date]

    EventItem.new(description, start_date: start_date, end_date: end_date)
  end
end
