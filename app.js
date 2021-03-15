
const path = require("path");
const bodyParser = require("body-parser");
const express = require("express");
const ejs = require("ejs");
const mysql = require("mysql");


let app = express()
app.use(express.json());
app.use(express.static("Views"));
app.set("view engine","ejs");
app.set("views",path.join(__dirname,"Views/Ejs"));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended:false}));



app.get("/",(req,res)=>{
  res.render("index.ejs");
});

app.get("/quiz",(req,res)=>{
  var connection = mysql.createConnection({
    host: "localhost",
    user: "admin",
    password: "password",
    database: "Coderstrust"
  });
  connection.connect((error)=>{
    if(error) throw error;
    console.log("Connected to database.");
    connection.query("SELECT * FROM Question",(error,result)=>{
      res.render("quiz.ejs",{questions:result});
    });
  });
});


app.post("/submit",(req,res)=>{
  console.log(req.body);

  var connection = mysql.createConnection({
    host: "localhost",
    user: "admin",
    password: "password",
    database: "Coderstrust"
  });

  connection.connect((error)=>{
    if(error) throw error;
    console.log("Connected to database.");

    let customer_id = req.body.customer_id;
    delete req.body.customer_id;

    let values = [];
    for(var i=0;i<Object.keys(req.body).length;i++){
      let temp = [parseInt(customer_id),parseInt(Object.keys(req.body)[i]),parseInt(req.body[Object.keys(req.body)[i]])];
      console.log(temp);
      values.push(temp);
    }
    console.log(values);
    let sql = "INSERT INTO Quiz(customer_id,question_id,score) VALUES ?";

    connection.query(sql,[values],(error,result)=>{
      if(error) throw error;
      res.send("Database insertion OK");
    });
  });
});



app.listen(80,()=>{
  console.log("Listening on port 80 ...");
});
