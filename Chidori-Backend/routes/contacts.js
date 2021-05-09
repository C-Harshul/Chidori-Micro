const express = require("express");
const firebase = require("firebase-admin");
require("../serviceAccountKey.json");

const router = express.Router();

var searchRef = firebase.database().ref(`Users/Harshul/Contacts`);

router.get("/", async (req, res) => {
  try {
    searchRef.on("value", async (snapshot) => {
      let contacts = snapshot.val();

      contact_list = Object.keys(contacts).map(function (key) {
        return contacts[key];
      });

      res.send(contact_list);
    });
  } catch (e) {}
});

router.post("/addContact", async (req, res) => {
  const contact = req.body;

  try {
    let contactToken = `${contact.name}'s Contact`;

    searchRef
      .update({ [contactToken]: contact })
      .then(() => res.send())
      .catch((e) => {
        console.log(e);
      });
  } catch (e) {
    res.status(500).send(e);
  }
});

router.patch("/:name", async (req, res) => {
  const _name = req.params.name;
  console.log(_name);
  var searchRef2 = firebase
    .database()
    .ref(`Users/Harshul/Contacts/${_name}'s Contact`);
  const updates = Object.keys(req.body);
  const allowed = ["mailid", "phoneNumber"];
  const isValidOperation = updates.every((update) => allowed.includes(update));
  console.log(isValidOperation);
  if (!isValidOperation) {
    res.status(400).send({ error: "Invalid update" });
  }

  console.log(updates);
  try {
    var details;
    searchRef2.once("value", async (snapshot) => {
      details = snapshot.val();

      updates.forEach((update) => {
        details[update] = req.body[update];
      });

      let x = `${_name}'s Contact`;
      console.log(details);
      searchRef
        .update({ [x]: details })
        .then(() => res.send())
        .catch((e) => {
          console.log(e);
          res.status(500).send(e);
        });
    });

    res.send();
  } catch (e) {
    res.status(500).send();
  }
});

module.exports = router;
