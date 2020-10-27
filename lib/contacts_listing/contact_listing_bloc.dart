import 'dart:async';

import 'package:contacts/general/app_state.dart';
import 'package:flutter_contacts_plugin/contact_model.dart';
import 'package:flutter_contacts_plugin/flutter_contacts_plugin.dart';
import 'package:rebloc/rebloc.dart';

import 'contact_listing_actions.dart';

class ContactListingBloc extends SimpleBloc<AppState> {
  @override
  FutureOr<Action> middleware(DispatchFunction dispatcher, AppState state, Action action) {
    switch (action.runtimeType) {
      case InitialAction:
        //TODO
        break;
      case TryGetContactsAction:
        _getContactsFromDevice(dispatcher, state);
        break;
    }
    return action;
  }

  @override
  AppState reducer(AppState state, Action action) {
    switch (action.runtimeType) {
      case OnGotContactsAction:
        return state.copyWith(
          contactListingState: state.contactListingState.copyWith(
            contacts: (action as OnGotContactsAction).contacts,
          ),
        );
        break;
      default:
        return state;
    }
  }

  void _getContactsFromDevice(DispatchFunction dispatcher, AppState state) async {
    Iterable<Contact> contacts = await FlutterContactsPlugin.contacts;
    dispatcher(OnGotContactsAction(contacts.toList()));
  }
}
