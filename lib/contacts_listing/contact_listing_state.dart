import 'package:contacts/contacts_listing/model/highlighted_contact.dart';
import 'package:flutter_contacts_plugin/contact_model.dart';

class ContactListingState {
  final List<HighlightedContact> contacts;
  final bool isLoading;
  final bool isUserPermissionGranted;
  final int jumpTo;

  ContactListingState({
    this.contacts,
    this.isLoading,
    this.isUserPermissionGranted,
    this.jumpTo,
  });

  factory ContactListingState.initialState() => ContactListingState(
        contacts: [],
        isLoading: true,
        isUserPermissionGranted: false,
    jumpTo: -1,
      );

  ContactListingState copyWith({
    List<HighlightedContact> contacts,
    bool isLoading,
    bool isUserPermissionGranted,
    int jumpTo,
  }) {
    return ContactListingState(
      contacts: contacts ?? this.contacts,
      isLoading: isLoading ?? this.isLoading,
      isUserPermissionGranted: isUserPermissionGranted ?? this.isUserPermissionGranted,
      jumpTo: jumpTo ?? this.jumpTo,
    );
  }
}
