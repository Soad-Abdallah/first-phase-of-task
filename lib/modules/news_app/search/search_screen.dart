import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fristapp/layout/news_app/cubit/cubit.dart';
import 'package:fristapp/layout/news_app/cubit/states.dart';
import 'package:fristapp/shared/component/component.dart';

class SearchScreen extends StatelessWidget {
  var SearchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state) {},
      builder: (context,state){
        List list = NewsCubit.get(context).Search;
        return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: defultFormField(
                onChange: (value){
                  NewsCubit.get(context).getSearch(value);
                },
                controller: SearchController, 
                type: TextInputType.text, 
                validate: (value){
                  if(value!.isEmpty){
                   return 'Sesrch Must\'t be Empty';
                  }
                  return null;
                }, 
                lable: 'Search', 
                prefix:Icons.search,
                ),
            ),
            Expanded(child: articleBuilder(list,isSearch: true)),
          ],
          ),
      );
      },
      
    );
  }
}