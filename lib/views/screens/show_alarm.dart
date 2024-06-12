import 'package:dars_29_home/controllers/alarm_controller.dart';
import 'package:dars_29_home/models/alarm.dart';
import 'package:dars_29_home/models/todo.dart';
import 'package:dars_29_home/views/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';

class ShowAlarm extends StatefulWidget {
  Alarm alarm;
  ShowAlarm({super.key, required this.alarm});

  @override
  State<ShowAlarm> createState() => _ShowAlarmState();
}

class _ShowAlarmState extends State<ShowAlarm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eslatmalar"),
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
              title: Text(
                "${widget.alarm.title}",),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.alarm.description}",),
                  Text(
                      '${widget.alarm.date.day}/${widget.alarm.date.month}/${widget.alarm.date.year}')
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
                                  title: 'Eslatmani tahrirlash');
                            });

                        if (data != null) {
                          widget.alarm.title =
                              data.title;
                          widget.alarm
                              .description = data.description;
                          widget.alarm.date =
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
                        for(int i = 0;i < alarms.length;i++)
                          if(alarms[i].title == widget.alarm.title) {
                            alarms.removeAt(i);
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
      ),
    );
  }
}
