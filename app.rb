require 'sinatra'
require "sinatra/reloader"
require "pry"
require "sir_model"
require "restcountry"
require 'pomber_covid19'

require_relative "who_api_adapter"
require_relative "coronavirus_adapter"
require_relative "coronavirus"


# todo: add param validations
post "/v1/sir_model" do
    request.body.rewind
    params = JSON.parse(request.body.read)
    country = Restcountry::Country.find_by_name(params["country"])
    who_api_adapter = WhoApiAdapter.new(country.alpha3Code)
    covid19_latest_data = PomberCovid19.find_by_region_name(params["country"].capitalize).first

    model = SirModel.new(
        eons: params["eons"].to_i,
        infected: coronavirus.infected,
        susceptible: country.population - coronavirus.non_susceptible,
        resistant: coronavirus.resistant,
        rate_si: params["rateSi"].to_f,
        rate_ir: params["rateRi"].to_f,
        population: country.population
    )

    content_type :json

    # todo: this is bad!  only for development now, we dont want this in a final prod app
    headers 'Access-Control-Allow-Origin' => 'http://localhost:3000'

    { 
        country: params["country"], 
        population: country.population, 
        points: model.results,
        hospitalBedsPer10000People: who_api_adapter.hospital_beds_per_10000_people
    }.to_json
    
end

get "/v1/sir_model" do
    country_adapter = CountryAdapter.new(params["country"])
    country = Country.new(country_adapter)

    coronavirus_adapter = CoronavirusAdapter.new(country.alpha_2_code)
    coronavirus = Coronavirus.new(coronavirus_adapter)

    who_api_adapter = WhoApiAdapter.new(country.alpha_3_code)

    model = SirModel.new(
        eons: params["eons"].to_i,
        infected: coronavirus.infected,
        susceptible: country.population - coronavirus.non_susceptible,
        resistant: coronavirus.resistant,
        rate_si: params["rateSi"].to_f,
        rate_ir: params["rateiR"].to_f,
        population: country.population
    )

    # todo: this is bad!  only for development now, we dont want this in a final prod app
    headers 'Access-Control-Allow-Origin' => 'http://localhost:3000'

    content_type :json
    { 
        country: params["country"], 
        population: country.population, 
        points: model.results,
        hospitalBedsPer10000People: who_api_adapter.hospital_beds_per_10000_people
    }.to_json
end