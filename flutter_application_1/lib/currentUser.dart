// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUserProvider = Provider<CurrentUser?>((ref) => null);

class CurrentUser{
  String userName = "";
  String UID = "";
  CurrentUser(this.userName, this.UID);
  

}
