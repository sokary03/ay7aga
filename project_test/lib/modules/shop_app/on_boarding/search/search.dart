import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_test/components/components.dart';
import 'package:project_test/layout/shop_layout/shop_layout.dart';
import 'package:project_test/modules/shop_app/on_boarding/search/cubit/cubit.dart';
import 'package:project_test/modules/shop_app/on_boarding/shop_login_screen/cubit/cubit.dart';

import 'cubit/states.dart';

class SearchScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchState>(
        listener: (context,state){},
        builder: (context,state){
          var s = SearchCubit.get(context);
          return Scaffold(
          appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(
                            width: 4,
                            color: Colors.black,
                          ),
                        ),
                        suffixIcon: Icon(Icons.search),
                        labelText: 'search',
                      ),
                      validator: (String? value){
                        if(value!.isEmpty){
                          return 'value is empty';
                        }
                      },
                      onFieldSubmitted: (String text){
                        SearchCubit.r.search(text);
                      },
                    ),
                  ),
                ],
              ),
            ),

    );
        },
      ),
    );
  }
}