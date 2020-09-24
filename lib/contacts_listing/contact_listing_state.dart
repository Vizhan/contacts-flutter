class ContactListingState {
  final List<String> contacts;

  ContactListingState({
    this.contacts,
  });

  factory ContactListingState.initialState() => ContactListingState(
        contacts: [],
      );

  ContactListingState copyWith({
    List<String> contacts,
  }) {
    return ContactListingState(
      contacts: contacts ?? this.contacts,
    );
  }
}
