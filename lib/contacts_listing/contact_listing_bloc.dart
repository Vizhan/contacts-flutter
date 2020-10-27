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
      case SearchContactAction:
        _filterContacts(dispatcher, state, action as SearchContactAction);
        break;
      case HighlightContactByQueryAction:
        _showFirstMatch(dispatcher, state, action as HighlightContactByQueryAction);
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
            jumpTo: 0,
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
      case JumpToContactIndexAction:
        return state.copyWith(
          contactListingState: state.contactListingState.copyWith(
            jumpTo: (action as JumpToContactIndexAction).index,
          ),
        );
        break;
      default:
        return state;
    }
  }

  @override
  FutureOr<Action> afterware(dispatcher, AppState state, Action action) {
    switch (action.runtimeType) {
      case JumpToContactIndexAction:
        if ((action as JumpToContactIndexAction).index != -1) {
          dispatcher(JumpToContactIndexAction(index: -1));
        }
        break;
    }
    return action;
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

  void _filterContacts(DispatchFunction dispatcher, AppState state, SearchContactAction action) async {
    if (action.query.isEmpty) {
      dispatcher(TryGetContactsAction());
      return;
    }

    final contacts = state.contactListingState.contacts;
    final filteredContacts = contacts.where((element) => element.displayName.toLowerCase().contains(action.query.toLowerCase()));
    dispatcher(OnGotContactsAction(filteredContacts.toList()));
  }

  void _showFirstMatch(DispatchFunction dispatcher, AppState state, HighlightContactByQueryAction action) async {
    final contacts = state.contactListingState.contacts;
    final firstMatchedContact =
        contacts.firstWhere((element) => element.displayName.toLowerCase().contains(action.query.toLowerCase()), orElse: null);

    int firstMatchedContactIndex = -1;
    if (firstMatchedContact != null) {
      firstMatchedContactIndex = contacts.indexOf(firstMatchedContact);
    }

    dispatcher(JumpToContactIndexAction(index: firstMatchedContactIndex));
  }
}
