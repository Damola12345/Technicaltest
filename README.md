# DevOPs Test

This is the technical test. Please do this on a public git repo of your choice and share once done.

## Step 1: API

This section is to verify your competency in writing code.

You will find a [swagger spec](./swagger.yaml) defining an API that you must create. It is a simple user system with a single endpoint. Please use the specification and write an API in the language of your choosing. Keep in mind that you will need to store the user information.

## Step 2: Local Setup

This step is to verify your competency in development workflow.

Create a local environment that can be used to verify the code. Please keep in mind that a large number of projects are done with various setups (Unix- and Windows-based), so on any local setup please take into consideration this limitation (i.e. make sure it works across platforms). There is a [CSV](./data.csv) containing data that should be able to be loaded in order to test your setup; please think of a creative way to make loading the data easier.

## Step 3: Containerization and Deployment

This step is to test your understanding of containerization, automation and deployment (using AWS).

Please containerize your application and create the required github action to deploy your application to a AWS ECS cluster. Please use best practices when setting this up (treat it as if it were going into production). Part of the process should include the automation of loading the data into the storage that you have chosen.

_NB:_ so while we believe in innovation, this should not be at the cost of compromising on security.

## SOLUTION 

Technologies
* Node & express js
* Docker
* ECS (Fargate)
* CI/CD - Github Actions
* ECR
* Terraform

# Run App locally
* In the project directory, you can run:
    - `yarn install`
    - `yarn start`

Runs the app in the development mode.<br />
Open [http://localhost:2500/users](http://localhost:2500/users) to view it in the browser.

# Containerize The App
* Write a Dockerfile that will properly turn my app into a container

* Run APP with this command 
    - `docker build -t devoptest . `
    - `docker run -d -p 2500:2500 devoptest`

* Validate the task 
    - `http://localhost:2500/users`
    -  `curl -X POST -H "Content-Type: application/json" -d '{"id": "6", "name": "Damola Ajibola"}' http://localhost:2500/users`


