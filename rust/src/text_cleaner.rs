// Text Cleaner — Strip headers, fix hyphens, normalize paragraphs.
// Mirrors the Python 05_clean_text.py pipeline logic.
use regex::Regex;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CleanResult {
    pub raw_text: String,
    pub cleaned_text: String,
    pub headers_removed: u32,
    pub page_numbers_removed: u32,
    pub hyphens_fixed: u32,
}

/// Clean OCR text: remove headers, page numbers, fix hyphens, normalize.
pub fn clean_text(
    raw_text: &str,
    headers_to_strip: &[String],
) -> CleanResult {
    let mut headers_removed = 0u32;
    let mut page_numbers_removed = 0u32;

    let page_number_re = Regex::new(r"^\d{1,4}$").unwrap();

    let lines: Vec<&str> = raw_text.lines().collect();
    let mut cleaned: Vec<String> = Vec::new();

    for line in &lines {
        let trimmed = line.trim();

        // Empty lines
        if trimmed.is_empty() {
            cleaned.push(String::new());
            continue;
        }

        // Standalone page numbers
        if page_number_re.is_match(trimmed) {
            page_numbers_removed += 1;
            continue;
        }

        // Running headers
        let lower = trimmed.to_lowercase();
        if headers_to_strip.iter().any(|h| lower.contains(&h.to_lowercase())) {
            headers_removed += 1;
            continue;
        }

        // Short garbage lines
        if trimmed.len() <= 2 && !trimmed.chars().any(|c| c.is_alphabetic()) {
            continue;
        }

        cleaned.push(trimmed.to_string());
    }

    let mut text = cleaned.join("\n");

    // Fix hyphenated line breaks: "pro-\nduce" -> "produce"
    let hyphen_re = Regex::new(r"(\w+)-\n(\w+)").unwrap();
    let hyphens_fixed = hyphen_re.find_iter(&text.clone()).count() as u32;
    text = hyphen_re.replace_all(&text, "$1$2").to_string();

    // Normalize whitespace
    let multi_space = Regex::new(r"[ \t]+").unwrap();
    text = multi_space.replace_all(&text, " ").to_string();

    // Restore paragraph breaks (3+ newlines -> 2)
    let multi_nl = Regex::new(r"\n{3,}").unwrap();
    text = multi_nl.replace_all(&text, "\n\n").to_string();

    CleanResult {
        raw_text: raw_text.to_string(),
        cleaned_text: text.trim().to_string(),
        headers_removed,
        page_numbers_removed,
        hyphens_fixed,
    }
}

/// Default running headers for Journeys into the Bright World
pub fn default_headers() -> Vec<String> {
    vec![
        "Journeys into the Bright World".to_string(),
        "You have to Die to be Reborn".to_string(),
        "To Begin Again".to_string(),
        "The Geography of the Bright World".to_string(),
        "Samadhi Therapy".to_string(),
    ]
}

/// Detect chapter headings in cleaned text
pub fn detect_chapters(text: &str) -> Vec<(usize, String, f32)> {
    let chapter_re = Regex::new(r"^(?:Chapter|CHAPTER)\s+(\d+)[:.]?\s*(.*)").unwrap();
    let number_title_re = Regex::new(r"^(\d+)[:.]\s+(.+)").unwrap();

    let mut chapters = Vec::new();
    for (i, line) in text.lines().enumerate() {
        let trimmed = line.trim();
        if let Some(caps) = chapter_re.captures(trimmed) {
            let title = caps.get(2).map(|m| m.as_str()).unwrap_or("").to_string();
            chapters.push((i, title, 0.95));
        } else if let Some(caps) = number_title_re.captures(trimmed) {
            let title = caps.get(2).map(|m| m.as_str()).unwrap_or("").to_string();
            if title.len() > 3 && title.len() < 80 {
                chapters.push((i, title, 0.8));
            }
        }
    }
    chapters
}
