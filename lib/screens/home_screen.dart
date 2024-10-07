import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class HomeScreen extends StatelessWidget {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    Widget _buildTaskTile(Task task, TaskProvider taskProvider) {
      return Dismissible(
        key: Key(task.title),
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerLeft,
          padding:const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) {
          taskProvider.deleteTask(task);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${task.title} deleted')),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Checkbox(
                value: task.isCompleted,
                onChanged: (value) {
                  taskProvider.toggleComplete(task);
                },
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      task.description,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    void _showAddTaskForm(BuildContext context) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.grey[800],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (_) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add Task',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[800],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[800],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.send, color: Colors.blue),
                      onPressed: () {
                        if (_titleController.text.isNotEmpty &&
                            _descriptionController.text.isNotEmpty) {
                          final task = Task(
                            title: _titleController.text,
                            description: _descriptionController.text,
                          );
                          taskProvider.addTask(task);
                          Navigator.of(context).pop();
                          _titleController.clear();
                          _descriptionController.clear();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    Widget _buildTaskList() {
      final todoTasks = taskProvider.tasks.where((task) => !task.isCompleted).toList();
      final completedTasks = taskProvider.tasks.where((task) => task.isCompleted).toList();

      return ListView(
        padding: EdgeInsets.all(16),
       
        children: [
          SizedBox(height: 20),   
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for your task...',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[850],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 10),
          Text('Todo', style: TextStyle(color: Colors.grey, fontSize: 18)),
          SizedBox(height: 10),
          ...todoTasks.map((task) => _buildTaskTile(task, taskProvider)).toList(),
          SizedBox(height: 20),
          Text('Completed', style: TextStyle(color: Colors.grey, fontSize: 18)),
          SizedBox(height: 10),
          ...completedTasks.map((task) => _buildTaskTile(task, taskProvider)).toList(),
        ],
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 20, 22),
      body: taskProvider.tasks.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/empty-list.png',
                    height: 200,
                    width: 200,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'What do you want to do today?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    'Tap + to add your tasks',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          : _buildTaskList(),
      floatingActionButton: FloatingActionButton(
       shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(30),
       ),
        backgroundColor: const Color(0xFF7B8AE0),
        onPressed: () => _showAddTaskForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
