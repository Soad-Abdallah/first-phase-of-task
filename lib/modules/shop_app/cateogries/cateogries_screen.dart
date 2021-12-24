import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fristapp/layout/shop_app_layout/cubit/cubit.dart';
import 'package:fristapp/layout/shop_app_layout/cubit/states.dart';
import 'package:fristapp/model/shop_app/categories_model.dart';
import 'package:fristapp/shared/component/component.dart';

class cateogriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,State){
        return Scaffold(
          body: ListView.separated(itemBuilder: (context,index) => buildCatItem(ShopCubit.get(context).catecoriesModel!.data.data[index]), 
          separatorBuilder: (context,index) => MyDivider(), 
          itemCount: ShopCubit.get(context).catecoriesModel!.data.data.length,
        ),
      );
      },
    );
  }
}

Widget buildCatItem(DataModel model){
  return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage('${model.image}'), 
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: (){}, 
              icon: Icon(
                Icons.arrow_forward_ios
              ),
            ),
          ],
        ),
      );
}