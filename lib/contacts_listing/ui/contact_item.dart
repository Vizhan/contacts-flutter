import 'dart:typed_data';

import 'package:contacts/contacts_listing/ui/contact_avatar.dart';
import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  final String name;
  final Uint8List imageBytes;

  ContactItem({
    @required this.name,
    @required this.imageBytes,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        ContactAvatar(
          imageBytes: imageBytes,
          radius: 20,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            name,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
