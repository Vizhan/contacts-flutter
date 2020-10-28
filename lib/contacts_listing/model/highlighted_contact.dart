import 'package:flutter_contacts_plugin/contact_model.dart';

class HighlightedContact {
  bool isHighlighted;
  final Contact contact;

  HighlightedContact({
    this.contact,
    this.isHighlighted = false,
  });
}
