import 'package:contacts/contacts_listing/contact_listing_state.dart';

class AppState {
  final ContactListingState contactListingState;

  const AppState({
    this.contactListingState,
  });

  factory AppState.initialState() => AppState(
        contactListingState: ContactListingState.initialState(),
      );

  AppState copyWith({
    ContactListingState contactListingState,
  }) {
    return AppState(
      contactListingState: contactListingState ?? this.contactListingState,
    );
  }
}
