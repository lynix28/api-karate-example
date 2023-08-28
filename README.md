## api-karate-example

API automation test example project using Karate-JUnit5.

---

<b>Tools:</b>

- Karate-JUnit5 as test framework.
- Maven as test builder and runner.
- Allure as test reporter (additional).

---

<b>How to setup:</b>

- Install `Maven`
- Install `Java SE`
- Clone this repository

---

<b>How to run the test:</b>

<!-- - For all tests -->

   - `mvn test` | to run all the test.
   - `mvn test -Dtest=your_package.YourClass#your_method` | to run the test only for the specific test method. \
   *example: `mvn test -Dtest=runner.Runner#testWithTag`

<!-- - For specific feature using tags

   - `` -->

---

<b>Report:</b>

- The file report will be generated and saved to `target` directory

- For Allure Report only an additional report and still not proper to use with Karate. Some important header content like `'Given - When - Then'` are still not generated, so the report will make confusion in current state. But if you still want It, use the following command to generate and open the report.
    - `mvn allure:report allure:serve`