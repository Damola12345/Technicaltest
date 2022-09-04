const http = require("http");
const path = require("path");
const fs = require("fs");
const express = require("express");
const csv = require("csvtojson");

const app = express();
app.use(express.json());

const csvPath = path.resolve("./data.csv");

// this is to get the list of users in the csv
// GET /users
app.get("/users", async (req, res) => {
  const users = await csv().fromFile(csvPath);
  return res.json(users);
});

// this is to create a new user (add a new user to the csv file)
// POST /users
// it expects a json request body like
// { "id": "6", "name": "Adedamola" }
app.post("/users", async (req, res) => {
  const { id, name } = req.body;
  fs.appendFileSync(csvPath, `${id}, ${name}\r\n`);
  return res.send("User created successfully");
});

// this is to get a particular user with the user ID
// GET /users/2
app.get("/users/:id", async (req, res) => {
  const users = await csv().fromFile(csvPath);
  const user = users.find(user => user.id == req.params.id);
  if (!user) {
    return res.status(404).send("User not found");
  }

  return res.json(user);
});

const server = http.createServer(app);
server.listen(2500, () => {
  console.log("server started on http://localhost:2500");
});
