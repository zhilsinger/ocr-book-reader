// Services layer — Dart wrappers for Rust backend calls via rinf.
// TODO: Connect to rinf-generated message handlers.

class OcrService {
  // TODO: Send OpenPdfRequest to Rust, listen for PdfOpenedSignal
  static Future<void> openPdf(String path) async {}

  // TODO: Send OcrPageRequest to Rust, listen for OcrCompletedSignal
  static Future<void> ocrPage(int pageNum) async {}

  // TODO: Listen for ProgressSignal from Rust
  static Stream<Map<String, dynamic>> get progressStream async* {}
}
