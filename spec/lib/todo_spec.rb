require "spec_helper"
require "date"

describe TodoItem do
  describe "#initialize" do
    it "has a description" do
      description = "A new todo"

      todo = TodoItem.new(description)

      expect(todo).to have_attributes(description: description)
    end

    context "due option present" do
      it "sets the due date" do
        due = "2016-05-01"

        todo = create_todo_item(due: due)

        expect(todo).to have_attributes(due: Chronic.parse(Date.new(2016, 5, 1)))
      end
    end

    context "priority option present" do
      context "valid priority type" do
        it "sets the priority type" do
          priority = "high"

          todo = create_todo_item(priority: priority)

          expect(todo).to have_attributes(priority: priority)
        end
      end

      context "invalid priority type" do
        it "raises an InvalidPriorityValue Exception" do
          priority = "invalid type"

          expect { create_todo_item(priority: priority) }.to raise_exception(UdaciListErrors::InvalidPriorityValue, "invalid type is not a valid priority type")
        end
      end
    end
  end

  describe "#details" do
    it "shows the item type and details of the todo item" do
      todo = create_todo_item(description: "My new todo",
                              due: "5-1-2016",
                              priority: "high")

      expect(todo.details).to match(/Todo:     My new todo                   due: 05\/01\/16.+⇧/)
    end
  end

  private

  def create_todo_item(options = {})
    description = options[:description] || "My new todo"
    due = options[:due]
    priority = options[:priority]

    TodoItem.new(description, due: due, priority: priority)
  end
end
