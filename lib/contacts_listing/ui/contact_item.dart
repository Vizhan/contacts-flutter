import 'package:contacts/contacts_listing/model/highlighted_contact.dart';
import 'package:contacts/contacts_listing/ui/contact_avatar.dart';
import 'package:flutter/material.dart';
import 'package:contacts/general/util/string_extension.dart';

class ContactItem extends StatelessWidget {
  final HighlightedContact contact;

  ContactItem({
    @required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: contact.isHighlighted ? Colors.indigo[50] : Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          ContactAvatar(
            imageBytes: contact.contact.avatar,
            radius: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              contact.contact.displayName.orDefault('No name'),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
