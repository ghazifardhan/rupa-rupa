import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class PhoneCaller extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Direct Caller',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      debugShowCheckedModeBanner: false,
      home: PhoneCallerWidget(),
    );
  }

}

class PhoneCallerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PhoneCallerState();
}

class _PhoneCallerState extends State<PhoneCallerWidget> {

  _callNumber() async{
    const number = '081388004481'; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Direct Caller"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: _callNumber,
              child: Image.asset(
                "assets/phone-call.png",
                width: 200,
                height: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}