import 'package:flutter/material.dart';

class ContactCardWidget extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String mailid;
  ContactCardWidget(
      {@required this.mailid, @required this.name, @required this.phoneNumber});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 17, right: 17),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF04FFB4)),
            borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                          child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(name,
                    style: TextStyle(color: Colors.grey, fontSize: 15)),
              ),
            ),
            Expanded(
                          child: Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                child: Text(phoneNumber,
                    style: TextStyle(color: Colors.grey, fontSize: 15)),
              ),
            ),
            Expanded(
                          child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(mailid,
                    style: TextStyle(color: Colors.grey, fontSize: 15)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
