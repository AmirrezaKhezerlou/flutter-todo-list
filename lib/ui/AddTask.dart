import 'package:flutter/material.dart';
import 'package:todo/ui/Home.dart';
import '/model/Tasks.dart';
import '/service/TaskService.dart';
import 'package:persian_datetimepickers/persian_datetimepickers.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

class AddTask extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<AddTask> {
  void SelectDate(String Title, String Description) async {
    DateTime dt;
    final DateTime? date = await showPersianDatePicker(
      context: context,
    );
    final TimeOfDay? time = await showPersianTimePicker(
      context: context,
    );
    dt = DateTime(date!.year, date.month, date.day, time!.hour, time.minute);
    print(dt.toString());
    final Event event = Event(
      title: Title,
      description: Description,
      startDate: DateTime.now(),
      endDate: dt,
      iosParams: IOSParams(
        reminder: Duration(
            /* Ex. hours:1 */), // on iOS, you can set alarm notification after your event.
      ),
      androidParams: AndroidParams(
        emailInvites: [], // on Android, you can add invite emails to your event.
      ),
    );

    Add2Calendar.addEvent2Cal(event);
  }

  String title = "title";
  String description = "123456";

  var _taskService = TaskService();
  var _task = Tasks();

  TextEditingController ftitle = TextEditingController();
  TextEditingController fdescription = TextEditingController();
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "افزودن کار جدید",
          style: TextStyle(fontFamily: 'iransans'),
        ),
      ),
      key: _key,
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 8),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: buildTextFiedl(
                                          name: "عنوان کار",
                                          controller: ftitle,
                                          type: 1)),
                                  SizedBox(
                                    height: 28,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: buildTextFiedl(
                                        name: "توضیحات کار",
                                        controller: fdescription,
                                        type: 6),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'با استفاده از گزینه ی زیر می توانید برای فعالیت خود ، هشدار تنظیم نمایید.',
                                  style: TextStyle(
                                      fontFamily: 'iransans',
                                      fontSize: 12,
                                      height: 2),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  SelectDate(ftitle.text.toString(),
                                      fdescription.text.toString());
                                },
                                child: Text(
                                  'انتخاب تاریخ ( اختیاری )',
                                  style: TextStyle(fontFamily: 'iransans'),
                                )),
                            SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: GestureDetector(
                                onTap: () async {
                                  _task.title = ftitle.text;
                                  _task.description = fdescription.text;
                                  _task.status = 0;
                                  var result =
                                      await _taskService.saveTask(_task);
                                  print(result);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                },
                                child: Container(
                                  width: 420,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [Colors.blue, Colors.blue]),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "افزودن کار جدید",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontFamily: 'iransans',
                                        fontWeight: FontWeight.w600),
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  buildTextFiedl({name, controller, type}) {
    return TextFormField(
      style: TextStyle(fontFamily: 'iransans'),
      controller: controller,
      onSaved: (newValue) {
        if (name == "عنوان کار") {
          this.title = newValue!;
        } else {
          this.description = newValue!;
        }
      },
      maxLines: type,
      decoration: new InputDecoration(
          border: new OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
          ),
          filled: true,
          hintStyle:
              new TextStyle(color: Colors.grey[800], fontFamily: 'iransans'),
          labelText: name,
          labelStyle: TextStyle(fontFamily: 'iransans'),
          fillColor: Color.fromRGBO(245, 245, 245, 100)),
    );
  }
}
