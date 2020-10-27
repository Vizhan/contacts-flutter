import 'package:flutter_contacts_plugin/contact_model.dart';
import 'package:rebloc/rebloc.dart';

class TryGetContactsAction extends Action {}

class OnGotContactsAction extends Action {
  final List<Contact> contacts;

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
