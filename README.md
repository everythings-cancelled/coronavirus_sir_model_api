Not sure where to start?  Visit https://shauncar.land/projects/everythings-cancelled/ for more information on the *Everything's Cancelled* project.

## Coronavirus SIR Model API
This is an API that builds a Susceptible-Infected-Recovered (SIR) model from Coronavirus Data.  You can access it at: `https://coronavirus-sir-model-api.herokuapp.com/v1/sir_model`.

The SIR model is one of the simplest compartmental models, and many models are derivations of this basic form.  The model consists of three compartments: S for the number of susceptible people in a population, I for the number of infectious people in a population, and R for the number resillient people (either dead or recovered in a population).  The model represents the number of people in each compartment for an abstract unit of time (called an eon).

For more information: https://en.wikipedia.org/wiki/Compartmental_models_in_epidemiology#The_SIR_model_is_dynamic_in_three_senses

### Endpoints
We are maintaining the following endpoints:

#### POST `/v1/sir_model`
Posting to this endpoint will give you the results of a SIR model built off of a country's demographic and Coronavirus data.  POST requests should have a body in the following format:

```
{
	"rateSi": 0.05,
	"rateRi": 0.01,
	"eons": 2,
	"country": "Canada"
}
```

Where:
- `rateSi` is the rate in which an individual goes from being susceptable to being infected
- `rateRi` is the rate in which an individual goes from being infected to being resistant
- `eons` is the length of the model simulation
- `country` is the name of the country

The endpoint returns data in the following format:
```
{
  "country":"Canada",
  "population":36155487,
  "hospital_beds_per_10000_people":27.0,
  "points":[
    {"eon":0,"susceptible":36155707,"infected":231,"resistant":11,
    {"eon":1,"susceptible":36155695.44992972,"infected":242.55007027978905,"resistant":11.0
    {"eon":2,"susceptible":36155683.32235629,"infected":254.67764371338035,"resistant":11.0}
    ]
  }
```

Where:
- `country` is the name of the country
- `population` is the country's population, according to `https://restcountries.eu/`
- `hospitalBedsPer10000People` is the ratio of hospital beds per 10,000 people, according to the World Health Organization
- `points` is an array containing JSON formatted points of the model's simulation.  Specifically, each point indicates the number of `susceptible`, `infected`, and `resistant` individuals in a population on a given `eon`.

## Running the tests
Tests still need to be written for this :X.  But once they are, you can simply run `$ spec` in the main directory.
