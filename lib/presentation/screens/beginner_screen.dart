import 'package:flutter/material.dart'; // Required for all material components
import '../../core/my_scaffold.dart';
import 'package:boxer/core/main_text_field.dart';
import 'package:boxer/presentation/widgets/title_app.dart';
import 'package:quickalert/quickalert.dart'; // Import QuickAlert package

class BeginnerScreen extends StatefulWidget {
  const BeginnerScreen({super.key});

  @override
  State<BeginnerScreen> createState() => _BeginnerScreenState();
}

class _BeginnerScreenState extends State<BeginnerScreen> {
  String? selectValue; // Make it nullable to handle the initial state.
  DateTime startTimeValue = DateTime.now();
  DateTime endTimeValue = DateTime.now().add(const Duration(days: 30));
  final TextEditingController nameController = TextEditingController(); // Controller for the Name field
  final TextEditingController notesController = TextEditingController(); // Controller for the Notes field
  String? nameError; // State variable for the name error message
  String? notesError; // State variable for the notes error message

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Column(
        children: [
          // This part will remain fixed at the top
          const SizedBox(height: 40),
          Row(
            children: const [
              SizedBox(width: 20),
              TitleApp(),
            ],
          ),
          // This Expanded widget will make the rest of the content scrollable
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 270),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MainTextField(
                          hintText: "Name",
                          controller: nameController, // Attach controller
                        ),
                        if (nameError != null) // Conditionally show error message
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              nameError!,
                              style: const TextStyle(color: Colors.red, fontSize: 16),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MainTextField(
                          maxLines: 2,
                          hintText: "Notes",
                          controller: notesController, // Attach new controller
                        ),
                        if (notesError != null) // Conditionally show error message
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              notesError!,
                              style: const TextStyle(color: Colors.red, fontSize: 16),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButton<String>(
                      hint: const Text(
                        "Choose",
                        style: TextStyle(color: Colors.black),
                      ),
                      underline: const SizedBox(),
                      value: selectValue,
                      style: const TextStyle(color: Colors.black),
                      items: const [
                        DropdownMenuItem(
                          value: "Sat, Mon, Wed",
                          child: Text("Sat, Mon, Wed"),
                        ),
                        DropdownMenuItem(
                          value: "Sun, Tue, Thu",
                          child: Text("Sun, Tue, Thu"),
                        ),
                      ],
                      onChanged: (String? value) {
                        setState(() {
                          selectValue = value;
                        });
                      },
                    ),
                  ),
                  buildDatePickerRow(
                    label: "Smart Time",
                    dateValue: startTimeValue,
                    onPressed: showStartTime,
                  ),
                  buildDatePickerRow(
                    label: "End Time",
                    dateValue: endTimeValue,
                    onPressed: showEndTime,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 50), // Adjust height as needed
                    ),
                    onPressed: () {
                      setState(() {
                        nameError = nameController.text.trim().isEmpty ? 'Please enter your name.' : null;
                        notesError = notesController.text.trim().isEmpty ? 'Please enter some notes.' : null;
                        if (nameError == null && notesError == null) {
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            text: 'Transaction Completed Successfully!',
                          );
                          // Handle save logic here if needed
                        }
                      });
                    },
                    child: const Text("Save"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDatePickerRow({
    required String label,
    required DateTime dateValue,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              "${dateValue.year}/${dateValue.month}/${dateValue.day}",
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  void showStartTime() async {
    DateTime? startDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (startDate != null) {
      setState(() {
        startTimeValue = startDate;
      });
    }
  }

  void showEndTime() async {
    DateTime? endDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (endDate != null) {
      setState(() {
        endTimeValue = endDate;
      });
    }
  }
}
