// Message definitions for Rust <-> Dart communication via rinf.
// These structs are serialized and sent across the FFI boundary.
use rinf::DartSignal;
use serde::{Deserialize, Serialize};

use crate::ocr_engine::OcrResult;
use crate::pdf_processor::PageInfo;
use crate::text_cleaner::CleanResult;

// ============ Dart -> Rust (requests) ============

/// Request to open and analyze a PDF
#[derive(Debug, Serialize, Deserialize)]
pub struct OpenPdfRequest {
    pub file_path: String,
}

/// Request to OCR a specific page
#[derive(Debug, Serialize, Deserialize)]
pub struct OcrPageRequest {
    pub page_num: u32,
    pub side: String, // "left", "right", "single"
    pub psm: Option<i32>,
    pub language: Option<String>,
}

/// Request to clean text with specified headers
#[derive(Debug, Serialize, Deserialize)]
pub struct CleanTextRequest {
    pub raw_text: String,
    pub headers: Vec<String>,
}

// ============ Rust -> Dart (responses/signals) ============

/// Signal: PDF opened successfully with page info
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PdfOpenedSignal {
    pub file_path: String,
    pub total_pages: u32,
    pub spreads_detected: u32,
    pub pages: Vec<PageInfo>,
}

/// Signal: OCR completed for a page
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct OcrCompletedSignal {
    pub page_num: u32,
    pub side: String,
    pub text: String,
    pub confidence: f32,
    pub word_count: u32,
}

/// Signal: Text cleaned
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TextCleanedSignal {
    pub cleaned_text: String,
    pub raw_length: u32,
    pub cleaned_length: u32,
    pub headers_removed: u32,
}

/// Signal: Processing progress update
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ProgressSignal {
    pub current: u32,
    pub total: u32,
    pub message: String,
    pub percentage: f32,
}

/// Signal: Error occurred
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ErrorSignal {
    pub message: String,
    pub code: String,
}
