import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project_test/shared/cubit/cubit.dart';
import 'package:project_test/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';





class HomeLayout extends StatelessWidget {


  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Appcubit()..createDatabase(),
      child: BlocConsumer<Appcubit, Appstates>(
        listener: (context, state) {
          if (state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          Appcubit cubit = Appcubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.Titles[cubit.currentIndex]),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async
              {
                if (cubit.isBottomSheetShown) {
                  cubit.changeBottomSheetState(isShow: false, icon: Icon(Icons.edit));
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(name: titleController.text, time: timeController.text, date: dateController.text);
                  }
                }


                else {
                  scaffoldKey.currentState?.showBottomSheet(
                        (context) =>
                        Container(
                          color: Colors.grey[100],
                          padding: EdgeInsets.all(20),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.title),
                                      labelText: "Task Title"
                                  ),
                                  controller: titleController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return ("title must not be empty");
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 15,),
                                TextFormField(
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text =
                                          value!.format(context).toString();
                                    });
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(
                                          Icons.timelapse_outlined),
                                      labelText: "Task Time"
                                  ),
                                  controller: timeController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return ("Time must not be empty");
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 15,),
                                TextFormField(
                                  onTap: () {
                                    showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse('2023-10-30')
                                    ).then((value) {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(
                                          Icons.calendar_month_outlined),
                                      labelText: "Task Date"
                                  ),
                                  controller: dateController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return ("Date must not be empty");
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                    elevation: 20.0,
                  )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(isShow: false, icon: Icon(Icons.edit));


                  });
                  cubit.changeBottomSheetState(isShow: true, icon: Icon(Icons.add));
                }
              },
              child: cubit.floatingactionIcon,
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.ChangeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.task,
                    ),
                    label: "Tasks"
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.check_circle_outline,
                    ),
                    label: "Done"
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.archive_outlined,
                    ),
                    label: "Archived"
                ),
              ],
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) => cubit.Screens[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}








