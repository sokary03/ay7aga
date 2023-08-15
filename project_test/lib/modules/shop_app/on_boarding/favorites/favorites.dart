import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_test/models/shop_app/favorites_model_item.dart';

import '../../../../layout/shop_layout/cubit/cubit.dart';
import '../../../../layout/shop_layout/cubit/states.dart';
import '../../../../styles/colors.dart';

class FavoritesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<ShopAppLayoutCubit,ShopLayOutState>(
      builder: (context,state) {
        List<FavoritesData> d;
        FavoritesData s = FavoritesData.nell(1, 1, 1, 1, '1', '1', '1', 1);
        return  Scaffold(
          body: ConditionalBuilder(
            condition: state is !ShopLoadingGetFavoriteState,
            builder: (context) => ListView.separated(
              itemBuilder: (context,index) => buildFavoriteItem(ShopAppLayoutCubit.get(context).favoritemodel?.data!.data![index] ?? s ,context),
              separatorBuilder: (context,index) => Container(
                height: 1,
                color: Colors.black,
              ),
              itemCount: ShopAppLayoutCubit.get(context).favoritemodel?.data!.data!.length ?? 1,
              scrollDirection: Axis.vertical,
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
      listener: (context,state){},
    );
  }
  Widget buildFavoriteItem(FavoritesData? data, context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image(
                image: NetworkImage(data!.product!.image!),
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
              if(data!.product!.discount != 0)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  color: Colors.red,
                  child: Text(
                    '${data!.product!.discount}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                  ),
                ),
            ],
            alignment: AlignmentDirectional.bottomStart,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  data!.product!.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    height: 1.3,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${data!.product!.price}',
                      style: TextStyle(
                        fontSize: 12,
                        color: defaultcolor,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if(data!.product!.discount != 0)
                      Text(
                        '${data!.product!.oldPrice}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: (){
                        ShopAppLayoutCubit.get(context).changeFavorite(data.product!.id!);
                      },
                      icon: CircleAvatar(
                          radius: 15,
                          child: Icon(
                            Icons.favorite_border,
                            size: 15,
                            color: Colors.white,
                          ),
                          backgroundColor: ShopAppLayoutCubit.get(context).favorites[data.product?.id] == true ? Colors.orange : Colors.grey,
                      ),
                    ),

                  ],
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),


        ],
      ),
      height: 120,
    ),
  );
}