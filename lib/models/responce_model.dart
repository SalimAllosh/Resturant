import 'dart:convert';

class ResponseModel {
  final bool _isSuccess;
  final String _message;
  //late Map<String, dynamic> _error;
  ResponseModel(this._isSuccess, this._message);

  String get message => _message;
  bool get isSuccess => _isSuccess;
}
