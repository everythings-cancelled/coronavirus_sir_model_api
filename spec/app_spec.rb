require "spec_helper"

describe "App" do
    describe "/v1" do
        describe "POST #policy_prices" do
            let(:person_1_json) do
                {
                    "name" => "Kelly",
                    "gender" => "female",
                    "age" => 50,
                    "health condition" => "allergies"
                }
            end

            let(:person_2_json) do
                {
                    "name" => "Josh",
                    "age" => 40,
                    "gender" => "male",
                    "health condition" => "sleep apnea"
                }
            end

            let(:body) { { people: [person_1_json, person_2_json] }.to_json }

            before do
                allow_any_instance_of(Person).to receive(:policy_price).and_return("foo")
            end

            it "returns a 200 status" do
                post "/v1/policy_prices", body
                expect(last_response.status).to eq(200)
            end

            it "returns an array of jsons with the person's name and calculated policy price" do
                post "/v1/policy_prices", body
                expected_body = { "policy_prices" => [{ "name" => "Kelly", "policy_price" => "foo" }, { "name" => "Josh", "policy_price" => "foo" }] }
                expect(JSON.parse(last_response.body)).to eq(expected_body)
            end

            context "when the health condition and gender have mixed capitalization" do
                let(:person_json) do
                    {
                        "name" => "Kelly",
                        "gender" => "fEmAlE",
                        "age" => 50,
                        "health condition" => "aLlErGiEs"
                    }
                end

                let(:body) { { people: [person_json] }.to_json }
                
                it "creates a person with the health condition and gender all downcased" do
                    expect(Person).to receive(:new).with(name: "Kelly", gender: "female", health_condition: "allergies", age: 50)
                    post "/v1/policy_prices", body
                end
            end
        end
    end
end