class Person
    GENDER_MALE = 'male'
    GENDER_FEMALE = 'female'
    BASE_PRICE = 100
    MIN_AGE = 18

    HEALTH_CONDITION_FACTORS = {
        "allergies" => 1.01,
        "sleep apnea" => 1.06,
        "heart disease" => 1.17
    }

    attr_reader :name, :age, :gender, :health_condition

    def initialize(name:, age:, gender:, health_condition:)
        @name = name
        @age = age
        @gender = gender
        @health_condition = health_condition
    end

    def policy_price
        (BASE_PRICE + age_factor)*HEALTH_CONDITION_FACTORS[health_condition] + gender_factor
    end

    def gender_factor
        gender == GENDER_FEMALE ? -12 : 0
    end

    def age_factor
        ((age - MIN_AGE) / 5) * 20
    end
end