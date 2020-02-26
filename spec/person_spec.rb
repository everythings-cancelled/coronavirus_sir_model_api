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

    describe "#gender_factor" do
        let(:person) do
            described_class.new(
                name: "Jordan",
                age: 40,
                gender: gender,
                health_condition: "sleep apnea"
            )
        end

        context "when the person is a male" do
            let(:gender) { "male" }

            it "returns 0" do
                expect(person.gender_factor).to eq(0)
            end
        end

        context "when the person is a female" do
            let(:gender) { "female" }

            it "returns -12" do
                expect(person.gender_factor).to eq(-12)
            end
        end
    end

    context "#age_factor" do
        let(:person) do
            described_class.new(
                name: "Jordan",
                age: age,
                gender: "male",
                health_condition: "sleep apnea"
            )
        end

        context "when the person is 5 years older than the minimum age" do
            let(:age) { 23 }

            it "returns 20" do
                expect(person.age_factor).to eq(20)
            end
        end

        context "when the person is 6 years older than the minimum age" do
            let(:age) { 24 }

            it "returns 20" do
                expect(person.age_factor).to eq(20)
            end
        end

        context "when the person is 10 years older than the minimum age" do
            let(:age) { 28 }

            it "returns 40" do
                expect(person.age_factor).to eq(40)
            end
        end
    end

    context "#health_condition_factor" do
        context "when the person has allergies" do
            it "returns 1.01" do
            end
        end

        context "when the person has sleep apnea" do
            it "returns 1.06" do
            end
        end

        context "when the person has heart disease" do
            it "returns 1.17" do
            end
        end

        context "when the person has no health conditions" do
            it "returns 1" do
            end
        end
    end
end