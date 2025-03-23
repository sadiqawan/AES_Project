import 'package:flutter/material.dart';

class UpdatesView extends StatelessWidget {
  const UpdatesView({super.key});

  @override
  Widget build(BuildContext context) {
    return _screen(context);
  }
}
Widget _screen(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text('Updates'),
    ),
    body: Center(
      child: Text('Coming Soon..'),
    ),
  );
}