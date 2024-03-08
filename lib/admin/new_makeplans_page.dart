import 'dart:convert';

import 'package:booking/admin/models/makeplan_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class NewMakePlans extends StatefulWidget {
  const NewMakePlans({super.key});

  @override
  State<NewMakePlans> createState() => _NewMakePlansState();
}

class _NewMakePlansState extends State<NewMakePlans> {
  @override
  void initState() {
    fetchAndCacheServices();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  // late String _name;
  //  late String _age;
  late String booked_from;
  late String resourceTitle;
  late String eventTitle;

  late String createdAt;
  late String updatedAt;
  late String phoneNumber;

  Future<void> fetchAndCacheServices() async {
    final response = await http.get(
        Uri.parse(
            "https://meshutechsolution.test.makeplans.net/api/v1/bookings"),
        headers: {
          "Authorization": "Bearer 060d2f4bffe074f2479aedc500c63edb50813cbf"
        });

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      // var box = await Hive.openBox('contacts');

      for (var serviceData in data) {
        MakePlanModel makePlan = MakePlanModel(
          // title: contactData['title'],
          // price: contactData['price'],
          // description: contactData['description'],
          serviceData["booking"]['booked_from'] ?? "null",
          serviceData["booking"]["resource"]['title'],
          serviceData["booking"]["event"]['title'],

          /*
          this.serviceTitle,
    this.bookingTitle,
    this.bookingPrice,
          */
        );
        addMakePlans(makePlan);
        // box.add(contact);
      }
    } else {
      throw Exception('Failed to load services');
    }
  }

  void addMakePlans(MakePlanModel makePlan) {
    // log('Name: ${contact.name}, Age: ${contact.age}');
    final makePlansBox = Hive.box('make_plans');
    makePlansBox.add(makePlan);
  }

  @override
  Widget build(BuildContext context) {
    // return Form(

    //   key: _formKey,
    //   child: Column(
    //     children: [
    //       Row(
    //         children: <Widget>[
    //           Expanded(
    //             child: TextFormField(
    //               decoration: const InputDecoration(labelText: 'BookedFrom'),
    //               onSaved: (value) => booked_from = value!,
    //             ),
    //           ),
    //           const SizedBox(width: 10),
    //           Expanded(
    //             child: TextFormField(
    //               decoration: const InputDecoration(labelText: 'EventTitle'),
    //               onSaved: (value) => eventTitle = value!,
    //             ),
    //           ),
    //           const SizedBox(width: 10),
    //           Expanded(
    //             child: TextFormField(
    //               decoration: const InputDecoration(labelText: 'ResourceTitle'),
    //               // keyboardType: TextInputType.number,
    //               onSaved: (value) => resourceTitle = value!,
    //             ),
    //           ),
    //         ],
    //       ),
    //       TextButton(
    //         child: const Text('Add New Contact'),
    //         onPressed: () {
    //           _formKey.currentState!.save();
    //           // final newContact = Contact(_name, int.parse(_age));
    //           final makePlan = MakePlanModel(
    //             booked_from,
    //             resourceTitle,
    //             eventTitle,
    //           );
    //           addMakePlans(makePlan);
    //         },
    //       ),
    //     ],
    //   ),
    // );
    return Container();
  }
}
