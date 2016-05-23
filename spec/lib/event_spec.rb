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

        event_item = EventItem.new("New item", start_date: start_date)

        expect(event_item.start_date).to eq(Date.new(2016, 5, 1))
      end
    end

    context "end date provided" do
      it "has a end date" do
        end_date = "2016-05-01"

        event_item = EventItem.new("New item", end_date: end_date)

        expect(event_item.end_date).to eq(Date.new(2016, 5, 1))
      end
    end
  end

  describe "#details" do
    it "shows the details of the event item" do
      event_item = EventItem.new("New item",
                                 start_date: "2016-05-1",
                                 end_date: "2016-05-20")

      expect(event_item.details).to eq("New item                      event dates: 05/01/16 -- 05/20/16")
    end
  end
end
