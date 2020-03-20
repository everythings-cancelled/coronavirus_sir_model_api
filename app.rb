require 'sinatra'
require "sinatra/reloader"
require_relative "sir_model_api_adapter"
require "pry"

get "/v1/sir_model" do
    sir_model_api_adapter = SirModelApiAdapter.new
    # todo: get the population of the country
    # get its infected and resistant rates from adapter
    # plug all of those values into the model

    # todo: paramaterize it
    sir_model_api_adapter.build_model(
        eons: 5,
        infected: 50,
        susceptible: 950,
        resistant: 0,
        rate_si: 0.05,
        rate_ir: 0.01,
        population: 100
    )

    # who_api_adapter = WhoApiAdapter.new(who_api_url)
    # rest_countries_api_adapter = RestCountriesAdapter.new(rest_countries_api_url)
    # coronavirus_tracker_api_adapter = CoronavirusTrackerApiAdapter.new(coronavirus_tracker_api_url)


    # hospital_adapter = HospitalAdapter.new(hospital_url)
    # region_adapter = RegionAdapter.new(region_url)
end