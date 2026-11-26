import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../data/models/homework_model.dart';
import '../../logic/homework_provider.dart';

/// Multi-Page Homework Scanner & Single Combined PDF Generator
class HomeworkScannerScreen extends StatefulWidget {
  final HomeworkModel homework;
  const HomeworkScannerScreen({super.key, required this.homework});

  @override
  State<HomeworkScannerScreen> createState() => _HomeworkScannerScreenState();
}

class _HomeworkScannerScreenState extends State<HomeworkScannerScreen> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _pages = [];
  bool _isGenerating = false;

  Future<void> _capturePage(ImageSource source) async {
    final XFile? file = await _picker.pickImage(source: source, imageQuality: 85);
    if (file != null) {
      setState(() => _pages.add(file));
    }
  }

  Future<void> _compileAndSubmitPdf() async {
    if (_pages.isEmpty) return;
    setState(() => _isGenerating = true);

    try {
      final pdf = pw.Document();
      for (final page in _pages) {
        final Uint8List bytes = await page.readAsBytes();
        final image = pw.MemoryImage(bytes);
        pdf.addPage(
          pw.Page(
            build: (pw.Context context) => pw.Center(
              child: pw.Image(image, fit: pw.BoxFit.contain),
            ),
          ),
        );
      }

      final dir = await getApplicationDocumentsDirectory();
      final outPath = '${dir.path}/HW_${widget.homework.id}_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File(outPath);
      await file.writeAsBytes(await pdf.save());

      if (!mounted) return;
      final success = context.read<HomeworkProvider>().submitOrReplaceHomework(widget.homework.id, outPath);
      if (success) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Compiled ${_pages.length} page(s) into 1 PDF & submitted!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Submission locked because the deadline has passed.')),
        );
      }
    } finally {
      if (mounted) setState(() => _isGenerating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Multi-Page Homework Scanner')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Capture Page'),
                    onPressed: () => _capturePage(ImageSource.camera),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Add from Gallery'),
                    onPressed: () => _capturePage(ImageSource.gallery),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _pages.isEmpty
                ? const Center(child: Text('No pages scanned yet. Capture pages to combine into 1 PDF.'))
                : ReorderableListView.builder(
                    itemCount: _pages.length,
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        if (newIndex > oldIndex) newIndex -= 1;
                        final item = _pages.removeAt(oldIndex);
                        _pages.insert(newIndex, item);
                      });
                    },
                    itemBuilder: (ctx, idx) => ListTile(
                      key: ValueKey(_pages[idx].path),
                      leading: Image.file(File(_pages[idx].path), width: 48, height: 48, fit: BoxFit.cover),
                      title: Text('Page ${idx + 1}'),
                      subtitle: const Text('Drag to reorder'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => setState(() => _pages.removeAt(idx)),
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: _isGenerating
                    ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Icon(Icons.picture_as_pdf),
                label: Text('Combine (${_pages.length} Pages) & Submit PDF'),
                onPressed: _pages.isEmpty || _isGenerating ? null : _compileAndSubmitPdf,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
