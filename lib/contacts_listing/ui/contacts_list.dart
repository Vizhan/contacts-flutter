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
      return _buildPermissionMessage();
    }

    if (contactsViewModel.contacts.isNotEmpty) {
      return _buildContacts();
    }

    if (contactsViewModel.isLoading) {
      return _buildLoadingIndicator();
    }

    return _buildEmptyState();
  }

  Padding _buildPermissionMessage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'User permission required.',
            textAlign: TextAlign.center,
          ),
          Text(
            'Please, allow access to contacts in the application settings, then restart the application.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Scrollbar _buildContacts() {
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

  Center _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Center _buildEmptyState() {
    return Center(
      child: Text('No contacts'),
    );
  }
}
