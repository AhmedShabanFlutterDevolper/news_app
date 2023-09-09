import 'package:elnews/moudels/Scearch/Scearch.dart';
import 'package:elnews/shared/cubit/cubit.dart';
import 'package:elnews/shared/cubit/set.dart';
import 'package:elnews/shared/network/dioHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/componenets.dart';

class HomeNews extends StatefulWidget {
  const HomeNews({super.key});

  @override
  State<HomeNews> createState() => _HomeNewsState();
}

class _HomeNewsState extends State<HomeNews> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getBusiness(),
      child: BlocConsumer<NewsCubit, NewStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = NewsCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text('News App'),
                actions: [
                  IconButton(
                      onPressed: () {
                        NavigatorTo(context, SearchScrean());
                      },
                      icon: Icon(
                        Icons.search,
                      )),
                  IconButton(
                      onPressed: () {
                        NewsCubit.get(context).changeAppMode();
                      },
                      icon: Icon(
                        Icons.brightness_4_outlined,
                      )),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.CurrentIndex,
                onTap: (index) {
                  cubit.ChangeBottomNavBar(index);
                },
                items: cubit.bottomItems,
              ),
              body: cubit.screans[cubit.CurrentIndex],
            );
          }),
    );
  }
}
