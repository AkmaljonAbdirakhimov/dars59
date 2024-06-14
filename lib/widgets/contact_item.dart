import 'package:dars59/models/contact.dart';
import 'package:dars59/screens/contact_details_screen.dart';
import 'package:dars59/view_models/contacts_viewmodel.dart';
import 'package:flutter/material.dart';

class ContactItem extends StatefulWidget {
  Contact contact;
  final VoidCallback callbackFromContactDetails;
  ContactItem({
    super.key,
    required this.contact,
    required this.callbackFromContactDetails,
  });

  @override
  State<ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
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
    return ListTile(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) {
              return ContactDetailsScreen(
                contact: widget.contact,
              );
            },
          ),
        );

        widget.callbackFromContactDetails();
      },
      title: Text(widget.contact.name),
      subtitle: Text(widget.contact.phone),
      trailing: IconButton(
        onPressed: toggleFavorite,
        icon: Icon(
          widget.contact.isFavorite ? Icons.star : Icons.star_border_outlined,
        ),
      ),
    );
  }
}
