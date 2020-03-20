require 'sinatra'
require "sinatra/reloader"
require "pry"
require "sir_model"

require_relative "rest_countries_api_adapter"
require_relative "coronavirus_tracker_api_adapter"
require_relative "who_api_adapter"
require_relative "country"
require_relative "country_adapter"

get "/v2/sir_model" do
    # temp default values
    rate_si = params["rateSi"].nil? ? 0.05 : params["rateSi"].to_f
    rate_ri = params["rateRi"].nil? ? 0.01 : params["rateRi"].to_f

    country_adapter = CountryAdapter.new(params["country"])
    country = Country.new(country_adapter)
    coronavirus_tracker_api_adapter = CoronavirusTrackerApiAdapter.new("https://coronavirus-tracker-api.herokuapp.com/v2/", country.alpha_2_code)
    who_api_adapter = WhoApiAdapter.new(country.alpha_3_code)

    resistant = coronavirus_tracker_api_adapter.recovered + coronavirus_tracker_api_adapter.deaths
    susceptible = country.population - resistant - coronavirus_tracker_api_adapter.confirmed

    model = SirModel.new(
        eons: params["eons"].to_i,
        infected: coronavirus_tracker_api_adapter.confirmed,
        susceptible: susceptible,
        resistant: resistant,
        rate_si: rate_si,
        rate_ir: rate_ri,
        population: params["population"].nil? ? nil :  params["population"].to_i
    )

    content_type :json

    { 
        country: params["country"], 
        population: country.population, 
        points: model["results"],
        hospital_beds_per_10000_people: who_api_adapter.hospital_beds_per_10000_people
    }.to_json

end

get "/v1/sir_model" do
    country_adapter = CountryAdapter.new(params["country"])
    
    rest_countries_api_adapter = RestCountriesApiAdapter.new("https://restcountries.eu/rest/v2/name/", params["country"])
    coronavirus_tracker_api_adapter = CoronavirusTrackerApiAdapter.new("https://coronavirus-tracker-api.herokuapp.com/v2/", rest_countries_api_adapter.country_code)

    # who_api_adapter = WhoApiAdapter.new("can")
    resistant = coronavirus_tracker_api_adapter.recovered + coronavirus_tracker_api_adapter.deaths
    susceptible = rest_countries_api_adapter.country_population - resistant - coronavirus_tracker_api_adapter.confirmed

    model = SirModel.new(
        eons: params["eons"].to_i,
        infected: coronavirus_tracker_api_adapter.confirmed,
        susceptible: susceptible,
        resistant: resistant,
        rate_si: params["rateSi"].to_f,
        rate_ir: params["rateIr"].to_f,
        population: params["population"].nil? ? nil :  params["population"].to_i
    )

    content_type :json
    
    # https://nifty-fermi-3c4ae9.netlify.com/
    # todo: this is bad!  we want to whitelist, not just let everything in
    # make sure to fix it l8r!
    headers 'Access-Control-Allow-Origin' => '*'

    { 
        country: params["country"], 
        population: rest_countries_api_adapter.country_population, 
        points: model["results"],
        hospital_beds_per_10000_people: who_api_adapter.hospital_beds_per_10000_people
    }.to_json
end