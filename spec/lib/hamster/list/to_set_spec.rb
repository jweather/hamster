require "spec_helper"
require "hamster/list"
require "hamster/set"

describe Hamster::List do
  describe "#to_set" do
    [
      [],
      ["A"],
      %w[A B C],
    ].each do |values|
      context "on #{values.inspect}" do
        it "returns a set with the same values" do
          Hamster.list(*values).to_set.should eql(Hamster.set(*values))
        end
      end
    end
  end
end