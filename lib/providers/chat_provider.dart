import 'package:communication_chat/models/person.dart';
import 'package:flutter/cupertino.dart';

class ChatProvider extends ChangeNotifier {
  Preson? _presonData;
  set presonData(Preson? person) {
    _presonData = person;
    notifyListeners();
  }

  Preson? get presonData => _presonData;
}
