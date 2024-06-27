# gradle

<br>

## Examples

<br>

### build | build the application

```bash
# Install the dependencies if not already installed
./gradlew build
```

Debug mode

```bash
./gradlew build --debug
```

<br>

### unitTest | run the unit tests

```bash
# Run the tests
./gradlew test
# In a typical development workflow with Gradle, if the source code or tests have not been modified since the last build, Gradle will consider the tasks up-to-date and will not rerun them
# To force Gradle to rerun the tests, you can use the --rerun-tasks option
./gradlew test --rerun-tasks
```

<br>

### bootRun | run the application

```bash
./gradlew bootRun
```
