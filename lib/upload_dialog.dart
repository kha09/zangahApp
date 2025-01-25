import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' if (dart.library.io) 'stub.dart' as universal;

class UploadDialog extends StatefulWidget {
  const UploadDialog({super.key});

  @override
  State<UploadDialog> createState() => _UploadDialogState();
}

class _UploadDialogState extends State<UploadDialog> {
  final TextEditingController _subjectController = TextEditingController();
  bool isScheduleChecked = false;
  bool isQuestionsChecked = false;
  bool isSummaryChecked = false;
  String? selectedFileName;

  void _pickFile() {
    if (kIsWeb) {
      try {
        final input = universal.FileUploadInputElement()
          ..style.display = 'none'
          ..multiple = false;
        
        input.onChange.listen((event) {
          if (input.files?.isNotEmpty == true) {
            setState(() {
              selectedFileName = input.files![0].name;
            });
          }
        });

        input.click();
      } catch (e) {
        print('Error picking file: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header with close button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'اسم الملف',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.blue[800]),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Subject text field
            TextField(
              controller: _subjectController,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'اسم المادة الدراسية',
                hintStyle: TextStyle(color: Colors.grey[600]),
                filled: true,
                fillColor: Colors.blue[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Subtitle
            Text(
              'كيف نضبطك؟',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 18,
                color: Colors.purple[800],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // Checkboxes
            CheckboxListTile(
              value: isScheduleChecked,
              onChanged: (value) => setState(() => isScheduleChecked = value!),
              title: const Text('جدول تختيم', textAlign: TextAlign.right),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: isQuestionsChecked,
              onChanged: (value) => setState(() => isQuestionsChecked = value!),
              title: const Text('أسئلة', textAlign: TextAlign.right),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: isSummaryChecked,
              onChanged: (value) => setState(() => isSummaryChecked = value!),
              title: const Text('ملخص', textAlign: TextAlign.right),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const SizedBox(height: 24),
            
            // Upload button
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue.shade800),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: _pickFile,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.upload_file, color: Colors.blue[800]),
                    const SizedBox(width: 8),
                    Text(
                      selectedFileName ?? 'رفع الملف',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Create Content Button
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_subjectController.text.isNotEmpty) {
                  Navigator.of(context).pop({
                    'subject': _subjectController.text,
                    'hasSchedule': isScheduleChecked,
                    'hasQuestions': isQuestionsChecked,
                    'hasSummary': isSummaryChecked,
                    'fileName': selectedFileName ?? '',
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[700],
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check, color: Colors.white),
                  const SizedBox(width: 8),
                  const Text(
                    'انشاء المحتوى',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
