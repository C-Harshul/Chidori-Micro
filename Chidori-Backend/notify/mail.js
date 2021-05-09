const nodemailer = require("nodemailer");

var transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "testharshul@gmail.com",
    pass: "Abc@12345",
  },
});

const mail = (subject, message,coordinates, mailIds, callback) => {
  const message_body = message + `\nhttps://www.google.com/maps?q=${coordinates.lat},${coordinates.lon}`  
  if (mailIds.length !== 0) {
    var mailOptions = {
      from: "testharshul@gmail.com",
      to: mailIds,
      subject: subject,
      text: message_body,
    };

    transporter.sendMail(mailOptions, function (error, info) {
      if (error) {
        console.log(error);
        callback(error, undefined);
      } else {
        callback(undefined, "Email sent: " + info.response);
      }
    });
  } else {

    callback("No contacts added", undefined);
  }
};

module.exports = mail;
