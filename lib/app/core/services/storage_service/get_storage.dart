import 'package:get_storage/get_storage.dart';

class LocalGetStorage {
  final box = GetStorage();

  //for any items
  read(String item) {
    var prod = box.read(item);
    // print(prod);
    return prod;
  }

  write(String item, var a) {
    box.write(item, a);
    print('$item saved');
  }

  clear(data) {
    box.remove(data);
    //box.remove('user');
  }
}

LocalGetStorage localStorage = LocalGetStorage();
