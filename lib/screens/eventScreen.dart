import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snapwork_test/common.dart';
import 'package:snapwork_test/model/eventModel.dart';
import 'package:snapwork_test/persistence.dart';

class EventScreen extends StatefulWidget {
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  String validateTextField(value) {
    if (value.isEmpty) {
      return 'Text cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    EventModel model = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Detail'),
      ),
      bottomSheet: buildBottomButton(model),
      body: Form(
        key: _formKey,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Text(
                          'Date & Time',
                          style: labelTextStyle,
                        )),
                    Expanded(
                        flex: 1,
                        child: Center(
                          child: TextFormField(
                            validator: validateTextField,
                            decoration:
                                formFieldDecoration.copyWith(hintText: 'HH:MM'),
                            controller: dateController,
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Center(
                            child: Text(
                                '${model.date}-${model.month}-${model.year}',
                                style: labelTextStyle))),
                  ],
                ),
                SizedBox(height: 15.0),
                Row(
                  children: [
                    Expanded(
                        flex: 2, child: Text('Title', style: labelTextStyle)),
                    Expanded(
                        flex: 5,
                        child: TextFormField(
                          validator: validateTextField,
                          decoration: formFieldDecoration,
                          controller: titleController,
                        )),
                  ],
                ),
                SizedBox(height: 15.0),
                Text('Description', style: labelTextStyle),
                SizedBox(height: 15.0),
                TextFormField(
                  validator: validateTextField,
                  decoration: formFieldDecoration,
                  controller: descController,
                  maxLines: 5,
                ),
              ],
            )),
      ),
    );
  }

  InkWell buildBottomButton(EventModel model) {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState.validate()) {
          model.time = dateController.value.text;
          model.title = titleController.value.text;
          model.desc = descController.value.text;
          print(dateController.value.text);
        }
        await FilePersistence.saveModel(model);
        Navigator.pushNamedAndRemoveUntil(
            context, '/dateScreen', (route) => false);
      },
      child: Container(
        height: 50.0,
        width: double.infinity,
        color: primaryColor,
        child: Center(
          child: Text(
            'SAVE',
            style: buttonTextStyle,
          ),
        ),
      ),
    );
  }
}
