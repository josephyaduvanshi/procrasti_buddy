import 'package:flutter/material.dart';
import 'package:procrasti_buddy/controllers/homepage_controller.dart';
import 'package:procrasti_buddy/database/task_manager/task_manager.dart';
import 'package:procrasti_buddy/utils/utils.dart';
import 'package:procrasti_buddy/views/update_tasks.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../database/task_manager/task_service.dart';
import '../routes/route_names.dart';
import '../services/notifiers/home_page_notifier.dart';
import '../services/notifiers/theme_notifiers.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: ChangeNotifierProvider(
        create: (_) => HomePageNotifier(),
        child: Consumer(
          builder: (context, HomePageNotifier homePageNotifier, child) =>
              NavigationBar(
            elevation: 2,
            height: MediaQuery.of(context).size.height * 0.07,
            selectedIndex: homePageNotifier.currentNavigatonIndex,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            onDestinationSelected: homePageNotifier.changeIndex,
            destinations: homePageNotifier.navigationDestinations,
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 2,
        title: 'Procrasti Buddy'.text.bold.make(),
        actions: <Widget>[
          IconButton(
            icon: !isDark
                ? const Icon(Icons.lightbulb_outline)
                : const Icon(Icons.dark_mode_outlined),
            onPressed: () {
              final themeNotifier =
                  Provider.of<ThemeNotifier>(context, listen: false);
              themeNotifier.toggleTheme();
            },
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_active_outlined),
          ),
          PopupMenuButton(
            enableFeedback: true,
            icon: const Icon(Icons.more_vert_rounded),
            onSelected: (value) {
              Map<int, dynamic> pages = {
                1: () => Navigator.pushNamed(context, RouteNames.settingsPage),
                2: () => Navigator.pushNamed(context, RouteNames.aboutPage)
              };
              pages[value]();
            },
            elevation: 3,
            splashRadius: 10,
            position: PopupMenuPosition.under,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            itemBuilder: (context) => HomePageController.popUpMenuItems,
          ),
        ],
      ),
      body: ListView(shrinkWrap: true, children: [
        const SizedBox(height: 20),
        const Center(
          child: Text(
            'Welcome to Procrasti Buddy!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            final taskCRUDNotifer =
                Provider.of<TaskCRUDNotifer>(context, listen: false);
            taskCRUDNotifer.addTask(
                task: Task(
              id: Utilities.getRandomId(),
              taskName: 'Josef',
              taskDescription: 'OHLA  a hey',
              taskDueDate: DateTime.now(),
              taskPriority: 1,
              isCompleted: false,
            ));
            print(taskCRUDNotifer.tasks.map((e) => e.id));
          },
          child: const Text('Add Task'),
        ),
        ElevatedButton(
          onPressed: () async {
            final taskCRUDNotifer =
                Provider.of<TaskCRUDNotifer>(context, listen: false);
            await taskCRUDNotifer.deleteAll();
          },
          child: const Icon(Icons.delete),
        ),
        Consumer(
          builder: (context, TaskCRUDNotifer taskCRUDNotifer, child) =>
              ListView.builder(
            shrinkWrap: true,
            itemCount: taskCRUDNotifer.getAllTasks().length,
            itemBuilder: (context, index) {
              final tasks = taskCRUDNotifer.getAllTasks();
              return ListTile(
                title: Text('Task $index. ${tasks[index].taskName}'),
                subtitle: Text(tasks[index].taskDescription),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        taskCRUDNotifer.deleteTask(index: index);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                    IconButton(
                      onPressed: () {
                        print(tasks[index].id);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateTaskScreen(
                                      task: tasks[index],
                                      index: index,
                                    )));
                      },
                      icon: const Icon(Icons.edit_outlined),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const Center(
          child: Text(
            'This is the home page.',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ]),
    );
  }
}
