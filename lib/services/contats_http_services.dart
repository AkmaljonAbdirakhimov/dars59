import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dars59/models/contact.dart';

class ContatsHttpServices {
  Future<List<Contact>> getContacts() async {
    Uri url = Uri.parse(
        "https://lesson50-efebe-default-rtdb.asia-southeast1.firebasedatabase.app/contacts.json");

    final response = await http.get(url);
    final data = jsonDecode(response.body);
    List<Contact> contacts = [];

    if (data != null) {
      data.forEach((key, value) {
        contacts.add(
          Contact(
            id: key,
            name: value['name'],
            phone: value['phone'],
            address: value['address'],
            isFavorite: value['isFavorite'],
          ),
        );
      });
    }

    return contacts;
  }

  Future<void> addContact(String name, String phone) async {
    Uri url = Uri.parse(
        "https://lesson50-efebe-default-rtdb.asia-southeast1.firebasedatabase.app/contacts.json");

    final response = await http.post(
      url,
      body: jsonEncode(
        {
          "name": name,
          "phone": phone,
          "isFavorite": false,
        },
      ),
    );

    final data = jsonDecode(response.body);
    print(data);
  }

  Future<void> toggleFavorite(String id, bool isFavorite) async {
    Uri url = Uri.parse(
        "https://lesson50-efebe-default-rtdb.asia-southeast1.firebasedatabase.app/contacts/$id.json");
    final response = await http.patch(
      url,
      body: jsonEncode(
        {
          "isFavorite": isFavorite,
        },
      ),
    );

    print(response.body);
  }
}
