import 'package:elnews/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/componenets.dart';
import '../../shared/cubit/set.dart';

class SearchScrean extends StatelessWidget {
  var SearchControlar = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewStates>(
        listener: (context, states) {},
        builder: (context, states) {
          var list = NewsCubit.get(context).search;

          return Scaffold(
              body: SafeArea(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      cursorColor: Colors.amber,
                      keyboardType: TextInputType.text,
                      controller: SearchControlar,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Search must is not be empty';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        NewsCubit.get(context).getSearch(value);
                      },
                      decoration: InputDecoration(
                          prefixIcon: IconButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                print(SearchControlar.text);
                              }
                            },
                            icon: Icon(Icons.search),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              SearchControlar.clear();
                            },
                            icon: Icon(Icons.clear),
                          ),
                          labelText: 'Search',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  ),
                  Expanded(child: BuildArtical(list, context))
                ],
              ),
            ),
          ));
        });
  }
}
