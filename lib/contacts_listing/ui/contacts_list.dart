import 'package:contacts/contacts_listing/contact_listing_state.dart';
import 'package:flutter/material.dart';

import 'contact_item.dart';

class ContactList extends StatelessWidget {
  final ContactListingState contactsViewModel;
  final ScrollController scrollController;

  ContactList(
    this.contactsViewModel,
    this.scrollController,
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
      return Scrollbar(
        radius: Radius.circular(16),
        child: ListView.separated(
          controller: scrollController,
          itemCount: contactsViewModel.contacts.length,
          padding: EdgeInsets.all(16),
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            return ContactItem(
              contact: contactsViewModel.contacts[index],
            );
          },
        ),
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
