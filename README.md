# Circleci WDIO Script
This repository contains a Bash script circleci-wdio.sh that facilitates the execution of WebdriverIO (WDIO) tests on CircleCI while addressing an issue with the "Rerun failed tests" feature. The script is designed to handle the file path formatting required by WDIO, ensuring that the "Rerun failed tests" functionality works correctly.

# Background
When using the "Rerun failed tests" feature in CircleCI with the WebdriverIO v8 test framework, the rerun command may not correctly handle file paths. Specifically, WDIO adds the file:// prefix to feature file paths, causing the "Rerun failed tests" functionality to fail as it attempts to find files with the file:// prefix in the test folder.

# Solution
The circleci-wdio.sh script addresses this issue by removing the file:// prefix from the feature file paths before executing the WDIO tests. This ensures that the "Rerun failed tests" feature can correctly locate and rerun the failed tests.

# Usage
1. Copy the circleci-wdio.sh script into your project's directory (e.g., app/e2e).
2. In your CircleCI configuration file, include the following steps:
```
steps:
  - run:
      name: Make script executable
      command: chmod +x ./circleci-wdio.sh
      working_directory: app/e2e
  - run:
      name: Run yarn << parameters.script >> in << parameters.script >>
      environment:
        DEBUG: "true"
        WEB: "true"
        MOCK: "true"
      command: |
        mkdir -p reports
        circleci tests glob "features/**/*.feature" | circleci tests run --command="xargs ./circleci-wdio.sh web " --verbose --split-by=timings
      working_directory: app/e2e
```
3. Replace web in the circleci tests run command with the appropriate platform (web, ios, or android) based on your testing requirements.

# Script Details
The circleci-wdio.sh script performs the following steps:
1. Accepts a platform argument (web, ios, or android) to determine the appropriate WDIO configuration file and Cucumber tag.
2. Iterates over the provided feature file paths.
3. Removes the file:// prefix from each feature file path using sed.
4. Constructs the WDIO command with the appropriate configuration file, Cucumber tag, and feature file paths.
5. Executes the WDIO command using yarn wdio run.
   
By incorporating this script into your CircleCI workflow, you can ensure that the "Rerun failed tests" feature works correctly with your WDIO test framework
