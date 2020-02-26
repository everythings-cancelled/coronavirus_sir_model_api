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

            context "test case 4" do
                # with no medical condition
                let(:person) do
                    described_class.new(
                        name: "Shaun",
                        age: 20,
                        gender: "male"
                    )
                end

                it "returns 100.0" do
                    expect(person.policy_price).to eq(100.0)
                end
            end
        end
    end

    describe "adjusting for gender" do
        let(:person) do
            described_class.new(
                name: "Jordan",
                age: 18,
                gender: gender,
            )
        end

        context "when the person is a male" do
            let(:gender) { "male" }

            it "subtracts nothing from the base price" do
                expect(person.policy_price).to eq(100.0)
            end
        end

        context "when the person is a female" do
            let(:gender) { "female" }

            it "subtracts 12 from the base price" do
                expect(person.policy_price).to eq(88.0)
            end
        end
    end

    context "adjusting for age" do
        let(:person) do
            described_class.new(
                name: "Jordan",
                age: age,
                gender: "male",
            )
        end

        context "when the person is less than 5 years older than the minimum wage" do
            let(:age) { 19 }

            it "adds nothing to the base price" do
                expect(person.policy_price).to eq(100)
            end
        end

        context "when the person is 5 years older than the minimum age" do
            let(:age) { 23 }

            it "adds 20 to the base price" do
                expect(person.policy_price).to eq(120)
            end
        end

        context "when the person is 6 years older than the minimum age" do
            let(:age) { 24 }

            it "adds 20 to the base price" do
                expect(person.policy_price).to eq(120)
            end
        end

        context "when the person is 10 years older than the minimum age" do
            let(:age) { 28 }

            it "adds 40 to the base price" do
                expect(person.policy_price).to eq(140)
            end
        end
    end

    context "adjusting for health conditions" do
        let(:person) do
            described_class.new(
                name: "Jordan",
                age: 18,
                gender: "male",
                health_condition: health_condition
            )
        end
        
        context "when the person has allergies" do
            let(:health_condition) { "allergies" }

            it "increases the base price by 1%" do
                expect(person.policy_price).to eq(101)
            end
        end

        context "when the person has sleep apnea" do
            let(:health_condition) { "sleep apnea" }

            it "increases the base price by 6%" do
                expect(person.policy_price).to eq(106)
            end
        end

        context "when the person has heart disease" do
            let(:health_condition) { "heart disease" }

            it "increases the base price by 17%" do
                expect(person.policy_price).to eq(117)
            end
        end

        context "when the person has no health conditions" do
            let(:health_condition) { nil }

            it "does not increase the base price" do
                expect(person.policy_price).to eq(100)
            end
        end
    end
end