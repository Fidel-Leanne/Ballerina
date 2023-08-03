import ballerina/io;

// The `main` function can accept command-line arguments and return `error` or `nil`.
public function main() returns error? {

    int a = 8;
    io:println(a);

    if a >= 3 {
        return error("Input should less than 3");
    }

}
