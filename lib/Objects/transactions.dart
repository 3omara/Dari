import 'package:flutter/foundation.dart';


class Transactions {
  @required String name, id;
  @required double price;
  @required DateTime date;
  Transactions({this.date, this.id, this.name, this.price});
}
