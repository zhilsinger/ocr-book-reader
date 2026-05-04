// PDF Processor — Render pages, detect spreads, split, extract images.
use image::{DynamicImage, GenericImageView};
use pdf::file::File as PdfFile;
use pdf::page::Page;
use serde::{Deserialize, Serialize};
use std::path::Path;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PageInfo {
    pub page_num: u32,
    pub width: u32,
    pub height: u32,
    pub is_spread: bool,
    pub aspect_ratio: f32,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SplitResult {
    pub page_num: u32,
    pub left_image: Vec<u8>,   // PNG bytes
    pub right_image: Vec<u8>,  // PNG bytes
    pub is_spread: bool,
}

/// Open a PDF and return page count
pub fn open_pdf(path: &str) -> Result<Vec<PageInfo>, String> {
    let file = PdfFile::open(Path::new(path))
        .map_err(|e| format!("Failed to open PDF: {}", e))?;

    let mut pages = Vec::new();
    for (i, page) in file.pages().enumerate() {
        let page = page.map_err(|e| format!("Failed to read page {}: {}", i, e))?;
        if let Some(media_box) = page.media_box() {
            let width = (media_box.width() * 1.0) as u32;
            let height = (media_box.height() * 1.0) as u32;
            let aspect_ratio = width as f32 / height as f32;

            pages.push(PageInfo {
                page_num: i as u32,
                width,
                height,
                is_spread: aspect_ratio > 1.5, // Wide pages are likely spreads
                aspect_ratio,
            });
        }
    }

    Ok(pages)
}

/// Detect if a page is a two-page spread based on aspect ratio
pub fn detect_spread(width: u32, height: u32) -> bool {
    let ratio = width as f32 / height as f32;
    ratio > 1.5 // Wider than 1.5:1 suggests a spread
}

/// Compute crop box to remove margins, headers, and gutter
pub fn compute_crop_box(
    width: u32,
    height: u32,
    is_left: bool,
    is_spread: bool,
) -> (u32, u32, u32, u32) {
    // Default: 4% sides, 5% top/bottom
    let side_crop = (width as f32 * 0.04) as u32;
    let top_crop = (height as f32 * 0.05) as u32;
    let bottom_crop = (height as f32 * 0.95) as u32;
    let right_edge = (width as f32 * 0.96) as u32;

    if !is_spread {
        return (side_crop, top_crop, right_edge - side_crop, bottom_crop - top_crop);
    }

    let mid = width / 2;
    let gutter = (width as f32 * 0.02) as u32;

    if is_left {
        (side_crop, top_crop, mid - gutter - side_crop, bottom_crop - top_crop)
    } else {
        (mid + gutter, top_crop, width - mid - gutter - side_crop, bottom_crop - top_crop)
    }
}

/// Render a page to an image (placeholder — uses pdf crate rendering)
pub fn render_page_image(path: &str, page_num: u32) -> Result<Vec<u8>, String> {
    let file = PdfFile::open(Path::new(path))
        .map_err(|e| format!("Failed to open PDF: {}", e))?;

    // PDF page rendering — the pdf crate can extract page content
    // In production, use pdfium-render or poppler for actual rendering
    let mut pages = file.pages();
    let _page: Page = pages
        .nth(page_num as usize)
        .ok_or("Page not found")?
        .map_err(|e| format!("Page error: {}", e))?;

    // Placeholder — actual rendering requires pdfium or poppler
    // Returns empty PNG for now; replace with real renderer
    let placeholder = vec![0u8; 100];
    Ok(placeholder)
}
