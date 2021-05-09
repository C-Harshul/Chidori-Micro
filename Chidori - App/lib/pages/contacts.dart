import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../models/contact_card.dart';
import '../widgets/contact_card.dart';

List<ContactCard> Contacts = [];

final String apiURL = "https://security-glove.herokuapp.com/contacts";

class Landing extends StatefulWidget {
  static String routename = '/landing';
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getContacts();
    });
  }

  _getContacts() async {
    Response contacts = await get(apiURL);
    print(jsonDecode(contacts.body));

    List<ContactCard> tempContacts = [];

    List contactList = jsonDecode(contacts.body);
    for (int i = 0; i < contactList.length; ++i) {
      var t = ContactCard(
          name: contactList[i]['name'],
          mailid: contactList[i]['mailid'],
          phoneNumber: contactList[i]['phoneNumber']);
      tempContacts.add(t);
    }
    print(Contacts);
    print(Contacts.length);
    
    print(tempContacts);
     if(Contacts.length == 0){
        setState(() {
      Contacts = tempContacts;
    });
     }
  }

  final name = TextEditingController();

  final phoneNumber = TextEditingController();

  final mailid = TextEditingController();

  makeAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('ADD CONTACT'),
          backgroundColor: Color(0xFF04FFB4),
          content: Container(
            width: 400,
            height: 200,
            child: Column(
              children: [
                TextField(
                    controller: name,
                    style: TextStyle(
                      fontSize: 30,
                    )),
                TextField(
                    controller: phoneNumber,
                    style: TextStyle(
                      fontSize: 30,
                    )),
                TextField(
                    controller: mailid,
                    style: TextStyle(
                      fontSize: 30,
                    )),
              ],
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text('ADD'),
              onPressed: () async {
                post(
                  '$apiURL/addContact',
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, String>{
                    "name": name.text,
                    "phoneNumber": phoneNumber.text,
                    "mailid": mailid.text,
                  }),
                );
                setState(() {
                  Contacts.add(ContactCard(name: name.text,phoneNumber: phoneNumber.text,mailid: mailid.text,));
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 25),
                    child: Container(
                      child: Text(
                        'Profile',
                        style:
                            TextStyle(fontSize: 27, color: Color(0xFF04FFB4)),
                      ),
                    ),
                  ),
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 35, top: 40),
                        child: Container(
                          child: Icon(
                            Icons.account_circle,
                            color: Color(0xFF04FFB4),
                            size: 35,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 40, left: 35, right: 35),
                        child: Text(
                          'Harshul Chandrasekhar',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontFamily: 'Anton'),
                        ),
                      )
                    ],
                  )),
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 35, right: 35, top: 20),
                        child: Container(
                          child: Icon(
                            Icons.location_on_outlined,
                            color: Color(0xFF04FFB4),
                            size: 35,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, top: 20),
                        child: Text(
                          'Mysuru, Karnataka',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontFamily: 'Anton'),
                        ),
                      )
                    ],
                  )),
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 35, right: 35, top: 20),
                        child: Container(
                          child: Icon(
                            Icons.phone,
                            color: Color(0xFF04FFB4),
                            size: 35,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, top: 20),
                        child: Text(
                          '9113531625',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontFamily: 'Anton'),
                        ),
                      )
                    ],
                  )),
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 35, right: 35, top: 20),
                        child: Container(
                          child: Icon(
                            Icons.calendar_today_rounded,
                            color: Color(0xFF04FFB4),
                            size: 35,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, top: 20),
                        child: Text(
                          '31/05/2001',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontFamily: 'Anton'),
                        ),
                      )
                    ],
                  )),
                  Padding(
                    padding: const EdgeInsets.only(top: 60, left: 25),
                    child: Text('SOS Contacts',
                        style:
                            TextStyle(color: Color(0xFF04FFB4), fontSize: 27)),
                  ),
                  Container(
                    width: 400,
                    height: 350,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: Contacts.length,
                              itemBuilder: (ctx, index) {
                                return ContactCardWidget(
                                    name: Contacts[index].name,
                                    phoneNumber: Contacts[index].phoneNumber,
                                    mailid: Contacts[index].mailid);
                              }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FlatButton(
                                color: Color(0xFF04FFB4),
                                onPressed: () async {
                                  await makeAlertDialog(context);

                                  print(Contacts);
                                },
                                child: Text('Add Contacts',
                                    style: TextStyle(
                                      fontFamily: 'Marker',
                                      fontSize: 17,
                                      color: Color(0xFF1D1E33),
                                    )),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}