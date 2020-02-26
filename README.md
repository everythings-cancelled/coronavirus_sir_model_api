### Shaun Carland

This is my solution for the Policy Genius take home assignment! :)

I implemented a simple Sinatra application that has a `v1/policy_prices` endpoint.  To calculate the policy prices, simply shoot over a post request with a body in the following format:

```
{
	"people": [
		{
			"name": "Kelly",
			"gender": "female",
			"age": 50,
			"health condition": "allergies"
		},
		{
			"name": "Josh",
			"gender": "male",
			"age": 40,
			"health condition": "sleep apnea"
		},
		{
			"name": "Brad",
			"gender": "male",
			"age": 20,
			"health condition": "heart disease"
		}

	]
}
```
You can access the application online by sending POST requests `POST` requests to `https://tickle-api.herokuapp.com/v1/policy_prices`.  You should get a response in the following format:


```
{
    "policy_prices": [
        {
            "name": "Kelly",
            "policy_price": 210.2
        },
        {
            "name": "Josh",
            "policy_price": 190.8
        },
        {
            "name": "Brad",
            "policy_price": 117
        }
    ]
}
```

To run the application locally, simply:
- Unzip the package
- Make sure you have the dependencies outlined in `DEPENDENCIES.md`.
- In the `tickle_api` directory, run `bundle install`
- Run `ruby app.rb` to load up a local server.  You can make `POST` requests to that server's `v1/policy_prices` endpoint.

To run the tests, simply run `rspec` in the `tickle_api` directory.

You should in turn get a response in the following format:

###Some notes:

For the Person specs, you can see that I wrote tests testing all of the cases that were provided in the Google Doc.  However, I also wrote tests to see how each of the factors (e.g. age, gender, health condition) impacted the base price.  I was happy that my tests were passing for the test cases provided.  However, I wanted to have a more robust test suite to make sure that each factor was working independently.

In my first stab at this, I made all of the factor methods public so I could test them in the following format:

```
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
    # and so on and so on...
```

This felt wrong to me though.  The public interface of the person class that we're concerned about is the `policy_price` method.  I don't like to expose methods simply for the point of unit testing them.  In my opinion, tests should be documenting how the class does something, not what it does.  If we don't expect the user to do something like `person.age_factor`, then we shouldn't have a unit test for it.  We can test the same behaviors of all of these factors by testing them in isolation against the `policy_price` method, which is what we're doing in my current test suite.


In the instructions, you all recommended using a vanilla language, and not a framework.  I decided to use Sinatra anyways for a few reasons:
- Using Sinatra provides a clean separation of concerns between taking in an input and returning an output.  It felt cleaner to me than say, opening and parsing files.  Because parsing files can be a bit messy, e.g. taking account for different types of file extensions, dealing when files are missing, etc.

- By implementing a single endpoint, we have a clear single public interface to get insurance prices.  The user of this service doesn't need to know anything about how the Person class works, how the endpoint works.  All they need to do is know how to post to endpoints, and what the specifications of the body should be in the POST request.

- By using a Sinatra endpoint, we have a clear separation of concerns between getting the data (Rack) , parsing the data (the Sinatra endpoint), calculating the Policy Prices (the Person class) and returning the results (the Sinatra endpoint).

- It's fairly simple to test Sinatra endpoints.

- In the Google Doc provided, you all say "it should be easily extensible should the format change (or new formats be added) in the future.".  As you can see, I namespaced my `policy_prices` endpoint, prefixing it with `v1`.  If we want to drastically extend our inputting/outputting formats, we can just create a new endpoint (e.g. `v2/policy_prices`).

I figured that using something like Rails would probably be overkill.  But Sinatra is very lightweight and doesn't require nearly as much overhaul.  And for the reasons I described, I think it's the best design choice.

In my Sinatra app, I didn't add any parameter validations.  This is something that I would totally do in production code!  If I was using Rails, I would probably use strong params (https://edgeapi.rubyonrails.org/classes/ActionController/StrongParameters.html).  Since there was a time limit to this, I didn't want to spend too much extra time writing tests for valid params/implementing valid params/etc.



https://docs.google.com/document/d/1ASI8PFrQ7kB1cizLsf3aTf4hoN-9T7JBdjdqOK4jwbU/edit
