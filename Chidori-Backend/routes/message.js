const express = require("express");
const firebase = require("firebase-admin");
require("../serviceAccountKey.json");

const router = express.Router();

var searchRef = firebase.database().ref(`Users/Harshul/Messages`);

router.get("/", async (req, res) => {
    try {searchRef.on("value", async (snapshot) => {
        let messages = snapshot.val();
  
        message_list = Object.keys(messages).map(function (key) {
          return messages[key];
        });
  
        res.send(message_list);
      });
    } catch (e) {}
});

router.post("/addMessage", async (req, res) => {
  const message = req.body;
  console.log(message);
  try {
    let messageToken = message.title;

    searchRef
      .update({ [messageToken]: message })
      .then(() => res.send())
      .catch((e) => {
        console.log(e);
      });
  } catch (e) {
    res.status(500).send(e);
  }
});

router.patch("/edit/:title", async (req, res) => {
  const title = req.params.title;
  const message = {
      "body" : req.body.body,
      "title" : title
  }
  
  console.log({[title] : message})

  try {
    searchRef
      .update({ [title]: message })
      .then(() => res.send())
      .catch((e) => console.log(e));
  } catch (e) {
    res.status(500).send();
  }
});

module.exports = router;
