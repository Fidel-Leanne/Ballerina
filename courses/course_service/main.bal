import ballerina/http;

type Course record {|

    readonly string code;
    string name;
    string department;

|};

type lecturer record {|
    readonly string staffNumber;
    string name;
    string department;

|};

type student record {|

    readonly string studentNumber;
    string studentName;
    string department;
|};

type course_lecturer record {|

    readonly string id;
    string staffNumber;
    string courseCode;

|};

type course_student record {|

    readonly string id;
    string studentNumber;
    string courseCode;

|};

table<Course> key(code) courseTable = table [];
table<student> key(studentNumber) studentTable = table [];
table<lecturer> key(staffNumber) lecturerTable = table [];
table<course_student> key(id) course_studentTable = table [];
table<course_lecturer> key(id) course_lecturerTable = table [];

service / on new http:Listener(3000) {

    resource function post createCourse(Course newcourse) returns string|error {

        error? createCourse = courseTable.add(newcourse);
        if createCourse is error {
            return error("failed to create");
        }
        return newcourse.name + "created";

    }

    resource function post createStudent(student newStudent) returns string|error {

        error? createStudent = studentTable.add(newStudent);
        if createStudent is error {
            return error("failed to create");
        }
        return newStudent.studentName + "created";

    }

    resource function post createLecturer(lecturer newLecturer) returns string|error {

        error? createLecturer = lecturerTable.add(newLecturer);
        if createLecturer is error {
            return error("failed to create");
        }
        return newLecturer.name + "created";

    }

}

