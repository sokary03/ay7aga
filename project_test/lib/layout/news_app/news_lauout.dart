import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_test/shared/components/components.dart';
import 'package:project_test/shared/cubit/cubit.dart';


import '../../modules/news_app/search/search_screen.dart';
import '../../networks/remote/dio_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class NewsLayout extends StatelessWidget {



  Widget build(BuildContext context) {


    return BlocConsumer<NewsCubit,NewsState>(
      listener:(context,state){} ,
      builder:(context,state){
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("NewsApp"),
            actions: [
              IconButton(
                onPressed: ()
                {
                  navigateTo(context, SearcScreen());

                },
                icon: Icon(
                    Icons.search
                ),

              ),
              IconButton(
                onPressed: ()
                {
                  Appcubit.get(context).ChangeThemeMode();
                },
                icon: Icon(
                    Icons.brightness_4_outlined
                ),

              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: ()
            {

            },
            child: Icon(Icons.add),
          ),
          bottomNavigationBar: BottomNavigationBar(

            items: cubit.nav_bar_items,
            currentIndex: cubit.current_screen_index,
            onTap: (index)
            {
              if(index==1){
                cubit.getSports();
              }else if(index==2) {
                cubit.getscience();
              }
              cubit.bottom_nav_bar_changed(index);
            },


          ),
          body: cubit.screens_list[cubit.current_screen_index],
        );
      } ,
    );
  }
}

