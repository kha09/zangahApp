import 'package:flutter/material.dart';

class UploadDialog extends StatefulWidget {
  const UploadDialog({Key? key}) : super(key: key);

  @override
  State<UploadDialog> createState() => _UploadDialogState();
}

class _UploadDialogState extends State<UploadDialog> {
  bool isScheduleChecked = false;
  bool isQuestionsChecked = false;
  bool isSummaryChecked = false;

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
            
            // Text field
            TextField(
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'اسم الملف الذي سيتم رفعه',
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
            InkWell(
              onTap: () {
                // Handle upload
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue[800]!,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_upload_outlined, color: Colors.blue[800]),
                    const SizedBox(width: 8),
                    Text(
                      'رفع الملف',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // New Create Content Button
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle create content
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
