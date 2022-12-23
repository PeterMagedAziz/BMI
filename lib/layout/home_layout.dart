import 'package:bmi/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:bmi/modules/done_tasks/done_tasks_screen.dart';
import 'package:bmi/modules/new_tasks/new_tasks_screen.dart';
import 'package:flutter/material.dart';

class HomeLayout extends StatefulWidget {
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  List<Widget> screen = [
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[currentIndex],
        ),
      ),
      body: screen[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: ('Tasks'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: ('Done'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined),
            label: ('Archive'),
          ),
        ],
      ),
    );
  }
}
