//import 'dart:js';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fristapp/layout/shop_app_layout/cubit/cubit.dart';
import 'package:fristapp/layout/shop_app_layout/cubit/states.dart';
import 'package:fristapp/model/shop_app/categories_model.dart';
import 'package:fristapp/model/shop_app/home_model.dart';
import 'package:fristapp/shared/component/component.dart';
import 'package:fristapp/shared/component/constants.dart';

class productsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is ShopChangeFavoritesSuccessState){
          if(!state.model.status)
          {
            showToast(
              msg: state.model.message, 
              state: toastStates.ERROR
              );
          }else{
            showToast(
              msg: state.model.message, 
              state: toastStates.SUCCESS
              );

          }
        }
      },
      builder: (context,state){
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).catecoriesModel != null, 
          builder: (context) => ProductsBuilder(
            ShopCubit.get(context).homeModel,
            ShopCubit.get(context).catecoriesModel,
            context),
          fallback: (context) => Center(
            child: CircularProgressIndicator()),
            );
      },
    ); 
  }
  Widget ProductsBuilder(HomeModel? model , CategoriesModel? categoriesModel ,context){
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model!.data.banners.map((e) => Image(
              image: NetworkImage('${e.image}',
              ),
              width: double.infinity,
              fit: BoxFit.cover,
              ),
            ).toList(), 
            options: CarouselOptions(
              viewportFraction: 1,
              height: 200,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
            ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index) => buildCategoriesItem(categoriesModel!.data.data[index]), 
                    separatorBuilder: (context , index) => SizedBox(
                    width: 10.0,
                  ),
                    itemCount: categoriesModel!.data.data.length,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'News Product',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1/1.64,
              children: 
                List.generate(
                  model.data.products.length, 
                  (index) => biuldGridProductItem(model.data.products[index],context),
                ),
              
              ),
          ),
        ],
      ),
    );
  }

  Widget biuldGridProductItem(ProductModel model , context){
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image),
                width: double.infinity,
                height: 200,
              ),
              if(model.oldPrice != model.price)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.white, 
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment : CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    height: 1.3, 
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      style: TextStyle(
                        color: defultColor, 
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    if(model.oldPrice != model.price)
                    Text(
                  '${model.oldPrice}',
                  style: TextStyle(
                    color: Colors.grey, 
                    decoration: TextDecoration.lineThrough,
                  ), 
                ),
                    Spacer(),
                    IconButton(
                      onPressed: (){
                        ShopCubit.get(context).ChangeFavorites(model.id);
                       //print('${ShopCubit.get(context).favorite[model.id]}'); 
                      }, 
                      icon: Icon(
                        Icons.favorite_rounded,
                        color: ShopCubit.get(context).favorite[model.id]! ? Colors.red : Colors.grey,
                        ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget buildCategoriesItem(DataModel model){
    return Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                height: 100,
                width: 100,
                fit: BoxFit.cover, 
              ),
              Container(
                width: 100,
                color: Colors.black.withOpacity(0.7,),
                child: Text(
                  model.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style : TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );    
  }
}
