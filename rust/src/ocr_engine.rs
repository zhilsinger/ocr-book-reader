// OCR Engine — Run Tesseract OCR on page images.
// Uses leptess (libtesseract FFI bindings) for native OCR.
use leptess::LepTess;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct OcrResult {
    pub text: String,
    pub confidence: f32,
    pub page_num: u32,
    pub side: String, // "left", "right", "single"
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct OcrConfig {
    pub language: String,
    pub psm: i32,  // Page Segmentation Mode
    pub oem: i32,  // OCR Engine Mode
}

impl Default for OcrConfig {
    fn default() -> Self {
        Self {
            language: "eng".to_string(),
            psm: 6,  // Single uniform block of text
            oem: 3,  // Default engine
        }
    }
}

/// Run OCR on an image buffer (PNG bytes)
pub fn ocr_image(
    image_bytes: &[u8],
    page_num: u32,
    side: &str,
    config: &OcrConfig,
) -> Result<OcrResult, String> {
    let mut lt = LepTess::new(Some("eng"), &config.language)
        .map_err(|e| format!("Failed to initialize Tesseract: {}", e))?;

    lt.set_image_from_mem(image_bytes)
        .map_err(|e| format!("Failed to set image: {}", e))?;

    // Set page segmentation mode
    lt.set_variable("tessedit_pageseg_mode", &config.psm.to_string())
        .ok();

    let text = lt.get_utf8_text()
        .map_err(|e| format!("OCR failed: {}", e))?;

    let confidence = lt.mean_text_confidence() as f32 / 100.0;

    Ok(OcrResult {
        text,
        confidence,
        page_num,
        side: side.to_string(),
    })
}

/// Batch OCR for multiple page images
pub fn ocr_batch(
    images: Vec<(Vec<u8>, u32, String)>, // (image_bytes, page_num, side)
    config: &OcrConfig,
) -> Vec<Result<OcrResult, String>> {
    images
        .into_iter()
        .map(|(img, page, side)| ocr_image(&img, page, &side, config))
        .collect()
}

/// OCR presets for different page types
pub fn config_for_page_type(page_type: &str) -> OcrConfig {
    match page_type {
        "sparse" => OcrConfig { psm: 4, ..Default::default() },
        "column" => OcrConfig { psm: 6, ..Default::default() },
        "single_line" => OcrConfig { psm: 7, ..Default::default() },
        "auto" => OcrConfig { psm: 3, ..Default::default() },
        _ => OcrConfig::default(), // psm 6, oem 3 — best for book pages
    }
}
