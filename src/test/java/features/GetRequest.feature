@Get
Feature: Testing GET API

    As a QA,
    I want to validate the API is meet the requirement

    Background:
        Given configure url = "https://jsonplaceholder.typicode.com"
        And path "/posts"
        When method GET

    @HttpStatus
    Scenario: The API response should be HTTP 200 OK
        Then status 200

    @JsonArray
    Scenario: The API response should be a JSON Array
        Then match response == "#array"

    @ElementNotZero
    Scenario: The API response body has at least one element
        * def countData = response.length
        Then assert countData > 1

    @SchemaValidation
    Scenario: The API response body matches the JSON Schema
        * def jsonSchema = read("../helper/GetSchema.json")
        * def expectedSchema = jsonSchema[0]
        Then match response == "#array"
        And assert response.length > 1
        And match each response == expectedSchema

    @VariableTypeValidation
    Scenario Outline: Each element in the response body has <key> field that is <type>
        Then match each response[*].<key> == "#<type>"

        Examples:
            | key    | type    |
            | userId | number  |
            | id     | number  |
            | title  | string  |
            | body   | string  |

    @CheckNonNegativeNumber
    Scenario Outline: The <key> is a non-negative integer for each element in the response body
        Then match each response[*].<key> == "#number? _ >= 0"

        Examples:
            | key    |
            | userId |
            | id     |

    @CheckUniqueValue
    Scenario Outline: The <key> values are unique in the response body
        * def valueList = karate.map(response, function(data) { return data.<key> })
        * def supportFunction = read("../helper/CheckDuplicateValue.js")
        * def hasDuplicateValue = supportFunction(valueList)
        Then assert hasDuplicateValue == false

        Examples:
            | key    |
            | id     |
            # | userId |