require 'sinatra'
require "sinatra/reloader"
require "pry"
require "sir_model"
require "restcountry"
require 'pomber_covid19'
require_relative "who_api_adapter"


# todo: add param validations
post "/v1/sir_model" do
    request.body.rewind
    params = JSON.parse(request.body.read)
    country = Restcountry::Country.find_by_name(params["country"])
    who_api_adapter = WhoApiAdapter.new(country.alpha3Code)
    covid19_latest_data = PomberCovid19.find_by_region_name(params["country"]).last

    resistant = covid19_latest_data["recovered"] + covid19_latest_data["deaths"]
    non_susceptible = resistant - covid19_latest_data["confirmed"]

    model = SirModel.new(
        eons: params["eons"].to_i,
        infected: covid19_latest_data["confirmed"],
        susceptible: country.population - non_susceptible,
        resistant: resistant,
        rate_si: params["rateSi"].to_f,
        rate_ir: params["rateRi"].to_f,
        population: country.population
    )

    content_type :json

    # todo: this is bad!  only for development now, we dont want this in a final prod app
    # headers 'Access-Control-Allow-Origin' => '*'

    { 
        country: params["country"], 
        population: country.population, 
        points: model.results,
        hospitalBedsPer10000People: who_api_adapter.hospital_beds_per_10000_people
    }.to_json
end
