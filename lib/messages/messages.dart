// Message definitions for Dart side of rinf bridge.
// These are hand-written stubs — rinf codegen will replace them.
// Maps to rust/src/messages.rs

class OpenPdfRequest {
  final String filePath;
  OpenPdfRequest({required this.filePath});
}

class OcrPageRequest {
  final int pageNum;
  final String side;
  final int? psm;
  final String? language;
  OcrPageRequest({required this.pageNum, required this.side, this.psm, this.language});
}

class PdfOpenedSignal {
  final String filePath;
  final int totalPages;
  final int spreadsDetected;
  final List<PageInfo> pages;
  PdfOpenedSignal({required this.filePath, required this.totalPages, required this.spreadsDetected, required this.pages});
}

class PageInfo {
  final int pageNum;
  final int width;
  final int height;
  final bool isSpread;
  final double aspectRatio;
  PageInfo({required this.pageNum, required this.width, required this.height, required this.isSpread, required this.aspectRatio});
}

class OcrCompletedSignal {
  final int pageNum;
  final String side;
  final String text;
  final double confidence;
  final int wordCount;
  OcrCompletedSignal({required this.pageNum, required this.side, required this.text, required this.confidence, required this.wordCount});
}

class TextCleanedSignal {
  final String cleanedText;
  final int rawLength;
  final int cleanedLength;
  final int headersRemoved;
  TextCleanedSignal({required this.cleanedText, required this.rawLength, required this.cleanedLength, required this.headersRemoved});
}

class ProgressSignal {
  final int current;
  final int total;
  final String message;
  final double percentage;
  ProgressSignal({required this.current, required this.total, required this.message, required this.percentage});
}

class ErrorSignal {
  final String message;
  final String code;
  ErrorSignal({required this.message, required this.code});
}
