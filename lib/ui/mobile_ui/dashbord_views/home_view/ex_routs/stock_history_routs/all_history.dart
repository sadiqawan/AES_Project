import 'package:flutter/material.dart';

class AllHistoryView extends StatefulWidget {
  const AllHistoryView({super.key});

  @override
  State<AllHistoryView> createState() => _AllHistoryViewState();
}

class _AllHistoryViewState extends State<AllHistoryView> {
  @override
  Widget build(BuildContext context) {
    return _screen(context);
  }
}

Widget _screen(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: Text('All History'),
    ),
  );
}
