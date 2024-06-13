// import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// class FirebaseApi extends StatefulWidget {
//   const FirebaseApi({super.key});

//   @override
//   State<FirebaseApi> createState() => _FirebaseApiState();
// }

// class _FirebaseApiState extends State<FirebaseApi> {
  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Firebase Messaging'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Subscribed to topic: $_subscribed'),
//             ElevatedButton(
//               onPressed: _subscribed ? _unsubscribeFromTopic : _subscribeToTopic,
//               child: Text(_subscribed ? 'Unsubscribe from Topic' : 'Subscribe to Topic'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
