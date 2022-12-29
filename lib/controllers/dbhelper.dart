import 'package:hive/hive.dart';

class DbHelper {
  late Box box;
  DbHelper() {
    openBox();
  }
  openBox() {
    box = Hive.box('money');
  }

  Future addData(int amount, String note, String type) async {
    var value = {'amount': amount, 'note': note, 'type': type};
    box.add(value);
  }

  Future<Map> fetch() {
    if (box.values.isEmpty) {
      return Future.value({});
    } else {
      return Future.value(box.toMap());
    }
  }
}
