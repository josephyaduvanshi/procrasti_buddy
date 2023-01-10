import 'package:flutter/material.dart';
import 'package:procrasti_buddy/database/task_manager/task_manager.dart';
import 'package:provider/provider.dart';

import '../database/task_manager/task_service.dart';

class UpdateTaskScreen extends StatefulWidget {
  final Task task;
  final int index;

  const UpdateTaskScreen({required this.task, required this.index});

  @override
  _UpdateTaskScreenState createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form fields to update task properties
  String? _updatedTaskName;
  String? _updatedTaskDescription;
  DateTime? _updatedTaskDueDate;
  int? _updatedTaskPriority;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Task'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: widget.task.taskName,
                decoration: const InputDecoration(labelText: 'Task Name'),
                onSaved: (value) => _updatedTaskName = value!,
              ),
              TextFormField(
                initialValue: widget.task.taskDescription,
                decoration:
                    const InputDecoration(labelText: 'Task Description'),
                onSaved: (value) => _updatedTaskDescription = value!,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitForm,
        child: const Icon(Icons.save),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.task.id != null) {
        print('Task id: ${widget.task.id}');
        final task = Task(
          id: widget.task.id,
          taskName: _updatedTaskName ?? 'N/A',
          taskDescription: _updatedTaskDescription ?? 'N/A',
          taskDueDate: _updatedTaskDueDate ?? DateTime.now(),
          taskPriority: _updatedTaskPriority ?? 0,
        );
        if (widget.task != task) {
          final taskNotifer =
              Provider.of<TaskCRUDNotifer>(context, listen: false);
          taskNotifer.updateTask(task: task, index:widget.index);
          print(task.id);
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No changes made'),
            ),
          );
        }
      }

      // Update task in database

    }
  }
}
