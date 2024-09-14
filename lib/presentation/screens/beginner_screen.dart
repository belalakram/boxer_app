import 'package:boxer/presentation/screens/inactive_screen.dart';
import 'package:flutter/material.dart';
import '../../core/my_scaffold.dart';
import 'package:boxer/core/main_text_field.dart';
import 'package:boxer/presentation/widgets/title_app.dart';
import 'package:quickalert/quickalert.dart';
import 'package:boxer/core/services/client_model.dart';
import 'package:boxer/core/services/firebase_firestore.dart';

class BeginnerScreen extends StatefulWidget {
  const BeginnerScreen({super.key});

  @override
  State<BeginnerScreen> createState() => _BeginnerScreenState();
}

class _BeginnerScreenState extends State<BeginnerScreen> {
  String? selectValue;
  DateTime startTimeValue = DateTime.now();
  DateTime endTimeValue = DateTime.now().add(const Duration(days: 30));
  final TextEditingController nameController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  String? nameError;
  String? notesError;

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
                          controller: nameController,
                        ),
                        if (nameError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              nameError!,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 16),
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
                          controller: notesController,
                        ),
                        if (notesError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              notesError!,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 16),
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
                    label: "Start Time",
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
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.8, 50),
                    ),
                    onPressed: () async {
                      setState(() {
                        // Validate fields and update error messages
                        nameError = nameController.text.trim().isEmpty
                            ? 'Please enter your name.'
                            : null;
                        notesError = notesController.text.trim().isEmpty
                            ? 'Please enter some notes.'
                            : null;
                      });

                      // If there are no errors, proceed with saving
                      if (nameError == null && notesError == null) {
                        ClientModel newClient = ClientModel(
                          name: nameController.text.trim(),
                          note: notesController.text.trim(),
                          type: selectValue ?? "Unknown",
                          startDate: startTimeValue.millisecondsSinceEpoch,
                          endDate: endTimeValue.millisecondsSinceEpoch,
                        );

                        try {
                          await addClient(newClient);

                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            text: 'Transaction Completed Successfully!',
                            onConfirmBtnTap: () {
                              Navigator.pop(context);
                              nameController.clear();
                              notesController.clear();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => InactiveScreen(),
                                  ));
                            },
                          );

                          // Clear the fields and reset state
                          nameController.clear();
                          notesController.clear();
                          setState(() {
                            selectValue = null;
                            startTimeValue = DateTime.now();
                            endTimeValue =
                                DateTime.now().add(const Duration(days: 30));
                          });
                        } catch (e) {
                          print(
                              "Error adding client: $e"); // Print error for debugging
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.error,
                            title: 'Error',
                            text: 'Failed to save data. Please try again.',
                          );
                        }
                      }
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
      initialDate: startTimeValue,
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
      initialDate: endTimeValue,
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
