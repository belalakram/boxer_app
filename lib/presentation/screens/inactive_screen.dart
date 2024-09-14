import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart'; // Ensure this import works
import '../../core/my_scaffold.dart';
import '../widgets/title_app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InactiveScreen extends StatefulWidget {
  const InactiveScreen({super.key});

  @override
  _InactiveScreenState createState() => _InactiveScreenState();
}

class _InactiveScreenState extends State<InactiveScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Column(
        children: [
          const SizedBox(height: 40),
          Row(
            children: const [
              SizedBox(width: 20),
              TitleApp(),
            ],
          ),
          const SizedBox(height: 270),

          // CalendarTimeline widget
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CalendarTimeline(
              initialDate: DateTime(2020, 4, 20),
              firstDate: DateTime(2019, 1, 15),
              lastDate: DateTime(2020, 11, 20),
              onDateSelected: (date) {
                setState(() {
                  _selectedDate = date;
                });
                print(date); // Handle selected date
              },
              leftMargin: 20,
              monthColor: Colors.blueGrey,
              dayColor: Colors.teal[200],
              activeDayColor: Colors.white,
              activeBackgroundDayColor: Colors.redAccent[100],
              selectableDayPredicate: (date) => date.day != 23,
              locale: 'en_ISO',
            ),
          ),

          const SizedBox(height: 20),

          // StreamBuilder to fetch saved data from Firebase
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('clients').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text("Error loading data."));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No data available."));
                }

                // Extracting the list of documents
                List<DocumentSnapshot> clientDocs = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: clientDocs.length,
                  itemBuilder: (context, index) {
                    // Getting client data from the document
                    Map<String, dynamic> clientData = clientDocs[index].data() as Map<String, dynamic>;

                    // Converting millisecondsSinceEpoch to DateTime
                    DateTime startDate = DateTime.fromMillisecondsSinceEpoch(clientData['startDate']);
                    DateTime endDate = DateTime.fromMillisecondsSinceEpoch(clientData['endDate']);

                    return ListTile(
                      title: Text(clientData['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Type: ${clientData['type']}"),
                          Text("Notes: ${clientData['note']}"),
                          Text("Start Date: ${startDate.year}/${startDate.month}/${startDate.day}"),
                          Text("End Date: ${endDate.year}/${endDate.month}/${endDate.day}"),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
