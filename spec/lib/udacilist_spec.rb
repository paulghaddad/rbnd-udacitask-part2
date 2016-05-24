require "spec_helper"

describe UdaciList do
  describe "#new" do 
    context "title provided" do
      it "creates a new list with the provided title" do
        title = "My new UdaciList"

        new_list = create_list(title: title)

        expect(new_list.title).to eq("My new UdaciList")
      end
    end

    context "title not provided" do
      it "creates a new list with the default title" do
        new_list = UdaciList.new

        expect(new_list.title).to eq("Untitled List")
      end
    end

    it "is initialized with an empty array of items" do
      new_list = create_list

      expect(new_list.items).to be_empty
    end
  end

  describe "#add" do
    context "todo type" do
      it "adds the item to the list" do
        list = create_list
        type = "todo"

        list.add(type, "A Todo type")

        expect(list.items.first).to be_a(TodoItem)
      end
    end

    context "event type" do
      it "adds the item to the list" do
        list = create_list
        type = "event"

        list.add(type, "A Event type")

        expect(list.items.first).to be_a(EventItem)
      end
    end

    context "link type" do
      it "adds the item to the list" do
        list = create_list
        type = "link"

        list.add(type, "A Link type")

        expect(list.items.first).to be_a(LinkItem)
      end
    end
  end

  describe "#delete" do
    context "item exists at the location" do
      it "will delete the item" do
        list = create_list
        list.add("todo", "An item to be deleted")

        list.delete(1)

        expect(list.items).to be_empty
      end
    end

    context "item does not exist at the location" do
      it "will raise an IndexExceedsListSize Exception" do
        list = create_list

        expect { list.delete(1) }.to raise_error(UdaciListErrors::IndexExceedsListSize, "No item exists at position 1 in the list")
      end
    end
  end

  describe "#all" do
    it "will print a list of all the items" do
      list = create_list(title: "A larger list")
      list.add("todo", "A todo item")
      list.add("event", "An event item")
      list.add("link", "A link item")

      expect { list.all }.to output(list_output).to_stdout
    end
  end

  describe "#filter" do
    context "list item type exist" do
      it "will return a filtered list containing items of that type" do
        list = create_list(title: "A larger list")
        list.add("todo", "A todo item")
        list.add("event", "An event item")
        list.add("link", "A link item")

        filtered_items = list.filter("todo")

        expect(filtered_items.first).to be_an_instance_of(TodoItem)
      end
    end

    context "list item type does not exist" do
      it "will raise a NoItemExists Exception" do
        list = create_list(title: "A larger list")
        list.add("event", "An event item")
        list.add("link", "A link item")

        expect { list.filter("todo") }.to raise_error(UdaciListErrors::ItemDoesNotExistError, "There are no Todo items in this list.")
      end
    end
  end

  private

  def create_list(title: "My New List")
    UdaciList.new(title: title)
  end

  def list_output
<<-LIST
-------------
A larger list
-------------
1) Todo:     A todo item                   due: N/A
2) Event:    An event item                 event dates: N/A
3) Link:     A link item                   site name: 
LIST
  end
end
