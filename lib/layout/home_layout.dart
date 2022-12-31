// ignore_for_file: avoid_print

import 'package:bmi/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:bmi/modules/done_tasks/done_tasks_screen.dart';
import 'package:bmi/modules/new_tasks/new_tasks_screen.dart';
import 'package:bmi/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  late Database database;
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
  void initState() {
    // TODO: implement initState
    super.initState();
    createDatabase();
  }

  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  bool isBottonSheetShown = false;
  IconData fabIcon = Icons.edit;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  List<Map> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        title: Text(
          titles[currentIndex],
        ),
      ),
      body: screen[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          if (isBottonSheetShown) {
            if (formkey.currentState!.validate()){

              insertToDatabase
                (
                  title:titleController.text,
                  date:dateController.text,
                  time:timeController.text,

              ).then((value)
              {
                Navigator.pop(context);
                isBottonSheetShown = false;
                setState(() {
                  fabIcon = Icons.edit;
              });
              });
            }
          }else {
            scaffoldkey.currentState?.showBottomSheet(
                  (context) => Container(
                    color: Colors.grey[100],
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          defaultFormField(
                              controller: titleController,
                              type: TextInputType.text,
                              validate: (String value){
                                if(value.isEmpty)
                                {
                                  return 'Title must not be empty';
                                }
                                return null;

                              },
                              label: 'Task Title',
                              prefix: Icons.title,
                          ),
                          const SizedBox(height: 15.0,),
                          defaultFormField(
                            controller: timeController,
                            type: TextInputType.datetime,
                            onTap: (){
                              showTimePicker(context: context, initialTime: TimeOfDay.now()
                              ).then((value) {
                                timeController.text = value!.format(context).toString();
                                print(value.format(context));
                              });
                            },
                            validate: (String value){
                              if(value.isEmpty)
                              {
                                return 'Time must not be empty';
                              }
                              return null;

                            },
                            label: 'Task Time',
                            prefix: Icons.watch_later_outlined,
                          ),
                          const SizedBox(height: 15.0,),
                          defaultFormField(
                            controller: dateController,
                            type: TextInputType.datetime,
                            onTap: ()
                            {
                              showDatePicker(context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2023-12-31')
                              ).then((value) {
                                // dateController.text =
                                //     value!.format(context).toString();
                                // print(value.format(context));
                                dateController.text = DateFormat.yMMMd().format(value as DateTime);
                              });
                            },
                            validate: (String value){
                              if(value.isEmpty)
                              {
                                return 'Date must not be empty';
                              }
                              return null;

                            },
                            label: 'Task date',
                            prefix: Icons.calendar_month_outlined,
                          )
                        ],
                      ),
                    ),
                  ),
            ).closed.then((value) {
              isBottonSheetShown = false;
              setState(() {
                fabIcon = Icons.edit;
              });
            });
            isBottonSheetShown = true;
            setState(() {
              fabIcon = Icons.add;
            });
          }
        },
        child:  Icon(
          fabIcon,
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

  Future<String> getName() async {
    return 'Peter Maged';
  }

  void createDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT,time TEXT, status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('i did error in creating table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database).then((value)
        {
          tasks = value;
          print(tasks);

        });
        print('database opened');
      },
    );
  }
  Future insertToDatabase(
      {required String title,
        required String time,
        required String date}) async {
    return await database.transaction((txn) {
      return txn
          .rawInsert(
          'INSERT INTO tasks (title , date , time , status) VALUES ("$title", "$date", "$time", "new")')
          .then((value) {
        print('$value inserted successfully');
      }).catchError((error) {
        print('Error When Inserting  new Records ${error.toString()}');
      });
    });
  }
  // Future insertToDatabase(
  //     {
  //       required String title,
  //       required String time,
  //       required String date
  //     }
  //     )  async {
  //    return await database.transaction((txn) {
  //     txn
  //         .rawInsert(
  //             'INSERT INTO tasks (title , date , time , status) VALUES ("$title", "$date", "$time", "new")')
  //         .then((value) {
  //       print('$value inserted successfully');
  //     }).catchError((error) {
  //       print('Error When Inserting  new Records ${error.toString()}');
  //     });
  //     //throw Exception('Result unexpectedly null');
  //     // print(null!);
  //     // ignore: null_check_always_fails
  //      return insertToDatabase(title: title, time: time, date: date);
  //   });
  // }
  Future<List<Map>> getDataFromDatabase (database)   async {
    return await database.query('tasks');
  }
}
