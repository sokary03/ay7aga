import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../layout/shop_layout/cubit/cubit.dart';
import '../../../../layout/shop_layout/cubit/states.dart';
import '../../../../models/shop_app/categories_model.dart';

class CategoriesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopAppLayoutCubit,ShopLayOutState>(
      builder: (context,state) => Scaffold(
        body: ListView.separated(
            itemBuilder: (context,index) => categorieItemBuilder(ShopAppLayoutCubit.get(context).categorieModel!.data!.data[index]),
            separatorBuilder: (context,index) => Container(
              height: 1,
              color: Colors.black,
            ),
            itemCount: ShopAppLayoutCubit.get(context).categorieModel!.data!.data.length,
            scrollDirection: Axis.vertical,
        ),
      ),
      listener: (context,state){},
    );
  }

  Widget categorieItemBuilder(CategoriesDataModel model,) => Padding(
    padding: const EdgeInsets.all(20),
    child: Row(
      children: [
        Image(
          image: NetworkImage(model.image!),
          width: 80,
          height: 80,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          model.name!,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(Icons.arrow_forward),
      ],
    ),
  );
}
