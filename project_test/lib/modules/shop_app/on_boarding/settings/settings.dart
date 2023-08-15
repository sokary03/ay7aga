import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_test/components/components.dart';

import '../../../../layout/shop_layout/cubit/cubit.dart';
import '../../../../layout/shop_layout/cubit/states.dart';
import '../../../../shared/components/components.dart';

class SettingsScreen extends StatelessWidget {


  var nameControler = TextEditingController();
  var emailControler = TextEditingController();
  var phoneControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopAppLayoutCubit,ShopLayOutState>(
      builder: (context,state) {

        var model = ShopAppLayoutCubit.get(context).userModel;
        var formKey = GlobalKey<FormState>();
        nameControler.text = model?.data?.name ?? 'd';
        emailControler.text = model!.data!.email;
        phoneControler.text = model!.data!.phone;

        return ConditionalBuilder(
          condition: ShopAppLayoutCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              child: Column(
                children: [
                  textFormFeildBuilder(
                    controler: nameControler,
                    type: TextInputType.name,
                    suffix: Icon(Icons.person),
                    label: 'NAME',
                  ),
                  textFormFeildBuilder(
                    controler: emailControler,
                    type: TextInputType.emailAddress,
                    suffix: Icon(Icons.email),
                    label: 'EMAIL',
                  ),
                  textFormFeildBuilder(
                    controler: phoneControler,
                    type: TextInputType.phone,
                    suffix: Icon(Icons.phone),
                    label: 'PHONE',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  LoginScreenButton(
                      text: 'SIGN OUT',
                      function: () {
                        signOut(context);
                      },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  LoginScreenButton(
                      text: 'UPDATE',
                      function: () {
                        if(formKey.currentState!.validate()){
                          ShopAppLayoutCubit.get(context).updateUserData(
                            name: nameControler.text,
                            phone: phoneControler.text,
                            email: emailControler.text,
                          );
                        }
                        else{print('not valid update');}

                      },
                  ),
                ],
              ),
              key: formKey,
            ),

          ),
          fallback: (context) => Center(child: CircularProgressIndicator(),),
        );
      },
      listener: (context,state) {},
    );
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




    ),
  );
}