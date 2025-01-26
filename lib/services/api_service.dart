import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'dart:async';

class ApiService {
  static const String baseUrl = 'http://localhost:3000';

  static Future<Map<String, dynamic>> uploadFile(html.File file) async {
    try {
      print('Starting file upload for: ${file.name}');
      
      // Create FormData and append file with field name 'pdf'
      final formData = html.FormData();
      formData.appendBlob('pdf', file, file.name);
      
      print('Created FormData with file: ${file.name}');

      // Create XMLHttpRequest
      final xhr = html.HttpRequest();
      final completer = Completer<Map<String, dynamic>>();
      
      // Set up upload event handlers
      xhr.upload.onProgress.listen((e) {
        if (e.lengthComputable) {
          final percentComplete = ((e.loaded ?? 0) / (e.total ?? 1) * 100).round();
          print('Upload progress: $percentComplete%');
        }
      });

      // Set up response handlers
      xhr.onLoad.listen((_) {
        print('Upload complete. Status: ${xhr.status}');
        if (xhr.status == 200) {
          completer.complete({
            'success': true,
            'message': 'File uploaded successfully'
          });
        } else {
          completer.complete({
            'success': false,
            'message': 'Upload failed with status: ${xhr.status}'
          });
        }
      });

      xhr.onError.listen((_) {
        print('Upload failed');
        completer.complete({
          'success': false,
          'message': 'Upload failed'
        });
      });

      // Open and send request
      xhr.open('POST', '$baseUrl/upload');
      xhr.send(formData);
      
      return completer.future;
      
    } catch (e) {
      print('Error uploading file: $e');
      return {
        'success': false,
        'message': 'Error uploading file: $e'
      };
    }
  }
}
