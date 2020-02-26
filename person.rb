class Person
    GENDER_MALE = 'male'
    GENDER_FEMALE = 'female'
    BASE_PRICE = 100
    MIN_AGE = 18

    # todo: fix when there is no health condition factor
    HEALTH_CONDITION_FACTORS = {
        "allergies" => 1.01,
        "sleep apnea" => 1.06,
        "heart disease" => 1.17
    }

    attr_reader :name, :age, :gender, :health_condition

    def initialize(name:, age:, gender:, health_condition:nil)
        @name = name
        @age = age
        @gender = gender
        @health_condition = health_condition
    end

    def policy_price
        (BASE_PRICE + age_factor)*health_condition_factor + gender_factor
    end

    private

    def gender_factor
        gender == GENDER_FEMALE ? -12 : 0
    end

    def age_factor
        ((age - MIN_AGE) / 5) * 20
    end

    def health_condition_factor
        HEALTH_CONDITION_FACTORS[health_condition] || 1
    end
end