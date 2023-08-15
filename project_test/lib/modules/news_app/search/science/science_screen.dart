import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/components.dart';
import '../../../../layout/news_app/cubit/cubit.dart';
import '../../../../layout/news_app/cubit/states.dart';



class ScienceScreen extends StatelessWidget {



  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit,NewsState>(
      listener: (context,state){},
      builder: (context,state) {

        var list = NewsCubit.get(context).Science;
        return articleBuilder(list,context);
      },

    );
  }

}
