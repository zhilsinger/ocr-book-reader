// OCR Book Reader — Rust Backend
// Heavy processing: PDF rendering, image splitting, OCR, text cleaning.
// Communicates with Flutter UI via rinf message passing.

pub mod ocr_engine;
pub mod pdf_processor;
pub mod text_cleaner;
pub mod messages;

use rinf::debug_print;

pub fn start_rust_backend() {
    debug_print!("OCR Book Reader backend initialized");
    env_logger::init();
}
