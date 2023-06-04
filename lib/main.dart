// import 'package:english_words/english_words.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:telephony/telephony.dart';

// Telephony telephony = Telephony.instance;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => MyAppState(),
//       child: MaterialApp(
//         title: 'SMS Reader',
//         theme: ThemeData(
//           useMaterial3: true,
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
//         ),
//         home: MyHomePage(),
//       ),
//     );
//   }
// }

// class MyAppState extends ChangeNotifier {
//   var current = WordPair.random();
// }

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var appState = context.watch<MyAppState>();
//     return Scaffold(
//       body: Column(
//         children: [
//           Text('A random idea:'),
//           Text(appState.current.asLowerCase),
//           ElevatedButton(
//             onPressed: () {
//               telephony.listenIncomingSms(
//                 onNewMessage: (SmsMessage message) {
//                   print(message.address); //+977981******67, sender nubmer
//                   print(message.body); //sms text
//                   print(message.date); //1659690242000, timestamp
//                 },
//                 listenInBackground: false,
//               );
//             },
//             child: Text('Next random idea'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String sms = "";
  String sms_address = "";
  Telephony telephony = Telephony.instance;

  @override
  void initState() {
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        print(message.address); //+977981******67, sender nubmer
        print(message.body); //sms text
        print(message.date); //1659690242000, timestamp
        setState(() {
          sms = message.body.toString();
          sms_address = message.address.toString();
        });
        print(sms);
      },
      listenInBackground: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Listen Incoming SMS in Flutter"),
            backgroundColor: Colors.redAccent),
        body: Container(
            padding: EdgeInsets.only(top: 50, left: 20, right: 20),
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recieved SMS Text:" + sms_address,
                  style: TextStyle(fontSize: 30),
                ),
                Divider(),
                Text(
                  "SMS Text:" + sms,
                  style: TextStyle(fontSize: 20),
                )
              ],
            )));
  }
}
