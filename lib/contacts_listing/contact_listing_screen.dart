import 'package:contacts/contacts_listing/contact_listing_state.dart';
import 'package:contacts/contacts_listing/ui/contacts_list.dart';
import 'package:contacts/contacts_listing/ui/persistent_bottom_sheet.dart';
import 'package:contacts/contacts_listing/ui/search_bar.dart';
import 'package:contacts/general/app_state.dart';
import 'package:flutter/material.dart';
import 'package:rebloc/rebloc.dart';

class ContactsScreen extends StatelessWidget {
  final contactsScrollController = ScrollController();

  final searchController = TextEditingController();

  final searchFocusNode = FocusNode();

  final double _bottomSheetHeight = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _display('Contacts'),
      body: _buildScreenBody(),
      bottomSheet: _buildPersistentBottomSheet(),
    );
  }

  AppBar _display(String title) {
    return AppBar(
      title: Text(title),
      toolbarHeight: 80,
    );
  }

  SafeArea _buildScreenBody() {
    return SafeArea(
      child: Padding(
        /// https://github.com/flutter/flutter/issues/50314
        padding: EdgeInsets.only(bottom: _bottomSheetHeight),
        child: Column(
          children: [
            _buildSearchBar(),
            _buildContactList(),
          ],
        ),
      ),
    );
  }

  Padding _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: SearchBar(
        controller: searchController,
        focusNode: searchFocusNode,
        hintText: 'Search people',
        onSearchPressedCallback: (query) {},
      ),
    );
  }

  Expanded _buildContactList() {
    return Expanded(
      child: ViewModelSubscriber<AppState, ContactListingState>(
        converter: (state) => state.contactListingState,
        builder: (context, dispatcher, contactsViewModel) {
          return ContactList(
            contactsViewModel,
            contactsScrollController,
          );
        },
      ),
    );
  }

  PersistentBottomSheet _buildPersistentBottomSheet() {
    return PersistentBottomSheet(
      height: _bottomSheetHeight,
      onCancelSearchPressedCallback: () {
        searchController.clear();
      },
      onHighlightPressedCallback: () {
        //TODO The floating action button should highlight the contact matching the name in blue and scroll to it.
      },
    );
  }
}
