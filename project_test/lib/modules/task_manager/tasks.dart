import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_test/shared/components/components.dart';
import 'package:project_test/shared/cubit/cubit.dart';
import 'package:project_test/shared/cubit/states.dart';


class NewTasksScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit,Appstates>(
      listener: (context,state){},
      builder: (context,state){
        var tasks = Appcubit.get(context).newTasks;
        return ConditionalBuilder(
            condition: tasks.length>0,
            builder: (congext) =>ListView.separated(
              itemBuilder: (context,index)=> TasksLayout(tasks[index],context),
              separatorBuilder:(context,index) => Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
              itemCount: tasks.length,
            ),
            fallback: (context) =>Center(
              child: Column(
                children:
                [
                  Icon(Icons.menu),
                  Text('please put dtabase'),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
        );
      },
    );
  }
}
