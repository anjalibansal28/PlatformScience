Feature: Test Imaginary Robot for Valid and Invalid Input values for Patches params

    Background: Run the Suite Setup
        Given I Set POST request api endpoint
        When I Set HEADER param request content type as "application/json."

    Scenario Outline: Valid value for 'roomSize', 'coords', 'patches' and 'instructions' parameter in the request body but getting incorrect output for patches
        When Set request Body <request_body>
        And Send a POST HTTP request
        Then I receive valid HTTP response code 200
        And Response BODY with the right data <coords> and <patches>

        Examples:
        |   request_body                                                                                            |   coords  |   patches |
        | { "roomSize" : [3, 3], "coords" : [0,0], "patches" : [[1,1]], "instructions" : "NESW" }                   |   [0, 0]  |       1   |
        | { "roomSize" : [3, 3], "coords" : [0,0], "patches" : [[0,0]], "instructions" : "NEWSNEWS" }               |   [0, 0]  |       1   |
        | { "roomSize" : [5, 5], "coords" : [1, 1], "patches" : [[2, 2]], "instructions" : "NESW" }                 |   [1, 1]  |       1   |
        | { "roomSize" : [5, 5], "coords" : [1, 2], "patches" : [ ], "instructions" : "NNESEESWNWW" }               |   [1, 3]  |       0   |

    Scenario Outline: Invalid value for param - Patches in the Request Body and getting Incorrect output
        When Set invalid request Body <request_body>
        And Send a POST HTTP request
        Then I receive error <response_code>, "<response_error>"

        Examples:
        |   request_body                                                                                                                        |   response_code   |   response_error      |
        | { "roomSize" : [5, 5], "coords" : [1, 2], "patches" : [[]], "instructions" : "NNESEESWNWW" }                                          |       500         | Internal Server Error |
        | { "roomSize" : [5,5], "coords" : [1, 2], "patches" : [[7, 7]], "instructions" : "NEWSNEWS" }                                          |       500         | Internal Server Error |
        | { "roomSize" : [5,5], "coords" : [1, 2], "patches" : [[2]], "instructions" : "NEWSNEWS" }                                             |       500         | Internal Server Error |
        | { "roomSize" : [5, 5], "coords" : [1, 2], "instructions" : "NNESEESWNWW" }                                                            |       500         | Internal Server Error |
        | { "roomSize" : [5, 5], "coords" : [1, 2], "patches" : [[-2, -2]], "instructions" : "NNESEESWNWW" }                                    |       500         | Internal Server Error |
        | { "roomSize" : [5, 5], "coords" : [1, 2], "patches" : [ [2, 2] ], "patches" : [ [1, 2] ], "instructions" : "NNESEESWNWW" }            |       500         | Internal Server Error |

    Scenario: Alphabets passed as a coordinates for param - patches in the Request Body and getting Expected output
        When Set invalid request Body by passing alphabets for the coords parameters
        And Send a POST HTTP request
        Then I receive error status code 400
        And response error as Bad Request

    Scenario: Special Characters passed as a coordinates for param - patches in the Request Body and getting Expected output
        When Set invalid request Body by passing special characters for the coords parameters
        And Send a POST HTTP request
        Then I receive error status code 400
        And response error as Bad Request

    Scenario Outline: One of the coordinate value is '0' for param - patches in the Request Body
        When Set request Body <request_body>
        And Send a POST HTTP request
        Then I receive valid HTTP response code 200
        And Response BODY with the right data <coords> and <patches>

        Examples:
        |   request_body                                                                                                        |   coords      |   patches     |
        | { "roomSize" : [5,5], "coords" : [1, 2], "patches" : [[0, 2]], "instructions" : "NEWSNEWS" }                          |   [1, 2]      |       0       |
        | { "roomSize" : [5,5], "coords" : [1, 2], "patches" : [[1, 0]], "instructions" : "NEWSNEWS" }                          |   [1, 2]      |       0       |