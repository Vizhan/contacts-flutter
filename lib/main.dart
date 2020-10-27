import 'package:contacts/contacts_listing/contact_listing_actions.dart';
import 'package:contacts/contacts_listing/contact_listing_bloc.dart';
import 'package:flutter/material.dart';
import 'package:rebloc/rebloc.dart';

import 'contacts_listing/contact_listing_screen.dart';
import 'general/app_state.dart';
import 'general/bloc/logger_bloc.dart';
import 'general/theme/app_theme_provider.dart';

void main() {
  final store = Store<AppState>(
    initialState: AppState.initialState(),
    blocs: [
      LoggerBloc(),
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
      theme: AppThemeProvider.get(),
      home: ContactsScreen(),
    );
  }
}
