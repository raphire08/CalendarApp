class EventModel {
  EventModel(
      {this.date, this.year, this.month, this.time, this.desc, this.title});

  String date;
  String month;
  String year;
  String time;
  String title;
  String desc;

  Map<String, String> toJSON() {
    Map<String, String> data = {
      'date': date,
      'month': month,
      'year': year,
      'time': time,
      'title': title,
      'desc': desc,
    };
    return data;
  }

  factory EventModel.fromJSON(Map<String, String> data) {
    return EventModel(
      year: data['year'],
      date: data['date'],
      month: data['month'],
      time: data['time'],
      title: data['title'],
      desc: data['desc'],
    );
  }
}
