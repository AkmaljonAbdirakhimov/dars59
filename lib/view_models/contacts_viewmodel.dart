import 'package:dars59/models/contact.dart';
import 'package:dars59/services/contats_http_services.dart';

class ContactsViewmodel {
  final contactsHttpServices = ContatsHttpServices();
  List<Contact> _list = [];

  Future<List<Contact>> get list async {
    _list = await contactsHttpServices.getContacts();
    return [..._list];
  }

  Future<void> addContact(String name, String phone) async {
    await contactsHttpServices.addContact(name, phone);
  }

  Future<void> toggleFavorite(String id, bool isFavorite) async {
    await contactsHttpServices.toggleFavorite(id, isFavorite);
  }
}
