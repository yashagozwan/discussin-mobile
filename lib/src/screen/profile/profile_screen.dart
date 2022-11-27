import 'package:cached_network_image/cached_network_image.dart';
import 'package:discussin_mobile/src/util/colors.dart';
import 'package:discussin_mobile/src/widget/text_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: const [
              TextPro(
              'Profile',
              color: primaryBlue,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        backgroundColor: yellow,
        elevation: 0,
        actions: [
          IconButton(
            icon: new Icon(Icons.notifications_none_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: editprofile(),
    );
  }
}

Widget editprofile() {
  return Column(
    children: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                      padding: EdgeInsets.fromLTRB(30, 20, 0, 0),
                      child: CachedNetworkImage(
                      imageUrl: 'https://picsum.photos/250?image=9',
                      alignment: Alignment.center,
                      imageBuilder: (context, image) => CircleAvatar(
                        backgroundImage: image,
                        radius: 60,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(110, 110, 0, 0),
                    width: 45,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      shape: BoxShape.circle,
                  ),
                  child: IconButton(
                      iconSize: 22,
                      icon: Icon(Icons.edit),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Jhon Legend",
                    style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 18),
                    ),
                    Text("Student Collage"),
                    Row(
                      children: [
                        Text("Followers : 25"),
                        SizedBox(width: 15),
                        Text("Following : 25")
                      ],
                    ),
                    Text("Joined Since 2018")

                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 15,),
          Container(
            alignment: Alignment.center,
            child: SizedBox(
              width: 360,
              child: ElevatedButton(onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder()
                ),
              child: Text("edit Profile")
            ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 30, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.post_add,
                      size: 30,
                    ),
                    SizedBox(width: 20,),
                      Text("Discuss created",
                      style: TextStyle(
                      fontSize: 15),
                      ),
                    ],
              ),
          ),
            SizedBox(height: 15,),
          Padding(
                    padding:EdgeInsets.symmetric(horizontal:10.0),
                    child:Container(
                    height:0.5,
                    width:360,
                    color:Colors.black),
                    ),
        Container(
            margin: EdgeInsets.fromLTRB(30, 15, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.comment_bank_outlined,
                      size: 30,
                    ),
                    SizedBox(width: 20,),
                      Text("Discuss that you joined",
                      style: TextStyle(
                      fontSize: 15),
                      ),
                    ],
              ),
          ),
            SizedBox(height: 15,),
          Padding(
                    padding:EdgeInsets.symmetric(horizontal:10.0),
                    child:Container(
                    height:0.6,
                    width:360,
                    color:Colors.black),
                    ),
        Container(
            margin: EdgeInsets.fromLTRB(30, 15, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.edit_note,
                      size: 30,
                    ),
                    SizedBox(width: 20,),
                      Text("Draft",
                      style: TextStyle(
                      fontSize: 15),
                      ),
                    ],
              ),
          ),
            SizedBox(height: 15,),
          Padding(
                    padding:EdgeInsets.symmetric(horizontal:10.0),
                    child:Container(
                    height:0.3,
                    width:360,
                    color:Colors.black),
                    ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 15, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.settings_outlined,
                      size: 30,
                    ),
                    SizedBox(width: 20,),
                      Text("Setting",
                      style: TextStyle(
                      fontSize: 15),
                      ),
                    ],
              ),
          ),
            SizedBox(height: 15,),
          Padding(
                    padding:EdgeInsets.symmetric(horizontal:10.0),
                    child:Container(
                    height:0.3,
                    width:360,
                    color:Colors.black),
                    ),
        ]);
}