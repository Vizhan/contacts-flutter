
import 'package:flutter_contacts_plugin/contact_model.dart';

class ContactListingState {
  final List<Contact> contacts;

  ContactListingState({
    this.contacts,
  });

  factory ContactListingState.initialState() => ContactListingState(
        contacts: [],
      );

  ContactListingState copyWith({
    List<Contact> contacts,
  }) {
    return ContactListingState(
      contacts: contacts ?? this.contacts,
    );
  }
}
