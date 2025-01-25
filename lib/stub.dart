class FileUploadInputElement {
  dynamic style = _Style();
  bool multiple = false;
  List<dynamic>? files;
  
  void click() {}
  
  Stream<dynamic> get onChange => const Stream.empty();
}

class _Style {
  String? display;
}
