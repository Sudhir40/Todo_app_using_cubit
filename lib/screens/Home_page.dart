
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:notes_cubic/DB_helper/mydbhelper.dart';
import 'package:notes_cubic/notes_cubic/note_cubic.dart';
import 'package:notes_cubic/notes_cubic/note_state.dart';

import 'Add_note_page.dart';
class homepage  extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomepageState();
  }
}
class HomepageState extends State<homepage>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<note_cubic>().getnotes();
  }
  var height = [100.0,200.0,150.0,250.0,200.0,];
  var colorlist=[
    Color(0xFFB5C5E5),
    Color(0xFF59CD73),
    Color(0xFF3083BB),
    Color(0xFFEA9D54),
    Color(0xFFE791F5),
    Color(0xFF54EAC0),
  ];
  var time = DateTime.now();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 50),
        child: Column(
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),

              child: Center(child: Text('Your notes',style: TextStyle(
                  fontSize: 30,
                  color: Colors.white
              ),)),
            ),
            Expanded(
              child: BlocBuilder<note_cubic,note_state>(
                builder: (_,state){
                   if (state is noteLoadingstate ){
                     return Center(
                       child: CircularProgressIndicator(),
                     );
                   }else if (state is noteErrorstate){
                     return Center(child:Text('Error:${state.error_msg}'));
                   }else if (state is noteLoadedstate){
                     print('loaded');
                     if(  state.arrNotes.length ==0){
                       return Center(
                         child: Container(
                           padding: EdgeInsets.all(70),
                           child: Column(children: [
                             Image.asset('Assets/images/post-it.png'),
                             Text('No data')
                           ],),),
                       );
                     }else

                    ///MasonryGridView
                     return  MasonryGridView.builder(
                           itemCount:  state.arrNotes.length ,
                           crossAxisSpacing: 10,
                           mainAxisSpacing: 10,
                           gridDelegate:  SliverSimpleGridDelegateWithFixedCrossAxisCount(
                             crossAxisCount: 2,
                           ),
                           itemBuilder: (context,index){
                             print('Masonry');
                             Color cardcolor= colorlist[index% colorlist.length];
                               return
                                 InkWell(onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                       add_note_page(id:index)));
                                 },
                                   onLongPress: (){
                                     int num =int.parse(state.arrNotes[index].noteid.toString());
                                     context.read<note_cubic>().delete(num);
                                   },
                                   child: Container(
                                     padding: EdgeInsets.all(2),
                                     decoration: BoxDecoration(
                                       color: cardcolor,
                                       borderRadius: BorderRadius.only(topRight:Radius.circular(5),topLeft: Radius.circular(5),bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5)),
                                     ),
                                     width: double.infinity,
                                     height:height[index % height.length],
                                     child: Column(
                                       children: [
                                         Center(child: Text('${state.arrNotes[index].title}',style: TextStyle(
                                             fontSize: 20
                                         ),)),
                                         Expanded(child: Container(
                                             margin: EdgeInsets.only(top: 10,right: 3,left: 3,bottom: 5),
                                             child: Stack(children:[
                                               Text('${state.arrNotes[index].notes}',
                                                 style: TextStyle(fontSize: 10),
                                                 textAlign: TextAlign.center,),
                                               Align(alignment:Alignment(1,1),
                                                   child: Text('${DateFormat('dd-MMMyy').format(time)}',
                                                     style: TextStyle(backgroundColor:cardcolor,),))]))),
                                       ],
                                     ),
                                   ),
                                 );
                           }
                       );
                 /// here

                /// here listViewBuider
                     /*  ListView.builder(
                         itemCount: state.arrNotes.length,
                         itemBuilder: (contexer,index){
                           return InkWell(onTap: (){

                              Navigator.push(context, MaterialPageRoute(builder: (context)=>add_note_page(id:index)));
                           },
                             child: ListTile(
                               leading: Text('$index'),
                               title: Text('${state.arrNotes[index].title}'),
                               subtitle:  Text('${state.arrNotes[index].notes}'),
                               trailing: InkWell(onTap:(){
                                 int num =int.parse(state.arrNotes[index].noteid.toString());
                                  contexer.read<note_cubic>().delete(num);
                              // Appdatabase mydb = Appdatabase();
                              // mydb.delete(index);
                               },child:  Icon(Icons.delete)),
                             ),
                           );
                         });*/
                     ///here
                   }return Container();
                },
              ),
            ),
          ],
        ),
      ),floatingActionButton: FloatingActionButton.extended(
      label: Text('Add New'),
       icon:Icon(Icons.add),
      onPressed: (){
         Navigator.push(context, MaterialPageRoute(builder: (context)=>add_note_page()));
      },
    ),
    );
  }
}
