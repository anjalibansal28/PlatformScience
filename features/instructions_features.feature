Feature: Test Imaginary Robot for Valid and Invalid Input values for Instructions params

    Background: Run the Suite Setup
        Given I Set POST request api endpoint
        When I Set HEADER param request content type as "application/json."

    Scenario Outline: Valid value for 'roomSize', 'coords', 'patches' and 'instructions' parameter in the request body
        When Set request Body <request_body>
        And Send a POST HTTP request
        Then I receive valid HTTP response code 200
        And Response BODY with the right data <coords> and <patches>

        Examples:
        |   request_body                                                                                                        |   coords  |   patches |
        |{ "roomSize" : [2, 2], "coords" : [0, 0], "patches" : [[0, 0]], "instructions" : "NNESEESWNWW" }                       |   [0, 1]  |       1   |
        |{ "roomSize" : [5, 5], "coords" : [1, 2], "patches" : [ [1, 0], [2, 2]], "instructions" : "" }                         |   [1, 2]  |       0   |

    Scenario Outline: Invalid value for param - instructions in the Request Body and getting Incorrect output
        When Set invalid request Body <request_body>
        And Send a POST HTTP request
        Then I receive error <response_code>, "<response_error>"

        Examples:
        |   request_body                                                                                                                    |   response_code   |   response_error      |
        | { "roomSize" : [5, 5], "coords" : [1, 2], "patches" : [[2, 3]]}                                                                   |       500         | Internal Server Error |
        | { "roomSize" : [5,5], "coords" : [1, 2], "patches" : [[1, 2]], "instructions" : "ABCD" }                                          |       500         | Internal Server Error |
        | { "roomSize" : [5, 5], "coords" : [1, 2], "patches" : [[2, 3]], "instructions" : "#$@#$@" }                                       |       500         | Internal Server Error |
        | { "roomSize" : [5, 5], "coords" : [1, 2], "patches" : [[2, 3]], "instructions" : 123456 }                                         |       500         | Internal Server Error |
        | { "roomSize" : [5, 5], "coords" : [1, 2], "patches" : [ [1, 0] ], "instructions" : "NNESEESWNWW", "instructions" : "NESW" }       |       500         | Internal Server Error |