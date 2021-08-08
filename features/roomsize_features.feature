Feature: Test Imaginary Robot for Valid and Invalid Input values for roomSize params

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
        |{ "roomSize" : [5, 5], "coords" : [1, 2], "patches" : [ [1, 0], [2, 2], [2, 3] ], "instructions" : "NNESEESWNWW" }     |   [1, 3]  |       1   |
        |{ "roomSize" : [10, 10], "coords" : [3, 4], "patches" : [ [4, 4], [4, 5], [6, 6] ], "instructions" : "NNESEESWNWW" }   |   [3, 5]  |       1   |

    Scenario Outline: Invalid value for param - roomSize in the Request Body and getting Expected output
        When Set invalid request Body <request_body>
        And Send a POST HTTP request
        Then I receive error <response_code>, "<response_error>"

        Examples:
        |   request_body                                                                                        |   response_code   |   response_error      |
        | { "roomSize" : [], "coords" : [0,0], "patches" : [[0,0]], "instructions" : "NEWSNEWS" }               |       500         | Internal Server Error |
        | { "roomSize" : [5], "coords" : [0, 0], "patches" : [[0, 0]], "instructions" : "NEWSNEWS" }            |       500         | Internal Server Error |
        | { "coords" : [0, 0], "patches" : [[0, 0]], "instructions" : "NEWSNEWS" }                              |       500         | Internal Server Error |

    Scenario: Alphabets passed as a coordinates for param - roomSize in the Request Body and getting Expected output
        When Set invalid request Body by passing alphabets for the room size parameters
        And Send a POST HTTP request
        Then I receive error status code 400
        And response error as Bad Request

    Scenario: Special Characters passed as a coordinates for param - roomSize in the Request Body and getting Expected output
        When Set invalid request Body by passing special characters for the room size parameters
        And Send a POST HTTP request
        Then I receive error status code 400
        And response error as Bad Request

    Scenario Outline: Invalid value for param - roomSize in the Request Body and getting Incorrect output
        When Set invalid request Body <request_body>
        And Send a POST HTTP request
        Then I receive error <response_code>, "<response_error>"

        Examples:
        |   request_body                                                                                                                |   response_code   |   response_error      |
        | { "roomSize" : [0,0], "coords" : [1, 1], "patches" : [[2, 2]], "instructions" : "NEWSNEWS" }                                  |       500         | Internal Server Error |
        | { "roomSize" : [5, 5, 5], "coords" : [1, 1], "patches" : [[2, 2]], "instructions" : "NEWSNEWS" }                              |       500         | Internal Server Error |
        | { "roomSize" : [-5, -5], "coords" : [1, 1], "patches" : [[2, 2]], "instructions" : "NEWSNEWS" }                               |       500         | Internal Server Error |
        | { "roomSize" : [0, 5], "coords" : [1, 1], "patches" : [[2, 2]], "instructions" : "NEWSNEWS" }                                 |       500         | Internal Server Error |
        | { "roomSize" : [5, 0], "coords" : [1, 1], "patches" : [[2, 2]], "instructions" : "NEWSNEWS" }                                 |       500         | Internal Server Error |
        | { "roomSize" : [5, 5], "roomSize" : [4, 4], "coords" : [1, 2], "patches" : [[2, 2]], "instructions" : "NNESEESWNWW" }         |       500         | Internal Server Error |

