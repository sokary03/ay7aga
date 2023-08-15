import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_test/shared/components/components.dart';
import 'package:project_test/shared/cubit/cubit.dart';
import 'package:project_test/shared/cubit/states.dart';

class ArchivedTasks extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit,Appstates>(
      listener: (context,state){},
      builder: (context,state){
        var tasks = Appcubit.get(context).archivedTasks;
        return TaskBuilder(tasks: tasks);
      },
    );
  }

}
