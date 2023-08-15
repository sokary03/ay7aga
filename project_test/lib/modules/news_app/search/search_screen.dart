import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_test/components/components.dart';
import 'package:project_test/layout/news_app/cubit/cubit.dart';
import 'package:project_test/layout/news_app/cubit/states.dart';

class SearcScreen extends StatelessWidget {


  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit,NewsState>(
      listener: (context,state){},
      builder: (context,state){
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children:
            [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'search is empty';
                    }
                    return null;
                  },
                  onChanged: (value){
                    NewsCubit.get(context).getSearch(value);
                  },
                ),
              ),
              Expanded(child: articleBuilder(list, context)),

            ],
          ),
        );
      },
    );
  }
}
