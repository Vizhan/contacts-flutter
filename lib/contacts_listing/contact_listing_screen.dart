import 'package:contacts/contacts_listing/ui/contact_item.dart';
import 'package:contacts/contacts_listing/ui/persistent_bottom_sheet.dart';
import 'package:contacts/contacts_listing/ui/search_bar.dart';
import 'package:contacts/general/app_state.dart';
import 'package:contacts/general/util/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts_plugin/contact_model.dart';
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
      child: ViewModelSubscriber<AppState, List<Contact>>(
        converter: (state) => state.contactListingState.contacts,
        builder: (context, dispatcher, contacts) {
          return contacts.isNotEmpty
              ? ListView.separated(
                  controller: contactsScrollController,
                  itemCount: contacts.length,
                  padding: EdgeInsets.all(16),
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    return ContactItem(
                      name: contacts[index].displayName.orDefault('no name'),
                      imageBytes: contacts[index].avatar,
                    );
                  },
                )
              : Center(child: CircularProgressIndicator());
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
