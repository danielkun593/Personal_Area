// ignore_for_file: deprecated_member_use

import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class ApiWhatsapp{
  //CONNECTIONS WITH WS AND CALL ASESSOR USER
  Future<void> connectWhatsApp(String phone, String text) async {
    var numberWs = phone;
    var textWs = text;
    final link = WhatsAppUnilink(phoneNumber: numberWs, text: textWs);
    await launch('$link');
  }
}