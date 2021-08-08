from behave import given, when, then
import urllib3, json, certifi, logging
import features.steps.credentials as credentials

@given('I Set POST request api endpoint')
def set_endpoint(context):
    context.request_endpoint = credentials.request_endpoint

@when('I Set HEADER param request content type as "application/json."')
def set_headers(context):
    context.request_headers = {'Content-Type': 'application/json'}

@when('Set request Body {request_body}')
def set_request_body(context, request_body):
    context.request_body = json.loads(request_body)
    print(context.request_body)

@when('Set invalid request Body by passing alphabets for the room size parameters')
def set_alphabets_request_body_roomsize(context):
    context.request_body = {"roomSize": ['a', 'b'], "coords": [1, 2], "patches": [[1, 0], [2, 2], [2, 3]], "instructions": "NNESEESWNWW"}

@when('Set invalid request Body by passing special characters for the room size parameters')
def set_special_characters_request_body_roomsize(context):
    context.request_body = {"roomSize": ['#', '%'], "coords": [1, 2], "patches": [[1, 0], [2, 2], [2, 3]], "instructions": "NNESEESWNWW"}

@when('Set invalid request Body by passing alphabets for the coords parameters')
def set_alphabets_request_body_coords(context):
    context.request_body = { "roomSize" : [5, 5], "coords" : ['a', 'b'], "patches" : [[1, 0], [2, 2], [2, 3]], "instructions" : "NESW" }

@when('Set invalid request Body by passing special characters for the coords parameters')
def set_special_characters_request_body_coords(context):
    context.request_body = { "roomSize" : [5, 5], "coords" : ['$', '#'], "patches" : [[1, 0], [2, 2], [2, 3]], "instructions" : "NESW" }

@when('Set invalid request Body by passing alphabets for the patches parameters')
def set_alphabets_request_body_patches(context):
    context.request_body = { "roomSize" : [5,5], "coords" : [1, 2], "patches" : [ ['a', 'b'] ], "instructions" : "NEWSNEWS" }

@when('Set invalid request Body by passing special characters for the patches parameters')
def set_special_characters_request_body_patches(context):
    context.request_body = { "roomSize" : [5,5], "coords" : [1 , 2], "patches" : [ ['#', '%'] ], "instructions" : "NEWSNEWS" }

@when('Set invalid request Body {request_body}')
def set_invalid_request_body(context, request_body):
    context.request_body = json.loads(request_body)
    print(context.request_body)

@when(u'Send a POST HTTP request')
def send_post_request(context):
    encoded_data = json.dumps(context.request_body).encode('utf-8')
    http = urllib3.PoolManager(ca_certs=certifi.where())
    context.response = http.request("POST", context.request_endpoint, body=encoded_data, headers=context.request_headers)

@then('I receive valid HTTP response code 200')
def verify_status_code(context):
    context.data = json.loads(context.response.data.decode('utf-8'))
    assert context.response.status == 200

@then('Response BODY with the right data {coords} and {patches:d}')
def verify_response_body(context, coords, patches):
    try:
        assert context.data['coords'] == json.loads(coords)
        assert context.data['patches'] == patches
    except Exception as e:
        e = 'Actual Output is: ' + str(context.data)
        raise AssertionError("failed with exception: " + str(e))

@then('I receive error {response_code:d}, "{response_error}"')
def verify_response_code_error(context, response_code, response_error):
    try:
        context.data = json.loads(context.response.data.decode('utf-8'))
        assert context.response.status == response_code
        assert context.data['error'] == response_error
    except Exception as e:
        if 'Expecting value: line 1 column 1' in str(e):
            e = 'Got Blank Response as the Output'
        else:
            e = 'Actual Output is: '+ str(context.data)
        raise AssertionError("failed with exception: " + str(e))

@then('I receive error status code 400')
def verify_response_code_400(context):
    context.data = json.loads(context.response.data.decode('utf-8'))
    assert context.response.status == 400

@then('response error as Bad Request')
def verify_response_message_error(context):
    context.data = json.loads(context.response.data.decode('utf-8'))
    assert context.data['error'] == 'Bad Request'