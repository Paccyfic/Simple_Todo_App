import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 31, 35), // Set background to black
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
                  Text(
                    'Tap + to add your tasks',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                final task = taskProvider.tasks[index];
                return Dismissible(
                  key: Key(task.title),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(
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
                  child: ListTile(
                    title: Text(
                      task.title,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      task.description,
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: Checkbox(
                      value: task.isCompleted,
                      onChanged: (value) {
                        taskProvider.toggleComplete(task);
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF7B8AE0), // Match button color to the screenshot
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
