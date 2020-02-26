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
                let(:person) do
                    described_class.new(
                        name: "Josh",
                        age: 40,
                        gender: "male",
                        health_condition: "sleep apnea"
                    )
                end

                it "returns 190.80" do
                    expect(person.policy_price).to eq(190.80)
                end
            end

            context "test case 3" do
                let(:person) do
                    described_class.new(
                        name: "Brad",
                        age: 20,
                        gender: "male",
                        health_condition: "heart disease"
                    )
                end

                it "returns 117.0" do
                    expect(person.policy_price).to eq(117.0)
                end
            end
        end
    end
end