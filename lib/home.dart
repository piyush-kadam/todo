import 'package:confetti/confetti.dart'; // Import the confetti package
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/utils/dialogue_box.dart';
import 'package:todo/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final _controller = TextEditingController();

class _HomePageState extends State<HomePage> {
  List todoList = [];
  late ConfettiController _confettiController; // Controller for confetti

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
        duration: const Duration(seconds: 1)); // Initialize confetti controller
    _loadTasks(); // Load tasks from SharedPreferences on startup
  }

  @override
  void dispose() {
    _confettiController.dispose(); // Dispose confetti controller
    super.dispose();
  }

  // Load tasks from SharedPreferences
  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTasks = prefs.getStringList('todoList') ?? [];
    setState(() {
      todoList = savedTasks
          .map((task) => task.split('|'))
          .map((split) => [split[0], split[1] == 'true'])
          .toList();
    });
  }

  // Save tasks to SharedPreferences
  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksToSave =
        todoList.map((task) => '${task[0]}|${task[1]}').toList();
    await prefs.setStringList('todoList', tasksToSave);
  }

  // Toggle checkbox state
  void checkboxChanged(bool? value, int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
      if (todoList[index][1]) {
        _confettiController.play(); // Trigger confetti when task is completed
      }
    });
    _saveTasks();
  }

  // Save a new task
  void saveNewTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        todoList.add([_controller.text, false]);
        _controller.clear();
      });
      _saveTasks();
      Navigator.of(context).pop();
    }
  }

  void cancel() {
    Navigator.of(context).pop();
    _controller.clear();
  }

  // Create a new task dialog
  void createTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogueBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: cancel,
        );
      },
    );
  }

  // Delete a task
  void deleteTask(int index) {
    setState(() {
      todoList.removeAt(index);
    });
    _saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            backgroundColor: Colors.grey[850],
            centerTitle: true,
            title: Text(
              "My Todo List",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: createTask,
            child: const Icon(Icons.add, color: Colors.white),
            backgroundColor: Colors.black,
          ),
          body: ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              return TodoTile(
                taskName: todoList[index][0],
                taskCompleted: todoList[index][1],
                onChanged: (value) => checkboxChanged(value, index),
                deleteTask: (context) => deleteTask(index),
              );
            },
          ),
        ),
        // ConfettiWidget for celebratory animation
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            emissionFrequency: 1,
            numberOfParticles: 10,
          ),
        ),
      ],
    );
  }
}
