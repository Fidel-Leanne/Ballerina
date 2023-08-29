import ballerina/time;
import ballerina/http;

type User record {|
    readonly int id;
    string name;
    time:Date DOB;
    string phoneNumber;
|};

table<User> key(id) users = table [
    {id: 1, name: "jon", phoneNumber: "322424", DOB: {year: 0, month: 0, day: 0}},
    {id: 2, name: "mary", phoneNumber: "23242224", DOB: {year: 0, month: 0, day: 0}}
];

type ErrorDetails record {

    string message;
    string details;
    time:Utc timeStamp;
};

type UserNotFound record {|
    *http:NotFound;
    ErrorDetails body;
|};

type NewUser record {|

    string name;
    time:Date DOB;
    string phoneNumber;
|};

service /social\-media on new http:Listener(9090) {
    resource function get users() returns User[]|error {

        return users.toArray();
    }

    resource function get users/[int id]() returns UserNotFound|User {

        User? user = users[id];
        if user is () {
            UserNotFound userNotFound = {
                body: {message: string `id: ${id}`, details: string `user/${id}`, timeStamp: time:utcNow()}
            };

            return userNotFound;
        }
        return user;
    }

    resource function post users(NewUser newUser) returns http:Created|error {

        users.add({id: users.length() + 1, ...newUser});
        return http:CREATED;

    }

}
