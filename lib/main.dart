import 'package:flutter/material.dart';

import 'app/modules/home/views/home_view.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/shared/models/task.dart';

Future<void> main() async {
  // int hive
  await Hive.initFlutter();
  //init typeadpaters
  Hive.registerAdapter<Task>(TaskAdapter());

  //open hive box
  var box = await Hive.openBox<Task>('tasks');

  // automatically delete tasks from previous day
  box.values.forEach((task) {
    if (task.createdAt.day != DateTime.now().day) {
      box.delete(task.id);
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: const HomeView(),
    );
  }
}


// class BaseWidget extends InheritedWidget {
//   final HiveDataStore dataStore = HiveDataStore();
//   final Widget child;
//   BaseWidget({Key? key, required this.child}) : super(key: key, child: child);

//   static BaseWidget of(BuildContext context) {
//     final base = context.dependOnInheritedWidgetOfExactType<BaseWidget>();

//     if (base != null) {
//       return base;
//     } else {
//       throw StateError('Could not find ancestor of type BaseWidget');
//     }
//   }

//   @override
//   bool updateShouldNotify(BaseWidget oldWidget) {
//     return false;
//   }
// }