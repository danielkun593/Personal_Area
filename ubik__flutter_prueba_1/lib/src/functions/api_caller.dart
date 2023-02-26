import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ApiCall{
  Future<void> connectCall(String phone) async {
    FlutterPhoneDirectCaller.callNumber(phone);
  }
}