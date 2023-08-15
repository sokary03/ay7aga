import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_test/layout/news_app/cubit/cubit.dart';
import 'package:project_test/layout/news_app/cubit/states.dart';

import '../../../../components/components.dart';



class BusinessScreen extends StatelessWidget {





  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,NewsState>(
      listener: (context,state){},
      builder: (context,state) {

        var list = NewsCubit.get(context).business;
        return  articleBuilder(list,context);
      },

    );
  }

}
