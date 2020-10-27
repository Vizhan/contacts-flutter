import 'dart:async';

import 'package:contacts/general/app_state.dart';
import 'package:flutter_contacts_plugin/contact_model.dart';
import 'package:flutter_contacts_plugin/flutter_contacts_plugin.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rebloc/rebloc.dart';

import 'contact_listing_actions.dart';

class ContactListingBloc extends SimpleBloc<AppState> {
  @override
  FutureOr<Action> middleware(DispatchFunction dispatcher, AppState state, Action action) {
    switch (action.runtimeType) {
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
      case ChangeContactsPermissionStatusAction:
        return state.copyWith(
          contactListingState: state.contactListingState.copyWith(
            isUserPermissionGranted: (action as ChangeContactsPermissionStatusAction).isGranted,
          ),
        );
        break;
      case ContactsLoadingStateAction:
        return state.copyWith(
          contactListingState: state.contactListingState.copyWith(
            isLoading: (action as ContactsLoadingStateAction).isLoading,
          ),
        );
        break;
      default:
        return state;
    }
  }

  void _getContactsFromDevice(DispatchFunction dispatcher, AppState state) async {
    if (await Permission.contacts.request().isGranted) {
      dispatcher(ChangeContactsPermissionStatusAction(isGranted: true));
      dispatcher(ContactsLoadingStateAction(isLoading: true));

      Iterable<Contact> contacts = await FlutterContactsPlugin.contacts;

      dispatcher(ContactsLoadingStateAction(isLoading: false));
      dispatcher(OnGotContactsAction(contacts.toList()));
    } else {
      dispatcher(ChangeContactsPermissionStatusAction(isGranted: false));
    }
  }
}
