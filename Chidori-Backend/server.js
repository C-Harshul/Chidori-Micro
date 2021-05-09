const express = require("express");

const app = express();
const port = process.env.PORT || 3000;
app.use(express.json());

const notifyRoutes = require("./routes/notify");
const contactRoutes = require("./routes/contacts");
const messageRoutes = require("./routes/message");
app.use("/notify", notifyRoutes);
app.use("/contacts", contactRoutes);
app.use("/message", messageRoutes);

app.listen(port, () => {
  console.log("Server on port :" + port);
});
