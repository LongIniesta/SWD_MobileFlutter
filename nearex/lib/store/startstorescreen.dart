import 'package:flutter/material.dart';

class StartStoreScreen extends StatefulWidget{
  const StartStoreScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return StartStoreScreenState();
  }

}

class StartStoreScreenState extends State<StartStoreScreen>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('StartStoreScreen'),
      ),
    );
  }

}