// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../models/task.dart';
// import '../providers/task_provider.dart';

// class AddTaskScreen extends StatelessWidget {
//   final _titleController = TextEditingController();
//   final _descriptionController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Task'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _titleController,
//               decoration: InputDecoration(labelText: 'Title'),
//             ),
//             TextField(
//               controller: _descriptionController,
//               decoration: InputDecoration(labelText: 'Description'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 if (_titleController.text.isNotEmpty &&
//                     _descriptionController.text.isNotEmpty) {
//                   final task = Task(
//                     title: _titleController.text,
//                     description: _descriptionController.text,
//                   );
//                   Provider.of<TaskProvider>(context, listen: false)
//                       .addTask(task);
//                   Navigator.of(context).pop();
//                 }
//               },
//               child: Text('Add Task'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
