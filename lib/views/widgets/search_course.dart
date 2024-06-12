import 'package:dars_29_home/models/alarm.dart';
import 'package:dars_29_home/models/course.dart';
import 'package:dars_29_home/models/todo.dart';
import 'package:dars_29_home/views/screens/show_alarm.dart';
import 'package:dars_29_home/views/screens/show_course.dart';
import 'package:dars_29_home/views/screens/show_todo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchViewDelegate extends SearchDelegate<String> {
  final Map<String, dynamic> data;

  SearchViewDelegate(this.data);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/');
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // List<Course> suggestionList = query.isEmpty ? data : data.where((element) => element.title.contains(query)).toList();
    return Container(
        // child: ListView.builder(
        //   itemCount: suggestionList.length,
        //   itemBuilder: (ctx,index){
        //     return ListTile(
        //       title: Text("${suggestionList[index].title}"),
        //       onTap: (){
        //         Map<String,dynamic> mp = {
        //           'course':  suggestionList[index],
        //           'courseId': -1
        //         };
        //         Navigator.pushReplacementNamed(context, '/show-course',arguments: mp);
        //       },
        //     );
        //   },
        // )
        );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Course> courses = data['courses'] as List<Course>;
    List<Todo> todos = data['todos'] as List<Todo>;
    List<Alarm> alarms = data['alarms'] as List<Alarm>;

    List<Course> suggesCourses = query.isEmpty
        ? courses
        : courses.where((element) => element.title.contains(query)).toList();
    List<Todo> suggesTodo = query.isEmpty
        ? todos
        : todos
            .where((element) => element.date.toString().contains(query))
            .toList();
    List<Alarm> suggesAlarms = query.isEmpty
        ? alarms
        : alarms
            .where((element) => element.date.toString().contains(query))
            .toList();
    List suggestionList = [...suggesCourses, ...suggesTodo, ...suggesAlarms];
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (ctx, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: (){
                if(suggesTodo.length > index){
                  Map<String,dynamic> mp = {
                    'course': suggesCourses[index],
                    'courseId': -1
                  };
                  Navigator.pushNamed(context, '/show-course',arguments: mp);
                }else if(suggesTodo.length != 0 && suggesTodo.length + suggesCourses.length > index && suggesCourses.length >= index){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowTodo(todo: suggestionList[index])));
                }else if(suggesAlarms.length != 0 && index >= suggesCourses.length + suggesTodo.length){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAlarm(alarm: suggestionList[index])));
                }
              },
              child: ListTile(
                title: Text('${suggestionList[index].title}'),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),

          ],
        );
      },
    );

    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: ListView.builder(
            itemBuilder: (ctx, i) {
              return ListTile(
                title: Text("${suggesCourses[i].title}"),
              );
            },
            itemCount: suggesCourses.length,
          ),
        ),
        Flexible(
          child: ListView.builder(
            itemBuilder: (ctx, i) {
              return ListTile(
                title: Text("${suggesTodo[i].title}"),
              );
            },
            itemCount: suggesTodo.length,
          ),
        ),
        Flexible(
          child: ListView.builder(
            itemBuilder: (ctx, i) {
              return ListTile(
                title: Text("${suggesAlarms[i].title}"),
              );
            },
            itemCount: suggesAlarms.length,
          ),
        ),
      ],
    );
  }
}
