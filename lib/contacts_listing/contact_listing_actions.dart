import 'package:contacts/contacts_listing/model/highlighted_contact.dart';
import 'package:rebloc/rebloc.dart';

class TryGetContactsAction extends Action {}

class OnGotContactsAction extends Action {
  final List<HighlightedContact> contacts;

  OnGotContactsAction(this.contacts);
}

class ChangeContactsPermissionStatusAction extends Action {
  final bool isGranted;

  ChangeContactsPermissionStatusAction({this.isGranted});
}

class ContactsLoadingStateAction extends Action {
  final bool isLoading;

  ContactsLoadingStateAction({this.isLoading});
}

class FilterContactAction extends Action {
  final String query;

  FilterContactAction({this.query});
}

class SearchContactAction extends Action {
  final String query;

  SearchContactAction({this.query});
}

class JumpToContactIndexAction extends Action {
  final int index;

  JumpToContactIndexAction({this.index});
}
