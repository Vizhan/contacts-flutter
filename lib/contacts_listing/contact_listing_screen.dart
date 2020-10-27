import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: display('Contacts'),
      body: SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }

  AppBar display(String title) => AppBar(title: Text(title));
}
