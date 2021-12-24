//import 'dart:js';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fristapp/layout/final_task_app/cubit/cubit.dart';
import 'package:fristapp/layout/final_task_app/cubit/states.dart';
import 'package:fristapp/modules/final_task_app/task_edite/task_edite_screen.dart';
import 'package:fristapp/shared/component/component.dart';
import 'package:fristapp/shared/component/constants.dart';
import 'package:fristapp/shared/styles/icon_broken.dart';

class TaskHomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  //FinalTaskCubit.get(context).getAllUsers();
  return BlocConsumer<FinalTaskCubit,TaskStates>(
      listener: (context, state) {
        if(state is TaskEditeUserSuccessState)
        {
          FinalTaskCubit.get(context).UsersList=[];
          FinalTaskCubit.get(context).getAllUsers();
        }

      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is TaskGetAllUserLoadingState, 
          builder: (context) => CircularProgressIndicator(),
          fallback:  (context) {
              return UsersBiulder();
          });
      }
    );
  }
}


Widget buildUserItem(context,index) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [ 
          CircleAvatar(  
            radius: 40.0,
            backgroundImage: NetworkImage(
              "https://image.freepik.com/free-photo/half-profile-beautiful-redhead-girl-with-healthy-freckled-skin-hair-bun-smiling_273609-9363.jpg",
              ), 
            ),
          SizedBox(
            width: 20.0,),
          Expanded(
            child: Text(
              '${FinalTaskCubit.get(context).UsersList[index]['name']}',
              //'${FinalTaskCubit.get(context).UsersList[index]['name']}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 20.0,),
          IconButton(
            onPressed: (){
              NavigetTo(context, TaskEditeUserScraan(index: index));
              // AppCubit().get(context).UpdateData(
              //   status: "done", 
              //   id: model['id'],
              //   );
            }, 
            icon: Icon(
              IconBroken.Arrow___Right_2,
              color: defultColor,
            )),
          // IconButton(
          //   onPressed: (){
          //     AppCubit().get(context).UpdateData(
          //       status: "arcived", 
          //       id: model['id'],
          //       );
          //       print('${model}');
          //   }, 
          //   icon: Icon(
          //     Icons.archive,
          //     color: Colors.black45,
          //   )),
        ],
      ),
    ); 

Widget UsersBiulder(){
  return ConditionalBuilder(
      condition: true,
      builder: (context) => ListView.separated(
          itemBuilder: (context,index)=> buildUserItem(context,index), 
          separatorBuilder: (context,index)=> MyDivider(),
          itemCount: FinalTaskCubit.get(context).UsersList.length,
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