import 'package:flutter_contacts_plugin/contact_model.dart';

class ContactListingState {
  final List<Contact> contacts;
  final bool isLoading;
  final bool isUserPermissionGranted;

  ContactListingState({
    this.contacts,
    this.isLoading,
    this.isUserPermissionGranted,
  });

  factory ContactListingState.initialState() => ContactListingState(
        contacts: [],
        isLoading: true,
        isUserPermissionGranted: false,
      );

  ContactListingState copyWith({
    List<Contact> contacts,
    bool isLoading,
    bool isUserPermissionGranted,
  }) {
    return ContactListingState(
      contacts: contacts ?? this.contacts,
      isLoading: isLoading ?? this.isLoading,
      isUserPermissionGranted: isUserPermissionGranted ?? this.isUserPermissionGranted,
    );
  }
}
