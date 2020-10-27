import 'package:contacts/contacts_listing/contact_listing_state.dart';
import 'package:flutter/material.dart';
import 'package:contacts/general/util/string_extension.dart';

import 'contact_item.dart';

class ContactList extends StatelessWidget {
  final ContactListingState contactsViewModel;
  final ScrollController contactsScrollController;

  ContactList(
    this.contactsViewModel,
    this.contactsScrollController,
  );

  @override
  Widget build(BuildContext context) {
    if (!contactsViewModel.isUserPermissionGranted) {
      return Center(
        child: Container(
          child: Text('User permission required'),
        ),
      );
    }

    if (contactsViewModel.contacts.isNotEmpty) {
      return ListView.separated(
        controller: contactsScrollController,
        itemCount: contactsViewModel.contacts.length,
        padding: EdgeInsets.all(16),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          return ContactItem(
            name: contactsViewModel.contacts[index].displayName.orDefault('no name'),
            imageBytes: contactsViewModel.contacts[index].avatar,
          );
        },
      );
    }

    if (contactsViewModel.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Center(
      child: Text('No contacts'),
    );
  }
}
