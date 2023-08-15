import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_test/components/components.dart';
import 'package:project_test/networks/local/cache_helper.dart';
import 'package:project_test/shared/components/components.dart';

import '../../modules/shop_app/on_boarding/search/search.dart';
import '../../modules/shop_app/on_boarding/shop_login_screen/shop_login.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopAppLayoutCubit,ShopLayOutState>(
      listener: (context,state) {},
      builder: (context,state) {
        ShopAppLayoutCubit cubit = ShopAppLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'SALLA',
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search),
              ),
            ],
          ),
          body: cubit.bottomScreenes[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                label: 'HOME'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                label: 'CATEGORIES'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                label: 'FAVORITES'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                label: 'SETTINGS'
              ),
            ],
            onTap: (index){
              cubit.ChangeBottomIndex(index);
            },
            currentIndex: cubit.currentIndex,
          ),

        );
      },
    );
  }
}
