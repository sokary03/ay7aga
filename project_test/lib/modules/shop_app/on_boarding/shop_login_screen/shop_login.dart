import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_test/components/components.dart';
import 'package:project_test/networks/local/cache_helper.dart';

import '../../../../components/constants.dart';
import '../../../../layout/shop_layout/shop_layout.dart';
import '../../../../shared/components/components.dart';
import '../register/register_screen.dart';
import '../shop_register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLoginScreen extends StatelessWidget {

  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginState>(
        listener: (context,state){
          if(state is ShopLoginSuccesState){
            if(state.loginModel.status == true){

              CacheHelper.setData(
                  key: 'token',
                  value: state.loginModel.data?.token,
              ).then((value){
                token = state.loginModel.data!.token;
                navigateTo(context, ShopLayout());
              });


            }
            else{

              showToast(
                msg: state.loginModel.message,
                state: ToastStates.WARNING,
              );
            }
          }
        },
        builder: (context,state) => Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: Column(
                children:
                [
                  Text(
                    'LOGIN',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    'login now to browse our hot offers',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'value is empty';
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                            Icons.visibility_off_outlined
                        ),
                        onPressed: (){},
                      ),
                      prefixIcon: Icon(
                        Icons.password,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'value is empty';
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ConditionalBuilder(
                    condition: state is !ShopLoginLoadingState,
                    fallback: (context) => Center(
                        child: CircularProgressIndicator(),
                    ),
                    builder: (BuildContext context) => LoginScreenButton(
                      text: 'LOGIN',
                      function: () {
                        if(formkey.currentState!.validate()){
                          ShopLoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                          );
                        }
                      },
                    ),

                 ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children:
                    [
                      Text(
                        'dont have an account ?',
                      ),
                      TextButton(
                        onPressed: (){
                          navigateTo(context, ShopRegisterScreen());
                        },
                        child: Text(
                          'REGISTER',
                        ),
                      ),
                    ],
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              key: formkey,
            ),
          ),
        ),
      ),
    );
  }
}
