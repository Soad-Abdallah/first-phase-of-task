import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fristapp/layout/shop_app_layout/cubit/states.dart';
import 'package:fristapp/model/shop_app/categories_model.dart';
import 'package:fristapp/model/shop_app/favorites_model.dart';
import 'package:fristapp/model/shop_app/home_model.dart';
import 'package:fristapp/modules/shop_app/cateogries/cateogries_screen.dart';
import 'package:fristapp/modules/shop_app/favorites/favorites_screen.dart';
import 'package:fristapp/modules/shop_app/products/products_screen.dart';
import 'package:fristapp/modules/shop_app/setting/setting_screen.dart';
import 'package:fristapp/shared/component/constants.dart';
import 'package:fristapp/shared/cubit/states.dart';
import 'package:fristapp/shared/network/end_points.dart';
import 'package:fristapp/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super(ShopIntialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  
  int currentIndex = 0;
  List<Widget> bottomScreens = [
     productsScreen(),
     cateogriesScreen(),
     favorritesScreen(),
     SettingScreen(),
  ]; 
  
  void changBottom( int index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  Map<int,bool> favorite = {};
  late HomeModel? homeModel = null;
  void getHomeData()
  {
    print(homeModel);
    emit(ShopHomeLoadingState());
    DioHelper.getdata(
      url: HOME,
      token: token,).then((value){
      homeModel = HomeModel.fromJson(value.data);
      //print(homeModel!.data.banners[0].image.toString());
      homeModel!.data.products.forEach((element){
        favorite.addAll({
          element.id : element.inFavorites
        });
      });
      print(favorite.toString());
      emit(ShopHomeSuccessState());
    }).catchError((Error){
      print(Error.toString());
      emit(ShopHomeErrorState());
    });
  }

 late CategoriesModel? catecoriesModel = null;
 void getCatecoriesData(){
    print(homeModel);
    emit(ShopHomeLoadingState());
    DioHelper.getdata(
      url: GET_CATEGORIES,
      ).then((value){
      catecoriesModel = CategoriesModel.fromJson(value.data);
      print(catecoriesModel!.data.current_page);
      emit(ShopCategoriesSuccessState());
    }).catchError((Error){
      print(Error.toString());
      emit(ShopCategoriesErrorState());
    });
  }


  late ChangeFavoritesModel changeFavoritesModel;
  void ChangeFavorites (int ProductId){
    if(favorite[ProductId] == true){
      favorite[ProductId] = false;
    }else{
      favorite[ProductId] = true;
    }
    emit(ShopChangeFavoriteState());
    DioHelper.postData(
      url: FAVORITES, 
      data: {
        'product_id':ProductId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if(!changeFavoritesModel.status)
      {
        if(favorite[ProductId] == true){
          favorite[ProductId] = false;
        }else{
          favorite[ProductId] = true;
        }
      }
      emit(ShopChangeFavoritesSuccessState(changeFavoritesModel));
    }
    ).catchError((Error){
      if(favorite[ProductId] == true){
      favorite[ProductId] = false;
    }else{
      favorite[ProductId] = true;
    }
      emit(ShopChangeFavoritesErrorState());
    });
  }
}

