import 'package:dars_29_home/controllers/todos_controller.dart';
import 'package:dars_29_home/models/todo.dart';
import 'package:dars_29_home/views/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';

class ShowTodo extends StatefulWidget {
  Todo todo;
  ShowTodo({super.key, required this.todo});

  @override
  State<ShowTodo> createState() => _ShowTodoState();
}

class _ShowTodoState extends State<ShowTodo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todos"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 10),
        child: Container(
          height: 80,
            decoration: BoxDecoration(
                border:
                Border.all(color: Colors.green, width: 2),
                borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: InkWell(
                  onTap: () {
                    widget.todo.isComplete = !widget.todo.isComplete;
                    setState(() {});
                  },
                  child:
                  widget.todo.isComplete
                      ? Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                  )
                      : Icon(
                    Icons.circle_outlined,
                    color: Colors.red,
                  )),
              title: Text(
                "${widget.todo.title}",style: widget.todo.isComplete ?  TextStyle(decoration: TextDecoration.lineThrough) : null,),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.todo.description}",),
                  Text(
                      '${widget.todo.date.day}/${widget.todo.date.month}/${widget.todo.date.year}')
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () async {
                        Todo? data = await showDialog(
                            context: context,
                            builder: (ctx) {
                              return ShowDialog(
                                  title: 'Rejani tahrirlash');
                            });

                        if (data != null) {
                          widget.todo.title =
                              data.title;
                          widget.todo
                              .description = data.description;
                          widget.todo.date =
                              data.date;
                          setState(() {});
                        }
                      },
                      child: Icon(Icons.edit)),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        for(int i = 0;i < todos.length;i++)
                          if(todos[i].title == widget.todo.title){
                            todos.removeAt(i);
                            Navigator.pop(context);
                          }
                        setState(() {});
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                ],
              ),
            )),
      )

    );
  }
}
