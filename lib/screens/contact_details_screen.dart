import 'package:dars59/models/contact.dart';
import 'package:dars59/view_models/contacts_viewmodel.dart';
import 'package:flutter/material.dart';

class ContactDetailsScreen extends StatefulWidget {
  Contact contact;
  ContactDetailsScreen({
    super.key,
    required this.contact,
  });

  @override
  State<ContactDetailsScreen> createState() => _ContactDetailsScreenState();
}

class _ContactDetailsScreenState extends State<ContactDetailsScreen> {
  final contactsViewModel = ContactsViewmodel();
  void toggleFavorite() async {
    widget.contact.isFavorite = !widget.contact.isFavorite;
    setState(() {});

    contactsViewModel.toggleFavorite(
      widget.contact.id,
      widget.contact.isFavorite,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact.name),
        actions: [
          IconButton(
            onPressed: toggleFavorite,
            icon: Icon(
              widget.contact.isFavorite ? Icons.star : Icons.star_outline,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.contact.phone,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.contact.address ?? "Mars",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
