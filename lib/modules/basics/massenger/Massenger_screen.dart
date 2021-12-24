// ignore_for_file: use_key_in_widget_constructors, camel_case_types, prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class  massengerScreen extends StatelessWidget 
{

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: 20.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage('https://www.cnet.com/a/img/liJ9UZA87zs1viJiuEfVnL7YYfw=/940x0/2020/05/18/5bac8cc1-4bd5-4496-a8c3-66a6cd12d0cb/fb-avatar-2.jpg',
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              'Chats',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: ()
            {},
            icon: CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
            ),
            ),
          IconButton(
            onPressed: ()
            {},
            icon: CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0,),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.all(5.0,),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'search',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 100.0,
                child: ListView.separated(
                  scrollDirection:Axis.horizontal ,
                  itemBuilder: (context , index) => buildStoryItem (),
                  separatorBuilder: (context , index) => SizedBox(
                    width: 20.0,
                  ), 
                  itemCount: 10,
                  ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => buildChatItem (), 
                separatorBuilder: (context, index) =>SizedBox(
                  height: 20.0,
                ), 
                itemCount: 15,
                ),
            ],
          ),
        ),
      ),
    );
  }


  Widget buildChatItem () => 
    Row(
      children:
      [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children:
          [
            CircleAvatar
            (
              radius: 25.0,
              backgroundImage: NetworkImage('https://www.cnet.com/a/img/liJ9UZA87zs1viJiuEfVnL7YYfw=/940x0/2020/05/18/5bac8cc1-4bd5-4496-a8c3-66a6cd12d0cb/fb-avatar-2.jpg',
            ),
            ),
            CircleAvatar
            (
              backgroundColor: Colors.red,
              radius: 5.0,
            ),
          ],
        ),           
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text(
                'soad abdallah kamal',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'helo my name is soadb helo my name is soad helo my name is soad ',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      ),
                    child: Container(
                      width: 7.0,
                      height: 7.0,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Text(
                    '02:30 am',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  Widget buildStoryItem () => 
    Container(
                  width: 50.0,
                  child: Column(
                    children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage('https://www.cnet.com/a/img/liJ9UZA87zs1viJiuEfVnL7YYfw=/940x0/2020/05/18/5bac8cc1-4bd5-4496-a8c3-66a6cd12d0cb/fb-avatar-2.jpg',
                        ),
                  ),
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 5.0,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'soad abdallah',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      ),  
                    ],
                  ),
                );
}