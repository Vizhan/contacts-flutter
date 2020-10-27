import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  final String name;
  final String asset;

  ContactItem({
    @required this.name,
    @required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.indigo,
        ),
        const SizedBox(width: 8),
        Text(name),
      ],
    );
  }
}
