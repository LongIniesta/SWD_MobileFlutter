import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerNotification extends StatefulWidget {
  const CustomerNotification({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CustomerNotificationState();
  }
}

class _CustomerNotificationState extends State<CustomerNotification> {
  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          Text('Thông báo',
              style: GoogleFonts.openSans(
                  fontWeight: FontWeight.bold, fontSize: 20))
        ],
      )),
      body: Container(
        margin: EdgeInsets.all(12),
        child: Column(children: [Text(message.toString())]),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // await FirebaseApi().initNotifications();
  }
}
