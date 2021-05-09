<h1 align="center"> Chidori  </h1>

<p align="center">
  <img width="200" src="https://github.com/Shakthi-Dhar/Chidori-TaserGlove/blob/main/assets/Icon.png" alt="Icon">
</p>

>__<h3>Why This Project?</h3>
Lot of fatalities occur simply because of delayed medical assistance because the individual affected wasn't in the physical state to notify hospitals or family about their medical emergency.__

<h3>What is Chidori?</h3>
A security glove that uses gestures to initiate tasing and automatically conveys an SOS message through our application. We use ESP8266 wifi module to form a connection with the cloud and a low voltage circuit as a tasing prototype and a MPU6050 accelerometer to act as a gesture sensor that initiates the tasing action and updates the data on the cloud through wifi module. When the data is being updated, we use cloud services to initiate an SOS message.

<p align="center">
  <img width="400" src="https://github.com/Shakthi-Dhar/Chidori-TaserGlove/blob/main/assets/flow%20chart.png" alt="Flow chart">
</p>

<h2>Hardware Tech </h2>
<h4>NodeMCU ESP8266</h4>
This device acts as the interface between the hardware and the backend. It constantly
reads the data from the MPU6050 sensor and once the condition for the gesture is
detected it sends an http Get request along with the message title and coordinates
obtained from a Geolocation API as a query parameter to our backend.

<h4>MPU6050</h4>
This module has an inbuilt gyroscope, accelerometer and temperature which we will be
calibrating to identify the gesture performed by the user.

<h3>This is how our prototype looks like</h3>
<p align="center">
  <img width="500" src="https://github.com/Shakthi-Dhar/Chidori-TaserGlove/blob/main/assets/circuit.png" alt="Hardware">
</p>

<h3>We have used the following Arduino packages and libraries:</h3>

- I2C dev libraries

- ESP8266WiFi 

- ESP8266 http client access

We have made our own api to send a get request for updating the database inorder to send a SOS message through our application: <i>http://security-glove.herokuapp.com/notify</i>

Once the gesture is detected the request is sent to send notification with the appropriate message. The notification is received on the mail and the app as well:
<p align="center">
  <img height="350" src="https://cdn.discordapp.com/attachments/776153841288216607/840636383390859264/Screenshot_2021-05-08-22-38-19-215_com.teslacoilsw.launcher.jpg" alt="Notif"><img height="350" src="https://cdn.discordapp.com/attachments/776153841288216607/840636648966324255/Screenshot_2021-05-08-22-39-14-857_com.google.android.gm.jpg" alt="Mail">
</p>
<h2>Chidori mobile application</h2>
<p align="center">
<img width="200" style="margin-right: 15px;" src="https://cdn.discordapp.com/attachments/776153841288216607/840623387838513152/unknown.png" alt="Flow chart">
<img width="200" src="https://cdn.discordapp.com/attachments/776153841288216607/840621224408514590/unknown.png" alt="Flow chart">
<img width="200" style="margin-left: 15px;"src="https://cdn.discordapp.com/attachments/776153841288216607/840623732657881128/unknown.png" alt="Flow chart">
  </p>
The Chidori mobile appication serves as the primary interface for the user to add contacts to be notified and also customize the body of the message which will be sent via the app and the mail.
<h3>Framework</h3>
Flutter app development  framework is used to make the “Chidori” mobile application. The app will provide the user an intuitive interface to add the contact details to be notified and also to customize the body of the message to be sent when the  gesture gets triggered.

## How to run the application 
* Run `git clone https://github.com/<your-github-username>/<repo-name>.git && cd <repo-name>`on your terminal.
* Run `flutter pub get` in the project terminal and get the dependencies.
* Use `flutter run debug` to run the app in your local emulator or debugging device.


<h2> Dependencies and Packages used </h2>

- SplashScreen package : splashscreen: ^1.3.5 -> Used to show a spashscreen at the time of opening the app
  
- HTTP package         :  http: ^0.12.0+2     -> Used to make http requests to the node API

<h2> The NodeJS backend API </h2>
<p>
We developed our own custom NodeJS API to handle requests from both hardware and app clients. The following is the link to our REST API deployed on heroku -: <i>http://security-glove.herokuapp.com</i></</p>


<h3> Node packages and dependencies </h3>

- express : NPM package used to build web apps and APIs.
- firebase-admin : NPM package to link the backend to firebase for Realtime Database and Cloud Messaging(FCM).
- nodemailer : NPM package to send custom automated mails.
 

<h3> API Endpoints </h3>
{{url}} ----> <i>http://security-glove.herokuapp.com</i>

- POST `{{url}}/contacts/addContact `  -- This  is used to add contacts to the Firebase Realtime Database <br />
- GET `{{url}}/contacts` -- This  is used to get the contacts from the Firebase Realtime Database<br />
- PATCH`{{url}}/contacts/<Contact Name>`  -- This is used to edit the contacts in Firebase Realtime Database <br />
- GET `{{url}}/notify?title=<Message title>&lat=<lat>&long=<longitude>` -- This is used to notify the contacts stored in the database with the appropriate message
- POST `{{url}}/message/addMessage` -- This endpoint is used to add custom messages to the database.
- GET `{{url}}/message` -- This message is used to 
- PATCH `{{url}}/message/edit/<Message title>` -- This end point is used to edit the body of the message


## Contributors

- [Harshul Chandrasekhar](https://github.com/C-Harshul)
- [K Shakhidhar Reddy](https://github.com/Shakthi-Dhar)
