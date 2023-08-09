import ballerina/io;
import ballerina/random;

public function main() {
    // Randomly select a number between 10 and 60
    int|random:Error x = random:createIntInRange(10, 60);

    if x is int {

        io:println("The factors of ", x, " are: ");

        int n = 1;
        while (n <= x) {
            if (x % n == 0) {
                io:println(n); // Printing the factor

            }
            n += 1;
        }
    } else {
        io:println("Error generating random number:", x.message());
    }
}
