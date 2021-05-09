var firebase = require("firebase-admin");

var serviceAccount = require("../serviceAccountKey.json");

firebase.initializeApp({
  credential: firebase.credential.cert(serviceAccount),
  databaseURL: "https://security-9a9a0.firebaseio.com",
});

const notifyAppUser = async (title, message, person, tokens) => {
  if (tokens.length !== 0) {
    let payload = {
      notification: {
        title: title,
        body: person + " : " + message,
      },
      data: {
        click_action: "FLUTTER_NOTIFICATION_CLICK",
        message: "Sample Push Message",
      },
    };
    var options = {
      priority: "high",
    };

    let i = 4;
    while (i > 0) {
      firebase
        .messaging()
        .sendToDevice(tokens, payload, options)
        .then((response) => {
          console.log("Message sent successfully");
        })
        .catch((error) => {
          console.log(error);
        });
      i--;
    }
  } else console.log("No app user contacts");
};

module.exports = notifyAppUser;
