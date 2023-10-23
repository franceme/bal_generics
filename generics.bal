# A value of `anydata` type or a function pointer.
public type Value anydata;

# A function, which returns The `Value` type, just to keep it internal.
public type Valuer isolated function () returns Value;

public type KeyValues record {|
    Value...;
|};

public isolated function fromMap(map<any> input) returns KeyValues {
    KeyValues output = {};
    foreach [string, any] [key, value] in input.entries() {
        output[key] = <Value>value;
    }
    return output;
}

public isolated function toMap(KeyValues input) returns map<any> {
    map<any> output = {};
    foreach [string, any] [key, value] in input.entries() {
        output[key] = value;
    }
    return output;
}

public isolated function toJson(KeyValues input) returns map<json> {
    map<json> output = {};
    foreach [string, any] [key, value] in input.entries() {
        output[key] = value.toString().toJson();
    }
    return output;
}

public isolated function fromJson(json rawinput) returns KeyValues {
    KeyValues output = {};
    map<json> input = {};
    if rawinput !is map<json> {
        return {};
    } else {
        input = rawinput;
    }
    //https://stackoverflow.com/questions/76983957/how-to-iterate-json-array-in-ballerina

    foreach [string, any] [key, value] in input.entries() {
        output[key] = value;
    }
    return output;
}