require "spec_helper"
require "hamster/hash"

describe Hamster::Hash do
  [:get, :[]].each do |method|
    describe "##{method}" do
      context "with a default block" do
        let(:hash) { Hamster.hash("A" => "aye") { |key| fail }}

        context "when the key exists" do
          it "returns the value associated with the key" do
            hash.get("A").should == "aye"
          end
        end

        context "when the key does not exist" do
          let(:hash) do
            Hamster.hash("A" => "aye") do |key|
              expect(key).to eq("B")
              "bee"
            end
          end

          it "returns the value associated with the key" do
            hash.get("B").should == "bee"
          end
        end
      end

      context "with no default block" do
        let(:hash) { Hamster.hash("A" => "aye", "B" => "bee", "C" => "see", nil => "NIL") }

        [
          %w[A aye],
          %w[B bee],
          %w[C see],
          [nil, "NIL"]
        ].each do |key, value|
          it "returns the value (#{value.inspect}) for an existing key (#{key.inspect})" do
            hash.send(method, key).should == value
          end
        end

        it "returns nil for a non-existing key" do
          hash.send(method, "D").should be_nil
        end
      end
    end
  end
end