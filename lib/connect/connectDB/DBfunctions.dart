import '../../main.dart';
import 'DatabaseHelper.dart';

class DB {
  static void insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: 'Ganapath',
      DatabaseHelper.columnFav: 1
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
    print("----inserted database---${dbData}");
  }

  static void query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    for (final row in allRows) {
      print(row.toString());
    }
  }

  static void update() async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: 2,
      DatabaseHelper.columnName: 'xyz',
      DatabaseHelper.columnFav: 0
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  static void delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }
}
