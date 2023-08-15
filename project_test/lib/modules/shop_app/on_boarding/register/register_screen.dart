import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/components.dart';
import '../../../../components/constants.dart';
import '../../../../layout/shop_layout/shop_layout.dart';
import '../../../../networks/local/cache_helper.dart';
import '../../../../shared/components/components.dart';
import '../shop_login_screen/cubit/cubit.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopRegisterScreen extends StatelessWidget {

  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterState>(
          listener: (context,state){
            if(state is ShopRegisterSuccesState){
              print('laalalalalalalalalalallalalalalaa');
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
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      child: Column(
                        children:
                        [
                          Text(
                            'REGISTER',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Text(
                            'register now to browse our hot offers',
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: nameController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
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
                            keyboardType: TextInputType.phone,
                            controller: phoneController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.phone,
                                ),
                                onPressed: (){},
                              ),
                              prefixIcon: Icon(
                                Icons.phone,
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
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                    Icons.email
                                ),
                                onPressed: (){},
                              ),
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
                            condition: state is !ShopRegisterLoadingState,
                            fallback: (context) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            builder: (BuildContext context) => LoginScreenButton(
                              text: 'REGISTER',
                              function: () {
                                print(emailController.text);
                                print(passwordController.text);
                                print(nameController.text);
                                print(phoneController.text);
                                if(formkey.currentState!.validate()){
                                  ShopRegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                            ),

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
      ),
    );

  }
}
