require 'sinatra'
require "sinatra/reloader"
require "pry"
require_relative "person"

before do
    request.body.rewind
    @request_payload = JSON.parse(request.body.read)
end

post '/v1/policy_prices' do
    people = @request_payload["people"].map do |person|
        # todo: write specs for downcasing gender/health condition...?  and validate params?
        Person.new(
            gender: person["gender"].downcase,
            age: person["age"],
            name: person["name"],
            health_condition: person["health condition"].downcase
        )
    end

    policy_prices = people.map do |person|
        { name: person.name, policy_price: person.policy_price }
    end

    content_type :json
    { policy_prices: policy_prices }.to_json
end