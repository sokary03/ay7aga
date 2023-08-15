import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../cubit/cubit.dart';


Widget LoginScreenButton({
  double width = double.infinity,
  Color color = Colors.blue,
  required String text,
  required Function() function,
}) => Container(
  width: width,
  color: color,
  child: MaterialButton(
    onPressed: function,
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
);



Widget loginTextFormField({

  required Function() validator,
  required Icon icon,
  required String text,
  required TextInputType keyboardType,
  required var Controller,


}) => TextFormField(
  validator: validator(),
  controller: Controller ,
  keyboardType: keyboardType,
  decoration: InputDecoration(
    labelText: text,
    border: OutlineInputBorder(),
    prefixIcon: icon,
  ),
);


Widget TasksLayout(Map model, context) => Dismissible(
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        CircleAvatar(

          radius: 40,

          child: Text("${model['date']}"),

        ),

        SizedBox(width: 20,),

        Expanded(

          child:   Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            mainAxisSize: MainAxisSize.min,

            children: [

              Text(

                "${model['title']}",

                style: TextStyle(

                  fontWeight: FontWeight.bold,

                  fontSize: 20,

                ),

              ),

              Text(

                "${model['time']}",

                style: TextStyle(

                  color: Colors.grey,

                  fontSize: 15,

                ),

              ),

            ],

          ),

        ),

        SizedBox(width: 20,),

        IconButton(

          onPressed: ()

          {

            Appcubit.get(context).updateDatabase(status: "done", id: model['id'],);

          },

          icon: Icon(Icons.check_circle_outline),

          color: Colors.green,

        ),

        SizedBox(width: 20,),

        IconButton(

          onPressed: ()

          {

            Appcubit.get(context).updateDatabase(status: "archived", id: model['id']);

          },

          icon: Icon(Icons.archive_outlined),

          color: Colors.red,

        ),



      ],

    ),

  ),
  key: Key(model['id'].toString()),
  onDismissed: (direction){
    Appcubit.get(context).deleteData(id: model['id']);
  },
);

Widget TaskBuilder({
  required List<Map> tasks,

}) => ConditionalBuilder(
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

void navigateTo(context,widget) => Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => widget,
    ),
);


