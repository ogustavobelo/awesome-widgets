import 'package:awesome_widgets/screens/contactsList/alphabet.order.item.dart';
import 'package:awesome_widgets/screens/contactsList/contact.model.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'contact.tile.dart';
import 'contacts.datasource.dart';

class ContactsListScreen extends StatefulWidget {
  @override
  _ContactsListScreenState createState() => _ContactsListScreenState();
}

class _ContactsListScreenState extends State<ContactsListScreen> {
  final List<Color> _backgroundColors = [Color(0xFFBC4FFD), Color(0xFF6A00BA)];

  final TextEditingController _searchController = TextEditingController();
  final List<ContactModel> _contacts = ContactsDataSource.contacts;
  final List<String> _alphabet = ContactsDataSource.alphabet;
  List<ContactModel> _filteredContacts;
  List<String> _filteredAlphabet;

  final AutoScrollController scrollController = AutoScrollController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    if (_filteredContacts == null) {
      _filteredContacts = _contacts;
    }
    sortContacts(_filteredContacts);

    _filteredAlphabet = filterAlphabet();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _backgroundColors[0],
        elevation: 0.0,
        title: Text("Contacts List"),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _backgroundColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _searchController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Who are you looking for?",
                  hintStyle: TextStyle(color: _backgroundColors[1]),
                  contentPadding: EdgeInsets.all(10.0),
                  prefixIcon: Icon(
                    Icons.search,
                    color: _backgroundColors[1],
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white.withOpacity(.5)),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white.withOpacity(.5)),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(.5),
                ),
                textAlign: TextAlign.center,
                onChanged: (query) => filterContacts(query),
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Container(
                      width: size.width * .9,
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: _filteredAlphabet.length,
                        itemBuilder: (context, alphabetIndex) {
                          return AutoScrollTag(
                            controller: scrollController,
                            index: alphabetIndex,
                            key: ValueKey(alphabetIndex),
                            child: Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    margin: EdgeInsets.only(left: 16.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _backgroundColors[1],
                                    ),
                                    child: Text(
                                        _filteredAlphabet[alphabetIndex],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: _filteredContacts.length,
                                  itemBuilder: (context, contactIndex) {
                                    return Visibility(
                                        visible: _filteredContacts[contactIndex]
                                                .name[0] ==
                                            _filteredAlphabet[alphabetIndex],
                                        child: ContactTile(
                                            _filteredContacts[contactIndex]));
                                  },
                                )
                              ],
                            ),
                          );
                        },
                      )
                      ),
                  Container(
                      width: size.width * .1,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _alphabet.length,
                        itemBuilder: (context, index) {
                          return AlphabetOrderItem(
                              letter: _alphabet[index],
                              clickable: _filteredAlphabet.contains(_alphabet[index]),
                              color: Colors.white,
                              onPressed: () {
                                print("click");
                                scrollController.scrollToIndex(
                                  _filteredAlphabet.indexWhere((element) => element == _alphabet[index])
                                );
                              });
                        },
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sortContacts(List<ContactModel> contacts) {
    contacts.sort((a, b) => a.name.compareTo(b.name));
  }

  void filterContacts(String query) {
    List<ContactModel> filteredContacts = [];
    if (query.isNotEmpty) {
      for (var contact in _filteredContacts) {
        if (contact.name.toLowerCase().contains(query.toLowerCase())) {
          filteredContacts.add(contact);
        }
      }
    } else {
      filteredContacts = _contacts;
    }
    setState(() {
      _filteredContacts = filteredContacts;
    });
  }

  List<String> filterAlphabet() {
    List<String> filteredAlphabet = [];
    for (var contact in _filteredContacts) {
      for (var letter in _alphabet) {
        if (contact.name[0] == letter) {
          if (!filteredAlphabet.contains(letter)) {
            filteredAlphabet.add(letter);
          }
        }
      }
    }
    return filteredAlphabet;
  }
}
