import 'package:booking/admin/models/makeplan_model.dart';
import 'package:booking/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'new_makeplans_page.dart';

class MakePlans extends StatefulWidget {
  const MakePlans({super.key});

  @override
  State<MakePlans> createState() => _MakePlansState();
}

class _MakePlansState extends State<MakePlans> {
  // adding services
  void addMakePlans(MakePlanModel makePlan) {
    // log('Name: ${contact.name}, Age: ${contact.age}');
    final makePlansBox = Hive.box('make_plans');
    makePlansBox.add(makePlan);
  }

// Function to show delete confirmation dialog
  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this service?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // services.removeAt(index);
                  Hive.box('make_plans').deleteAt(index);
                  // makePlansBox.deleteAt(
                  //   index,
                  // );
                });
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  // Function to show create service dialog
  void _showCreateServiceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create Service'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  _title = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _price = double.parse(value);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _createService();
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

// Variables to store entered values
  String _title = '';
  double _price = 0.0;

// Function to create a service
  void _createService() {
    if (_title.isNotEmpty && _price > 0) {
      final makePlan = MakePlanModel(
        "$_price",
        _title,
        _title,
      );
      // final service = Service(title: _title, price: _price);
      setState(() {
        // services.add(service);
        addMakePlans(makePlan);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  _showCreateServiceDialog();
                },
                child: const Text(
                  'Create Service',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // const Text('Chat with user'),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const HomePage();
                    }));
                  },
                  child: const Icon(Icons.chat_sharp),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: _buildListView()),
            const NewMakePlans(),
          ],
        ));
  }

  Widget _buildListView() {
    // final contactsBox = Hive.box('contacts');
    return WatchBoxBuilder(
      box: Hive.box('make_plans'),
      builder: (context, makePlansBox) {
        return ListView.builder(
          itemCount: makePlansBox.length,
          itemBuilder: (context, index) {
            final makePlan = makePlansBox.getAt(index) as MakePlanModel;
            return InkWell(
              onTap: () {
                // _showDeleteConfirmationDialog(index);
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    // backgroundColor: Colors.white,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Event Title',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  const Spacer(),
                                  Text(
                                    makePlan.eventTitle,
                                    style: const TextStyle(fontSize: 25),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Resource Title',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  const Spacer(),
                                  Text(
                                    makePlan.resourceTitle,
                                    style: const TextStyle(fontSize: 25),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Booked From',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  const Spacer(),
                                  Text(
                                    makePlan.booked_from,
                                    style: const TextStyle(fontSize: 25),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // makePlansBox.deleteAt(
                                  //   index,
                                  // );
                                  _showDeleteConfirmationDialog(
                                    index,
                                  );
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Delete this service',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    Spacer(),
                                    Icon(Icons.delete),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                            ),
                            child: Text(
                              makePlan.eventTitle,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          // const SizedBox(
                          //   width: 80,
                          // ),
                          const Spacer(),
                          Container(
                            decoration: const BoxDecoration(),
                            child: Text(
                              makePlan.resourceTitle,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          // ListTile(
                          // title: Text(contact.eventTitle),
                          // subtitle: Text(contact.booked_from),
                          // trailing: const Row(
                          // mainAxisSize: MainAxisSize.min,
                          // children: [
                          // IconButton(
                          //   onPressed: () {
                          //     contactsBox.putAt(
                          //       index,
                          //       Contact('${contact.name}*', contact.age + 1),
                          //     );
                          //   },
                          //   icon: const Icon(Icons.refresh),
                          // ),
                          // IconButton(
                          //   onPressed: () {
                          //     makePlansBox.deleteAt(
                          //       index,
                          //     );
                          //   },
                          //   icon: const Icon(Icons.delete),
                          // ),
                          // ],
                          // ),
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey,
                      // indent: 16,
                      // endIndent: 16,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
    // return ListView.builder(
    //   itemCount: contactsBox.length,
    //   itemBuilder: (context, index) {
    //     final contact = contactsBox.getAt(index) as Contact;
    //     return ListTile(
    //       title: Text(contact.name),
    //       subtitle: Text(contact.age.toString()),
    //     );
    //   },
    // );
  }
}
