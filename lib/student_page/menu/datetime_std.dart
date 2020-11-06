import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scicare/widgets/widgets.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class selectDateTime extends StatefulWidget {
  @override
  _selectDateTimeState createState() => _selectDateTimeState();
}


class _selectDateTimeState extends State<selectDateTime> {

  DateTime date = DateTime.now();
  TimeOfDay _time;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _time = TimeOfDay.now();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            dateButton(context),
            Mystyle().MySizedBox(),
            showDate(),
            Mystyle().MySizedBox(),
            timeButton(),
            Mystyle().MySizedBox(),
            Text('Time : ${_time.hour} : ${_time.minute}'),
            //showTime(),
          ],
        ),
      ),
    );
  }

  //Text showTime() => Text('Time : ${_time.hour}: ${_time.minute}');
  //Text showTime() => Text('Time : ${_time.hour}: ${_time.minute}');

  RaisedButton timeButton() {
    return RaisedButton(
            color: Mystyle().bluecolor,
            child: Text('เลือกเวลาเข้าพบ',
              style: TextStyle(color: Mystyle().whitecolor),
            ),
            onPressed: (){
              setState(() {
                selectTime();
              });
            },
          );
  }

  Text showDate() => Text(date.toString(), style: TextStyle(fontSize: 20),);

  RaisedButton dateButton(BuildContext context) {
    return RaisedButton(
            color: Mystyle().bluecolor,
            child: Text('เลือกวันเข้าพบ',
              style: TextStyle(color: Mystyle().whitecolor),),
            onPressed: (){
              selectDate(context);
            },
          );
  }

  Future<Null>selectDate(BuildContext context)async{
    DateTime datePicker = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));
    if(datePicker != null && datePicker != date){
      setState(() {
        date = datePicker;
        print(date.toString());
      });
    }

  }

  selectTime()async{
    TimeOfDay time = await showTimePicker(
        context: context,
        initialTime: _time,
        builder: (BuildContext context, Widget child){
          return Theme(data: ThemeData(), child: child,);

        }

    );
    if (time != null)
      setState(() {
        _time = time;
      });
  }
}
