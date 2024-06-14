import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dars59/services/auth_http_services.dart';
import 'package:dars59/view_models/contacts_viewmodel.dart';
import 'package:dars59/widgets/add_contact.dart';
import 'package:dars59/widgets/contact_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pageController = PageController();
  final contactsViewModel = ContactsViewmodel();
  final authHttpServices = AuthHttpServices();

  int activePageIndex = 0;

  void addContact() async {
    final response = await showDialog(
      context: context,
      builder: (ctx) {
        return const AddContactDialog();
      },
    );

    if (response == true) {
      setState(() {});
    }
  }

  void callbackFromContactDetails() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: DropdownButton(
          alignment: AlignmentDirectional.centerEnd,
          value: context.locale,
          items: const [
            DropdownMenuItem(
              value: Locale("en"),
              child: Text("English"),
            ),
            DropdownMenuItem(
              value: Locale("uz"),
              child: Text("O'zbek"),
            ),
          ],
          onChanged: (value) {
            context.setLocale(value!);
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          context.tr("hello"),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final themeMode = await AdaptiveTheme.getThemeMode();
              if (themeMode == AdaptiveThemeMode.dark) {
                AdaptiveTheme.of(context).setLight();
              } else {
                AdaptiveTheme.of(context).setDark();
              }
            },
            icon: const Icon(Icons.dark_mode),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: PageView(
              controller: pageController,
              onPageChanged: (value) {
                activePageIndex = value;
                setState(() {});
              },
              children: [
                FutureBuilder(
                  future: contactsViewModel.list,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final contacts = snapshot.data;
                    return contacts == null || contacts.isEmpty
                        ? const Center(
                            child: Text("Kontaktlar mavjud emas."),
                          )
                        : ListView.builder(
                            itemCount: contacts.length,
                            itemBuilder: (ctx, index) {
                              return ContactItem(
                                contact: contacts[index],
                                callbackFromContactDetails:
                                    callbackFromContactDetails,
                              );
                            },
                          );
                  },
                ),
                Center(
                  child: FilledButton(
                    onPressed: () async {
                      await authHttpServices.updatePassword();
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          return const AlertDialog(
                            title: Text("Xabar Yuborildi!"),
                            content: Text(
                                "Parolni tiklash uchun elektron manzilingizga xabar yuborildi!"),
                          );
                        },
                      );
                    },
                    child: const Text("UPDATE PASSWORD"),
                  ),
                ),
                Center(
                  child: Text(context.tr("apple")),
                ),
                const Center(
                  child: Text("CHAT"),
                )
              ],
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: Icon(
                    Icons.home,
                    color: activePageIndex == 0 ? Colors.black : Colors.grey,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: Icon(
                    Icons.person,
                    color: activePageIndex == 1 ? Colors.black : Colors.grey,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    pageController.animateToPage(
                      2,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: Icon(
                    Icons.settings,
                    color: activePageIndex == 2 ? Colors.black : Colors.grey,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    pageController.animateToPage(
                      3,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: Icon(
                    Icons.chat,
                    color: activePageIndex == 3 ? Colors.black : Colors.grey,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addContact,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
