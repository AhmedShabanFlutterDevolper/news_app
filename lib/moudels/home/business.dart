import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:elnews/shared/components/componenets.dart';
import 'package:elnews/shared/cubit/cubit.dart';
import 'package:elnews/shared/cubit/set.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class businessScrean extends StatelessWidget {
  const businessScrean({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var list = NewsCubit.get(context).business;
        return BuildArtical(list, context);
      },
    );
  }
}
