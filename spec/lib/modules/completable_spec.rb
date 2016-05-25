describe Completable do
  describe "#complete_item" do
    it "changes the item's status to completed" do
      item = completable_item

      item.complete_item

      expect(item.completion_status).to eq(:complete)
    end
  end

  describe "#completed?" do
    context "item status is not complete" do
      it "is false" do
        item = completable_item

        expect(item).to_not be_completed
      end
    end

    context "item status is completed" do
      it "is true" do
        item = completable_item

        item.complete_item

        expect(item).to be_completed
      end
    end
  end

  private

  Struct.new("Completable", :completion_status) do
    include Completable
  end

  def completable_item
    Struct::Completable.new(:incomplete)
  end
end
