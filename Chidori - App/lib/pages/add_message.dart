import 'package:flutter/material.dart';
import '../models/gesture_message.dart';
import 'package:http/http.dart';
import 'dart:convert';

final String apiURL = "https://security-glove.herokuapp.com/message";

class GestureMessages extends StatefulWidget {
  static String routename = '/gesture_message';
  @override
  _GestureMessagesState createState() => _GestureMessagesState();
}

List<GestureMessage> Messages = [
  GestureMessage(body: "--", title: "Message 1"),
  GestureMessage(body: "--", title: "Message 2")
];

class _GestureMessagesState extends State<GestureMessages> {
  _getGestureMessages() async {
    Response messages = await get(apiURL);
    print(jsonDecode(messages.body));

    List messageList = jsonDecode(messages.body);
    List<GestureMessage> tempMessages = [];
    for (int i = 0; i < messageList.length; ++i) {
      var t = GestureMessage(
          title: messageList[i]['title'], body: messageList[i]['body']);
      tempMessages.add(t);
    }

    setState(() {
      Messages = tempMessages;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getGestureMessages();
    });
  }

  final body = TextEditingController();

  makeAlertDialog(BuildContext context, title, number) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Message $number'),
          backgroundColor: Color(0xFF04FFB4),
          content: Container(
            width: 400,
            height: 200,
            child: Column(
              children: [
                TextField(
                    controller: body,
                    style: TextStyle(fontSize: 30, color: Colors.black)),
              ],
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              color: Colors.black,
              child: Text('Save',style:TextStyle(color: Color(0xFF04FFB4))),
              onPressed: () async {
                print('$apiURL/edit/$title');
                patch(
                  '$apiURL/edit/$title',
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, String>{"body": body.text}),
                );
                print(Messages[number].body);
                setState(() {
                  Messages[number].body = body.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("lib/img/Icon.png"),
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.14), BlendMode.dstATop),
          )),
        child: SafeArea(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 35),
              child: Text('Gesture Messages', style: TextStyle(fontSize: 30,color: Color(0xFF04FFB4))),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Image(image: AssetImage("lib/img/Mask Group.png")),
                    ),
                    Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 2),
                            child: Text(Messages[0].title,
                                style: TextStyle(fontSize: 20,color: Color(0xFF04FFB4))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              Messages[0].body,
                              style: TextStyle(fontSize: 15,color: Color(0xFF04FFB4)),
                            ),
                          )
                        ],
                      )
                    ]),
                    IconButton(
                        icon: Icon(Icons.edit,color: Color(0xFF04FFB4)),
                        onPressed: () {
                          makeAlertDialog(context, Messages[0].title, 0);
                        })
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Image(
                                image: AssetImage("lib/img/Mask Group2.png")),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 2),
                          child: Messages == []
                              ? CircularProgressIndicator()
                              : Text(Messages[1].title,
                                  style: TextStyle(fontSize: 20,color: Color(0xFF04FFB4))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Messages == []
                              ? CircularProgressIndicator()
                              : Text(
                                  Messages[1].body,
                                  style: TextStyle(fontSize: 15,color: Color(0xFF04FFB4)),
                                ),
                        )
                      ],
                    ),
                    IconButton(
                        icon: Icon(Icons.edit,color: Color(0xFF04FFB4)),
                        onPressed: () {
                          makeAlertDialog(context, Messages[1].title, 1);
                        })
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
