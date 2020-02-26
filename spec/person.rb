require "spec_helper"

describe Person do
    describe "#policy_price" do
        describe "test cases" do
            context "test case 1" do
                let(:person) do
                    described_class.new(
                        name: "Kelly",
                        gender: "female",
                        age: 50,
                        health_condition: "allergies"
                    )
                end

                it "returns 210.20" do
                    expect(person.policy_price).to eq(210.20)
                end    
            end

            context "test case 2" do
                it "returns 190.80" do
                end
            end

            context "test case 3" do
                it "returns 117.0" do
                end
            end
        end
    end
end