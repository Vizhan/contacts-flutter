import 'dart:async';

import 'package:contacts/general/app_state.dart';
import 'package:rebloc/rebloc.dart';

import 'contact_listing_actions.dart';

class ContactListingBloc extends SimpleBloc<AppState> {
  @override
  FutureOr<Action> middleware(DispatchFunction dispatcher, AppState state, Action action) {
    switch (action.runtimeType) {
      case InitialAction:
        //TODO
        break;
    }
    return action;
  }

  @override
  AppState reducer(AppState state, Action action) {
    switch (action.runtimeType) {
      default:
        return state;
    }
  }
}
