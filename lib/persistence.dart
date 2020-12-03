import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:snapwork_test/model/eventModel.dart';

class FilePersistence {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> _localFile(String filename) async {
    final path = await _localPath;
    return File('$path/events/$filename');
  }

  static Future<void> saveModel(EventModel model) async {
    final file = await _localFile(
        '${model.title}_${model.date}_${model.month}_${model.year}');
    print(file);
    await file.parent.create(recursive: true);
    final jsonString = JsonEncoder().convert(model.toJSON());
    await file.writeAsString(jsonString);
    print(jsonString);
  }

  static Future<List<EventModel>> getModels() async {
    List<EventModel> models = [];
    final path = await _localPath;
    Directory("$path/events/")
        .listSync()
        .forEach((FileSystemEntity content) async {
      String objectString = await File(content.path).readAsString();
      Map<String, String> data =
          Map<String, String>.from(JsonDecoder().convert(objectString));
      models.add(EventModel.fromJSON(data));
      print(models);
    });
    return models;
  }
}
