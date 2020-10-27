import 'package:contacts/contacts_listing/ui/search_bar.dart';
import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _display('Contacts'),
      body: _buildScreenBody(),
    );
  }

  AppBar _display(String title) {
    return AppBar(
      title: Text(title),
      toolbarHeight: 100,
    );
  }

  SafeArea _buildScreenBody() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SearchBar(
              controller: searchController,
              focusNode: searchFocusNode,
              hintText: 'Search people',
              onSearchPressedCallback: (query) {},
            ),
          ],
        ),
      ),
    );
  }
}
