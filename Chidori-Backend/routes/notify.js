const express = require("express");
const router = new express.Router();

const firebase = require("firebase-admin");
require("../serviceAccountKey.json");

const appNotify = require("../notify/appUser");
const mail = require("../notify/mail");



router.get("/", async (req, res) => {

  const message_title = req.query.title;
  console.log(message_title);
  var notify_message;

  var searchRef = firebase.database().ref(`Users/Harshul/Messages/${message_title}`);

  try {
    searchRef.once("value", (snapshot) => {
      const messages = snapshot.val();
      console.log(messages.body)
      notify_message = messages.body;
      var searchRef2 = firebase.database().ref(`Users/Harshul/Contacts`);
      let mailList = [];
      var contact_list = [];

      searchRef2.once("value", async (snapshot) => {
        let contacts = snapshot.val();

        contact_list = Object.keys(contacts).map(function (key) {
          return [contacts[key]];
        });

        contact_list.forEach((contact) => {
          mailList.push(contact[0].mailid);
        });

       const coordinates = {
        "lat": 12.295493,
        "lon": 76.585907,
       }

        await mail(message_title, notify_message,coordinates, mailList, (err, resp) => {
         
          if (err) {
            console.log(err);
            res.status(500).send({ "Notify Status": "mail not sent" });
          } else {
            console.log(resp);
          }
        });

        await appNotify(message_title, notify_message, "Harshul", [
          "f0KPCx3eS1yl681j2Psocp:APA91bH7KdHfok_1Cf_s2oCOaRa0a0lqKymQVhG8ImYDsM8Oys42iek7i1P79qTSZ4v1d3nYyuVu3iSGh5WacuaqhelM10QbmoSITMg-qHLSntprCMovvH--OC5rI21daEuhWE9dFn9K",
        ]);
        res.send({ "Notify Status": "Done" });
      });
    });
  } catch (e) {
    res.status(500).send({ error: e });
  }
});

module.exports = router;
