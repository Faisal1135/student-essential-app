import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification extends StatefulWidget {
  final String notifyPayload;
  LocalNotification({Key key, this.notifyPayload}) : super(key: key);

  @override
  _LocalNotificationState createState() => _LocalNotificationState();
}

class _LocalNotificationState extends State<LocalNotification> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  @override
  void initState() {
    super.initState();
    initializing();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _showNotifications();
  }

  void initializing() async {
    androidInitializationSettings = AndroidInitializationSettings('app_icon');
    iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void _showNotifications() async {
    await showNotificationDaily();
  }

  // Future<void> notification() async {
  //   AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //           'Channel ID', 'Channel title', 'channel body',
  //           priority: Priority.High,
  //           importance: Importance.Max,
  //           ticker: 'test');

  //   IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

  //   NotificationDetails notificationDetails =
  //       NotificationDetails(androidNotificationDetails, iosNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       0, 'Hello there ', widget.notifyPayload, notificationDetails);
  // }

  Future<void> showNotificationDaily() async {
    var time = Time(12, 14, 30);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0, 'Tommorrow -', widget.notifyPayload, time, platformChannelSpecifics);
  }

  Future onSelectNotification(String payLoad) async {
    if (payLoad != null) {
      print(payLoad);
    }
    // Navigator.pushNamed(context, ResultofUserScreen.routeName);

    // we can set navigator to navigate another screen
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              print("Notification Recive");
            },
            child: Text("Okay")),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
// Container(
//       child: FlatButton(
//         color: Colors.blue,
//         onPressed: () => notification(),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             "Show Notification",
//             style: TextStyle(fontSize: 20.0, color: Colors.white),
//           ),
//         ),
//       ),
//     );
