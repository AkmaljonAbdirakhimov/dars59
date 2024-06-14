import 'package:dars59/view_models/contacts_viewmodel.dart';
import 'package:flutter/material.dart';

class AddContactDialog extends StatefulWidget {
  const AddContactDialog({super.key});

  @override
  State<AddContactDialog> createState() => _AddContactDialogState();
}

class _AddContactDialogState extends State<AddContactDialog> {
  final contactsViewModel = ContactsViewmodel();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Kontakt Qo'shish"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Ism",
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: phoneController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Telefon",
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Bekor qilish"),
        ),
        isLoading
            ? const CircularProgressIndicator()
            : FilledButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await contactsViewModel.addContact(
                      nameController.text, phoneController.text);
                  Navigator.pop(context, true);
                },
                child: const Text("Qo'shish"),
              ),
      ],
    );
  }
}
