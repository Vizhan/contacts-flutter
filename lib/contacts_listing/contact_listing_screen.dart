import 'package:contacts/contacts_listing/contact_listing_state.dart';
import 'package:contacts/contacts_listing/ui/contacts_list.dart';
import 'package:contacts/contacts_listing/ui/persistent_bottom_sheet.dart';
import 'package:contacts/contacts_listing/ui/search_bar.dart';
import 'package:contacts/general/app_state.dart';
import 'package:flutter/material.dart';
import 'package:rebloc/rebloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'contact_listing_actions.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final contactsScrollController = ScrollController();

  final ItemScrollController itemScrollController = ItemScrollController();

  final searchController = TextEditingController();

  final searchFocusNode = FocusNode();

  final double _bottomSheetHeight = 100;

  @override
  void initState() {
    super.initState();
    //TODO look for better decision
    Future.delayed(Duration.zero, () {
      StoreProvider.of<AppState>(context).states.stream.listen((event) {
        final invalidIndex = -1;
        final destinationIndex = event.contactListingState.jumpTo;
        if (destinationIndex != invalidIndex) {
          itemScrollController.scrollTo(index: destinationIndex, duration: Duration(seconds: 1));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _display('Contacts'),
      body: _buildScreenBody(context),
      bottomSheet: _buildPersistentBottomSheet(context),
    );
  }

  AppBar _display(String title) {
    return AppBar(
      title: Text(title),
      toolbarHeight: 80,
    );
  }

  SafeArea _buildScreenBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        /// https://github.com/flutter/flutter/issues/50314
        padding: EdgeInsets.only(bottom: _bottomSheetHeight),
        child: Column(
          children: [
            _buildSearchBar(context),
            _buildContactList(),
          ],
        ),
      ),
    );
  }

  Padding _buildSearchBar(BuildContext context) {
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
        onSearchPressedCallback: (query) {
          StoreProvider.of<AppState>(context).dispatch(SearchContactAction(query: query));
        },
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
            itemScrollController,
          );
        },
      ),
    );
  }

  PersistentBottomSheet _buildPersistentBottomSheet(BuildContext context) {
    return PersistentBottomSheet(
      height: _bottomSheetHeight,
      onCancelSearchPressedCallback: () {
        searchController.clear();
        StoreProvider.of<AppState>(context).dispatch(TryGetContactsAction());
      },
      onHighlightPressedCallback: () {
        searchFocusNode.unfocus();

        StoreProvider.of<AppState>(context).dispatch(HighlightContactByQueryAction(query: searchController.text));
      },
    );
  }
}
