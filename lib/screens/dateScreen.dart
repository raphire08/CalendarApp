import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snapwork_test/model/eventModel.dart';
import 'package:snapwork_test/persistence.dart';
import 'package:snapwork_test/widgets/modalSheet.dart';
import 'package:snapwork_test/common.dart';

class DateScreen extends StatefulWidget {
  @override
  _DateScreenState createState() => _DateScreenState();
}

List<String> monthList = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];
List<int> noDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
DateTime now = DateTime.now();

class _DateScreenState extends State<DateScreen> {
  String month = monthList[now.month - 1];
  String year = now.year.toString();
  Future<List<EventModel>> models;
  @override
  void initState() {
    _getModels();
    super.initState();
  }

  _getModels() async {
    models = FilePersistence.getModels();
    print(models);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
      ),
      body: Column(children: [
        Expanded(
          flex: 1,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildRaisedButton(
                context: context,
                buttonText: month,
                isYear: false,
              ),
              buildRaisedButton(
                context: context,
                buttonText: year,
                isYear: true,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 9,
          child: FutureBuilder<List<EventModel>>(
            future: models,
            builder: (BuildContext context,
                AsyncSnapshot<List<EventModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                List<EventModel> filter;
                if (snapshot.hasData) {
                  filter = snapshot.data
                      .where((e) => (e.month == month && e.year == year))
                      .toList();
                } else {
                  filter = [];
                }
                return ListView.builder(
                  itemCount: noDays[now.month - 1],
                  itemBuilder: (BuildContext context, int index) {
                    List<int> days = List.generate(
                        noDays[now.month - 1], (int index) => index + 1);
                    EventModel eventData = filter.firstWhere(
                        (element) => element.date == days[index].toString(),
                        orElse: () => null);
                    return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 15.0),
                      child: Column(
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                FlatButton(
                                  child: Text(
                                    '${days[index]} $month',
                                    style: dateTextStyle,
                                  ),
                                  onPressed: () {
                                    EventModel model = EventModel();
                                    model.month = month;
                                    model.year = year;
                                    model.date = days[index].toString();
                                    Navigator.pushNamed(context, '/eventScreen',
                                        arguments: model);
                                  },
                                ),
                                VerticalDivider(
                                  color: verticalDividerColor,
                                  thickness: 2.0,
                                ),
                                eventData == null
                                    ? Container()
                                    : Container(
                                        child: Text(
                                          '${eventData.time} - ${eventData.title}',
                                          style: labelTextStyle,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Divider(),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        )
      ]),
    );
  }

  RaisedButton buildRaisedButton(
      {BuildContext context, String buttonText, bool isYear}) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: primaryColor,
      child: Text(
        buttonText,
        style: buttonTextStyle,
      ),
      onPressed: () async {
        print(buttonText);
        String selection = await showModalBottomSheet<String>(
            context: context,
            builder: (context) {
              return ModalSheet(
                isYear: isYear,
              );
            });
        setState(() {
          if (isYear) {
            year = selection == null ? year : selection;
          } else {
            month = selection == null ? month : selection;
          }
        });
      },
    );
  }
}
