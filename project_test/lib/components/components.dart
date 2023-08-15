import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_test/modules/news_app/search/web_view/webview_screene.dart';
import 'package:project_test/modules/shop_app/on_boarding/search/cubit/cubit.dart';
import 'package:project_test/shared/components/components.dart';

import '../modules/shop_app/on_boarding/shop_login_screen/shop_login.dart';
import '../networks/local/cache_helper.dart';

Widget ArticleItemBuilder(item,context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(item['url']));
  },
  child: Padding(
  
    padding: const EdgeInsets.all(8.0),
  
    child:  Row(

      children:
  
      [
  
        Container(
  
          width: 120,
  
          height: 120,
  
          decoration: BoxDecoration(
  
            borderRadius: BorderRadius.circular(20),
  
            image: DecorationImage(
  
              image: NetworkImage('https://img.freepik.com/free-photo/purple-osteospermum-daisy-flower_1373-16.jpg?w=2000'),
  
              fit: BoxFit.cover,
  
            ),
  
          ),
  
        ),
  
        SizedBox(
  
          width: 10,
  
        ),
  
        Expanded(
  
          child: Container(
  
            child: Column(
  
              children:
  
              [
  
                Expanded(
  
                  child: Text(
  
                    '${item['title']}',
  
                    style: Theme.of(context).textTheme.bodyText1,
  
                    maxLines: 3,
  
                    overflow: TextOverflow.ellipsis,
  
                  ),
  
                ),
  
                Text(
  
                  '${item['publishedAt']}',
  
                  style: TextStyle(
  
                    color: Colors.grey,
  
                  ),
  
                ),
  
              ],
  
              crossAxisAlignment: CrossAxisAlignment.start,
  
            ),
  
            height: 120,
  
          ),
  
        ),
  
      ],
  
    ),
  
  ),
);

Widget myDivider() => Padding(
  padding: const EdgeInsets.all(20),
  child: Container(
    height: 1,
    color: Colors.black,
  ),
);

Widget articleBuilder(list,context) => ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
      physics: BouncingScrollPhysics(),
      separatorBuilder: (context,index) => myDivider(),
      itemBuilder: (context,index) => ArticleItemBuilder(list[index],context),
      itemCount: list.length,

    ),
    fallback: (context) => Center(child: CircularProgressIndicator()));

void showToast({
  required String? msg,
  required ToastStates state,
}) => Fluttertoast.showToast(
    msg: msg!,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates {SUCCES,ERROR,WARNING}

Color chooseColor(ToastStates state){
  late Color color;
  switch(state)
      {
    case ToastStates.SUCCES:
      color = Colors.green;
          break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

void signOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
    navigateTo(context, ShopLoginScreen());

  });
}

Widget textFormFeildBuilder({controler,type,suffix,prefix,label}) => Padding(
  padding: const EdgeInsets.all(10.0),
  child: TextFormField(
    controller: controler,
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        borderSide: BorderSide(
          width: 4,
          color: Colors.black,
        ),
      ),
      suffixIcon: suffix,
      labelText: label,
      prefixIcon: prefix,
    ),
    keyboardType: type,
    validator: (String? value){
      if(value!.isEmpty){
        return 'value is empty';
      }
    },
    onFieldSubmitted: (String text){

    },




  ),
);
