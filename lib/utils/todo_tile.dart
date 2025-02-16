import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  void Function(BuildContext)? deleteTask; // onChanged should be final

  TodoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: deleteTask,
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: 'Delete',
            borderRadius: BorderRadius.circular(12),
          ),
        ]),
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged, // Fixed the semicolon issue
                activeColor:
                    Colors.green, // Optional: Customize the checkbox color
              ),
              Text(
                taskName,
                style: GoogleFonts.poppins(
                  color: taskCompleted ? Colors.green : Colors.white,
                  fontSize: 16, // Optional: Adjust font size
                  fontWeight: FontWeight.w500,
                  // Optional: Adjust font weight
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
