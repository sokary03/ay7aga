

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_test/components/components.dart';
import 'package:project_test/models/shop_app/home_model.dart';
import 'package:project_test/styles/colors.dart';

import '../../../../layout/shop_layout/cubit/cubit.dart';
import '../../../../layout/shop_layout/cubit/states.dart';
import '../../../../models/shop_app/categories_model.dart';

class ProductsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopAppLayoutCubit,ShopLayOutState>(
      listener: (context,state){
        if(state is ShopSuccessChangeFavoriteState){
          if(state.fav?.status == false){
            showToast(msg: state.fav?.message, state: ToastStates.ERROR,);
          }
        }
        else{

        }
      },
      builder: (context,state){
        return ConditionalBuilder(
            condition: ShopAppLayoutCubit.get(context).homeModel != null && ShopAppLayoutCubit.get(context).categorieModel != null,
            builder: (context) => homeBuilder(ShopAppLayoutCubit.get(context).homeModel,ShopAppLayoutCubit.get(context).categorieModel,context),
            fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },

    );
  }

  Widget homeBuilder(HomeModel? model,CategoriesModel? categorie_model,context){

    int products_items_length = model?.data!.products.length ?? 2;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model?.data?.banners.map((e) => Image(
              image:  NetworkImage('${e.image}'),
              width: double.infinity,
              fit: BoxFit.cover,
            )).toList(),
            options: CarouselOptions(
              viewportFraction: 1.0,
              height: 250,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(
                seconds: 3,
              ),
              autoPlayAnimationDuration: Duration(
                seconds: 1,
              ),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Text(
                  'CATEGORIES',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index) => buildCategorieItem(categorie_model.data!.data[index]),
                      separatorBuilder: (context,index) => SizedBox(
                        width: 10,
                      ),
                      itemCount: categorie_model!.data!.data.length,
                  ),
                  height: 100,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'NEW PRODUCTS',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(
                    products_items_length,
                    (index) => buildGridProduct(model?.data?.products[index],context),
              ),
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.6,
            ),
            color: Colors.grey[300],
          ),

        ],
      ),
      physics: BouncingScrollPhysics(),
    );
  }
  Widget buildGridProduct(product_item,context){

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image(
                image: NetworkImage(product_item.image),
                width: double.infinity,
                height: 200,
              ),
              if(product_item.discount != 0)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                color: Colors.red,
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                ),
              ),
            ],
            alignment: AlignmentDirectional.bottomStart,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  product_item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    height: 1.3,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${product_item.price.round()}',
                      style: TextStyle(
                        fontSize: 12,
                        color: defaultcolor,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if(product_item.discount != 0)
                    Text(
                      '${product_item.old_price.round()}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: (){
                          ShopAppLayoutCubit.get(context).changeFavorite(product_item.id);
                        },
                        icon: CircleAvatar(
                          radius: 15,
                          child: Icon(
                            Icons.favorite_border,
                            size: 15,
                            color: Colors.white,
                          ),
                          backgroundColor: ShopAppLayoutCubit.get(context).favorites[product_item.id] == true ? Colors.orange : Colors.grey,
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
      color: Colors.white,
    );

  }
  Widget buildCategorieItem(CategoriesDataModel model) => Container(
    child: Stack(
      children: [
        Image(
          image: NetworkImage(model.image!),
          height: 100,
          width: 100,
        ),
        Container(
          child: Text(
            model.name!,
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          color: Colors.black.withOpacity(0.8),
          width: double.infinity,
        ),
      ],
      alignment: Alignment.bottomCenter,
    ),
    width: 100,
    height: 100,
  );
}
//https://student.valuxapps.com/storage/uploads/categories/16893929290QVM1.modern-devices-isometric-icons-collection-with-sixteen-isolated-images-computers-periphereals-variou.jpeg'