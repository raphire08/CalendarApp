import 'package:flutter/material.dart';

class ModalSheet extends StatelessWidget {
  ModalSheet({this.isYear});
  final bool isYear;

  @override
  Widget build(BuildContext context) {
    List<String> listContent = isYear
        ? [
            '2020',
            '2021',
            '2022',
            '2023',
            '2024',
            '2025',
            '2026',
            '2027',
            '2028',
            '2029',
          ]
        : [
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
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: isYear ? Text('Year') : Text('Month'),
          ),
          Expanded(
            flex: 9,
            child: ListView.builder(
                itemCount: listContent.length,
                itemBuilder: (BuildContext context, int index) {
                  return FlatButton(
                    onPressed: () {
                      Navigator.pop(context, listContent[index]);
                    },
                    child: Text(listContent[index]),
                  );
                }),
          )
        ],
      ),
    );
  }
}
