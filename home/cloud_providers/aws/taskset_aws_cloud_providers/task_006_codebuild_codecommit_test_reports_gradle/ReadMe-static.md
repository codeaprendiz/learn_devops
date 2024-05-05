# Building an Application with Spring Boot with Gradle Groovy, Unit Tests, and Reports

- [Building an Application with Spring Boot with Gradle Groovy, Unit Tests, and Reports](#building-an-application-with-spring-boot-with-gradle-groovy-unit-tests-and-reports)
  - [Run the application](#run-the-application)
  - [Run Unit Tests](#run-unit-tests)
  - [Show reports directory](#show-reports-directory)

For more info about the project check in folder `learn_java/task_006` in repo `learn_fullstack`.

> If you are getting import package errors then you can try opening only specific task in VS Code by running `code .` in the terminal. Every task is a separate project and has its own dependencies.

```bash
$ java --version
openjdk 21.0.2 2024-01-16
OpenJDK Runtime Environment Homebrew (build 21.0.2)
OpenJDK 64-Bit Server VM Homebrew (build 21.0.2, mixed mode, sharing)
```

## Run the application

```bash
# Install the dependencies using gradle kotlin
./gradlew build
# Run the application
./gradlew bootRun
```

Output

```bash
...
welcomePageNotAcceptableHandlerMapping
<==========---> 80% EXECUTING [6m 2s]
> :bootRun
```

Validate the application is running

```bash
curl http://localhost:8080
```

Output

```bash
Greetings from Spring Boot!
```

## Run Unit Tests

Run the tests

```bash
# Run the tests
./gradlew test
# In a typical development workflow with Gradle, if the source code or tests have not been modified since the last build, Gradle will consider the tasks up-to-date and will not rerun them
# To force Gradle to rerun the tests, you can use the --rerun-tasks option
./gradlew test --rerun-tasks
```

Output

```bash
BUILD SUCCESSFUL in 567ms
4 actionable tasks: 4 up-to-date
```

## Show reports directory

```bash
./gradlew showDirs
```

```bash
$ ./gradlew showDirs


> Task :showDirs
Reports directory: .../learn_java/taskset/task_006_building_an_application_with_spring_boot__gradle_groovy__unit_tests__reports/build/reports
Test results directory: .../learn_java/taskset/task_006_building_an_application_with_spring_boot__gradle_groovy__unit_tests__reports/build/test-results

BUILD SUCCESSFUL in 522ms
1 actionable task: 1 executed
```
