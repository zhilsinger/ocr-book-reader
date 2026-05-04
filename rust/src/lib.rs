// OCR Book Reader — Rust Backend
// Heavy processing: PDF rendering, image splitting, OCR, text cleaning.
// Communicates with Flutter UI via rinf message passing.

// Core module — always available
pub mod text_cleaner;

// Modules requiring external C libraries (Tesseract, PDFium, etc.)
// Gate behind feature flag — enabled for Android builds, disabled for CI tests.
#[cfg(feature = "full")]
pub mod ocr_engine;
#[cfg(feature = "full")]
pub mod pdf_processor;
#[cfg(feature = "full")]
pub mod messages;

#[cfg(feature = "full")]
use rinf::debug_print;

pub fn start_rust_backend() {
    #[cfg(feature = "full")]
    {
        debug_print!("OCR Book Reader backend initialized");
        env_logger::init();
    }
    #[cfg(not(feature = "full"))]
    {
        println!("OCR Book Reader — core modules loaded (text_cleaner)");
    }
}
