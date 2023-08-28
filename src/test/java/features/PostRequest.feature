@Post
Feature: Testing POST API

    As a QA,
    I want to validate the API is meet the requirement

    Background:
        * def defaultHeader = 
        """ 
            {
                "Content-Type": "application/json" 
            }
        """
        * def defaultPayload = 
        """
            { 
                userId: 12, 
                title: "recommendation", 
                body: "motorcycle" 
            }
        """
        Given url "https://jsonplaceholder.typicode.com"
        And path "/posts"

    @HttpStatus
    Scenario: Tha API response should be HTTP 201 Created
        Given headers defaultHeader
        And request defaultPayload
        When method POST
        Then status 201

    @SchemaValidation
    Scenario: The API response body matches the JSON Schema
        * def expectedSchema = read("../helper/PostSchema.json")
        Given headers defaultHeader
        And request defaultPayload
        When method POST
        Then match response == expectedSchema

    @VariableBoundaryValidation
    Scenario Outline: The userId value is accept <condition> Integer
        Given headers defaultHeader
        And request <payload>
        When method POST
        Then match response.userId == "#number"

        Examples:
            | condition | payload |
            | positive  | {"title":"recommendation","body":"motorcycle","userId":12} |
            | negative  | {"title":"recommendation","body":"motorcycle","userId":-12} |
            | zero      | {"title":"recommendation","body":"motorcycle","userId":0} |

    @InputValidation
    Scenario Outline: The API response body has a valid key value as inputed payload
        Given headers defaultHeader
        And request <payload>
        When method POST
        * def expectedValue = <payload>
        Then match response.title == "#string? _ == expectedValue.title"
        And match response.body == "#string? _ == expectedValue.body"
        And match response.userId == "#number? _ == expectedValue.userId"

        Examples:
            | payload |
            | {"title":"recommendation","body":"motorcycle","userId":12} |
            | {"title":"new","body":"movie","userId":123} |
            | {"title":"information","body":"hello world","userId":-12} |
            | {"title":"12345","body":"12345","userId":0} |
            | {"title":"!@#$%^&*()_+","body":"!@#$%^&*()_+","userId":0} |
            | {"title":"abc123!@#","body":"abc123!@#","userId":0} |

    @InputValidation
    Scenario Outline: The "<key1>" value accept "<condition1>" String and "<key2>" value accept "<condition2>" String
        Given headers defaultHeader
        And request <payload>
        When method POST
        * def payload = <payload>
        * def supportFunction = read("../helper/CheckEmptyValue.js")
        * def expectedValue = 
        """
        { 
            <key1>:"#(supportFunction(payload.<key1>, '<condition1>'))",
            <key2>:"#(supportFunction(payload.<key2>, '<condition2>'))"
        }
        """
        * def actualValue = 
        """
        { 
            <key1>:"#(supportFunction(response.<key1>, '<condition1>'))",
            <key2>:"#(supportFunction(response.<key2>, '<condition2>'))"
        }
        """
        Then match actualValue == expectedValue

        Examples:
            | key1   | condition1 | key2 | condition2 | payload |
            | title  | non-empty  | body | non-empty  | {"title":"recommendation","body":"motorcycle","userId":12} |
            | title  | empty      | body | non-empty  | {"title":"","body":"motorcycle","userId":12}               |
            | title  | non-empty  | body | empty      | {"title":"recommendation","body":"","userId":12}           |
            | title  | empty      | body | empty      | {"title":"","body":"","userId":12}                         |