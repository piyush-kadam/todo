import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/utils/buttons.dart';

class DialogueBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  DialogueBox({
    Key? key, // Ensure a key can be passed if required
    required this.controller,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      content: SizedBox(
        height: 120, // Adjusted to use SizedBox for clarity
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Input field for the task
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Add a new task",
                hintStyle: GoogleFonts.poppins(
                  color: Colors.white,
                ),
                border: const OutlineInputBorder(),
              ),
              style:
                  GoogleFonts.poppins(color: Colors.white), // Task input style
            ),
            // Row of buttons for Save and Cancel
            Row(
              children: [
                myButton(
                  name: "Save",
                  onPressed: onSave,
                ),
                const Spacer(),
                myButton(
                  name: "Cancel",
                  onPressed: onCancel,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
