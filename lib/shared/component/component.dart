//import 'dart:html';

import 'dart:io';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fristapp/modules/basics/login/login_screen.dart';
import 'package:fristapp/modules/news_app/web_view/web_view_screen.dart';
import 'package:fristapp/shared/cubit/cubit.dart';
import 'package:fristapp/shared/cubit/states.dart';
import 'package:fristapp/shared/network/local/cache_helper.dart';
import 'package:fristapp/shared/styles/icon_broken.dart';

Widget defulteButton ({
  background =Colors.blue, 
  width = double.infinity,
  bool isUpperCase = true,
  double radius = 20.0,
  required Function function,
  required String text,

}) => Container(
  width: width,
  decoration: BoxDecoration(
     color: background,
     borderRadius: BorderRadius.circular(radius,),
    ),
  child: MaterialButton(
    onPressed: ()
    {
      function();
    },
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);
 

Widget defultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function(String)? onChange, 
  GestureTapCallback? onTap, 
  required FormFieldValidator<String>? validate,
  required String lable,
  required IconData prefix,
  IconData?  suffix ,
  bool obsCuretext = false,
  bool isCleckable =true,
  VoidCallback? onPressed,
}) =>TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: obsCuretext,
  onFieldSubmitted: onSubmit,
  onTap: onTap,
  onChanged: onChange,
  validator: validate,
  enabled: isCleckable,
  decoration: InputDecoration(
    hintText: lable,
    labelText: lable,
    border: OutlineInputBorder(),
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: IconButton(
      onPressed: onPressed, 
      icon: Icon(
        suffix,
      ),
    ), 
     ),
);
  
Widget defultTextButton({
  required VoidCallback? onPressed,
  required String text,

}){
  return TextButton(
    onPressed: onPressed, 
    child: Text(
      text.toUpperCase(),
      ),

    );
}

PreferredSizeWidget? defaultAppBar({
  required BuildContext context,
  String title = '',
  List<Widget>? actions,
}) => AppBar(
  leading: IconButton(
    onPressed: ()
    {
      Navigator.pop(context);
    },
    icon: Icon(
      IconBroken.Arrow___Left_2,
    ),
  ),
  titleSpacing: 5.0,
  title: Text(
    title,
  ),
  actions: actions,
);

Widget buildTaskItem(Map model,context) => Dismissible(
  //key:  UniqueKey(),
  key: Key(model['id'].toString()),
  child:   Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [ 
            CircleAvatar(  
              radius: 40.0,
              child: Text(
                '${model['time']}', 
              ),
            ),
            SizedBox(
              width: 20.0,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${model['titel']}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    '${model['data']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: 20.0,),
            IconButton(
              onPressed: (){
                AppCubit().get(context).UpdateData(
                  status: "done", 
                  id: model['id'],
                  );
              }, 
              icon: Icon(
                Icons.check_box,
                color: Colors.green,
              )),
            IconButton(
              onPressed: (){
                AppCubit().get(context).UpdateData(
                  status: "arcived", 
                  id: model['id'],
                  );
                  print('${model}');
              }, 
              icon: Icon(
                Icons.archive,
                color: Colors.black45,
              )),
          ],
        ),
      ),
  onDismissed: (direction){
    AppCubit().get(context).deleteData(id: model['id'],);
  },
); 

Widget tasksBiulder({
  required List<Map> tasks,
}){
  return ConditionalBuilder(
      condition: tasks.length > 0 ,
      builder: (context) => ListView.separated(
          itemBuilder: (context,index)=> buildTaskItem(tasks[index],context), 
          separatorBuilder: (context,index)=> Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 20.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ), 
          itemCount: tasks.length,
          ),
      fallback: (context)=>Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              ),
            Text(
              'No Taskes Yet, Please Enter taskes',
              ),  
          ],
          ),
      ) ,
    );
}

Widget BuildArticleItem(article,context){
  return InkWell(
    onTap: (){
      NavigetTo(context,webViewScreen(article['url']));
    },
    child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0,
                ),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                  ),
              ),
            ),
            SizedBox(
              width: 20.0,
              ),
            Expanded(
              child: Container(
                height: 120,
                child: Column( 
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        maxLines: 2,
                        overflow:TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                        ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      ),
                  ],
                ),
              ),
            ),  
          ],
        ),
      ),
  );
}

Widget articleBuilder(list,{isSearch = false}){
  return ConditionalBuilder(
    condition: list.length > 0,
    builder: (context)=> ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context,index) => BuildArticleItem(list[index],context), 
      separatorBuilder: (context,index) =>MyDivider(),
      itemCount: list.length),
    fallback: (context) => isSearch ? Container() : Center(child: CircularProgressIndicator()
    ),
    );
}

Widget MyDivider (){
  return Padding(
    padding: const EdgeInsetsDirectional.only(start: 20.0,),
    child: Container(
       width: double.infinity,
       height: 1.0,
       color: Colors.grey[300],
     ),
  );
}

void NavigetTo(context,Widget) => Navigator.push(
  context, 
  MaterialPageRoute(
    builder: (context)=>Widget,
    ),
  );

void NavidetAndFinish(context,Widget) => Navigator.pushAndRemoveUntil(
  context, 
  MaterialPageRoute(
    builder: (context)=> Widget), 
  (route) => false) ; 


void showToast({
  required String msg,
  required toastStates state,}){
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
  );
}  

enum toastStates{SUCCESS,ERROR,WARNING}

Color chooseToastColor(toastStates states){
  Color color;
  switch(states){
    case toastStates.SUCCESS:
    color = Colors.green;
    break;
    case toastStates.ERROR:
    color = Colors.red;
    break;
    case toastStates.WARNING:
    color = Colors.amber;
    break;
  }return color;

}

void signOut(context){
  CachHelper.removeData(key: 'token').then((value) {
   NavidetAndFinish(context, loginScreen());
  });
}




