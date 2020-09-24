import 'package:contacts/contacts_listing/contact_listing_actions.dart';
import 'package:contacts/contacts_listing/contact_listing_bloc.dart';
import 'package:flutter/material.dart';
import 'package:rebloc/rebloc.dart';

import 'contacts_listing/contact_listing_screen.dart';
import 'general/app_state.dart';

void main() {
  final store = Store<AppState>(
    initialState: AppState.initialState(),
    blocs: [
      ContactListingBloc(),
    ],
  );

  runApp(
    StoreProvider<AppState>(
      store: store,
      child: ContactsApplication(),
    ),
  );

  store.dispatch(InitialAction());
}

class ContactsApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contacts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ContactsScreen(),
    );
  }
}
