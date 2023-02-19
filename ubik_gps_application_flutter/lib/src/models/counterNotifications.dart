import 'package:flutter/foundation.dart';


class NotificationModal extends ChangeNotifier{
  int numero;

  int get num => numero;

  set num(int valor){
    numero = valor;
    notifyListeners();
  }

}