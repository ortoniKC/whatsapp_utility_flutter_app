import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "WhatsApp Utility",
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WhatsApp utility'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  hintText: "9876543210",
                  labelText: "Enter phone number"),
            ),
            ElevatedButton(
              onPressed: () => {sendMessage(context)},
              child: Icon(Icons.send),
            )
          ],
        ),
      ),
    );
  }

  final snackbar = SnackBar(
    content: Text("Enter valid mobile number"),
    backgroundColor: Colors.red,
  );

  void sendMessage(context) {
    var txt = _controller.text;
    if (txt.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      _launchURL(txt);
    }
  }

  var _url = "https://api.whatsapp.com/send?phone=91";
  void _launchURL(txt) async => await canLaunch(_url + txt)
      ? await launch(_url + txt)
      : throw 'Could not launch $_url';
}
