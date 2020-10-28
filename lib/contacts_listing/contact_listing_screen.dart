import 'package:contacts/contacts_listing/contact_listing_state.dart';
import 'package:contacts/contacts_listing/ui/contacts_list.dart';
import 'package:contacts/contacts_listing/ui/persistent_bottom_sheet.dart';
import 'package:contacts/contacts_listing/ui/search_bar.dart';
import 'package:contacts/general/app_state.dart';
import 'package:flutter/material.dart';
import 'package:rebloc/rebloc.dart';

import 'contact_listing_actions.dart';

const List<String> alphabetData = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "V", "X", "Y", "Z"];

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final contactsScrollController = ScrollController();

  final searchController = TextEditingController();

  final searchFocusNode = FocusNode();

  final double _bottomSheetHeight = 100;
  final double _persistentItemHeight = 48;

  @override
  void initState() {
    super.initState();
    //TODO look for better solution
    Future.delayed(Duration.zero, () {
      StoreProvider
          .of<AppState>(context)
          .states
          .stream
          .listen((event) {
        final noScrollNeeded = -1;
        final destinationIndex = event.contactListingState.jumpTo;
        if (destinationIndex != noScrollNeeded && contactsScrollController.hasClients) {
          contactsScrollController?.animateTo(_persistentItemHeight * destinationIndex.toDouble(),
              duration: Duration(seconds: 1), curve: Curves.linear);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _display("Contacts"),
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
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: SearchBar(
              controller: searchController,
              focusNode: searchFocusNode,
              hintText: "Search people",
              onSearchPressedCallback: (query) {
                StoreProvider.of<AppState>(context).dispatch(SearchContactAction(query: query));
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.add,
                color: Colors.indigo,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildContactList() {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: ViewModelSubscriber<AppState, ContactListingState>(
              converter: (state) => state.contactListingState,
              builder: (context, dispatcher, contactsViewModel) {
                return ContactList(
                  contactsViewModel,
                  contactsScrollController,
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Column(
                  children: alphabetData.map((e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Text(e),
                  )).toList(),
                ),
              ),
            ),
          )
        ],
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
