# OCR Book Reader — Beginner's Guide

> **Flutter + Rust Android app for reading scanned books with on-device OCR.**
> No programming experience needed — just follow each step.

---

## What This App Does

You open a scanned book PDF on your Android phone. The app:
1. Detects if pages are two-page spreads and splits them
2. Runs OCR directly on your phone (no internet needed)
3. Shows you the extracted text alongside the original page image
4. Provides three-pass analysis: what happened, what it means, modern comparison
5. Lets you adjust OCR settings for better results

Everything happens on your phone — your books never leave your device.

---

## Before You Start

You need:
- An Android phone or tablet (Android 5.0 or newer)
- About 10 minutes

That's it. The app will be an APK file you install directly.

---

## How to Get the App

### Option A: Download from GitHub (easiest)

1. Go to https://github.com/zhilsinger/ocr-book-reader
2. Click "Actions" at the top
3. Click the latest successful run (look for a green checkmark)
4. Scroll down to "Artifacts"
5. Click "app-debug" to download the APK

### Option B: Build it yourself (if you want to modify the code)

#### Step 1: Install Flutter

1. Go to https://docs.flutter.dev/get-started/install
2. Choose your operating system (Windows, Mac, or Linux)
3. Follow the installation guide
4. Verify it works:
   ```bash
   flutter doctor
   ```

#### Step 2: Download the project

```bash
git clone https://github.com/zhilsinger/ocr-book-reader.git
cd ocr_book_reader
```

#### Step 3: Get the dependencies

```bash
flutter pub get
```

#### Step 4: Build the APK

```bash
flutter build apk --debug
```

The APK will be at: `build/app/outputs/flutter-apk/app-debug.apk`

---

## How to Install the APK on Your Phone

### Method 1: USB transfer

1. Connect your phone to your computer with a USB cable
2. On your phone, swipe down and tap the USB notification
3. Select "File Transfer" or "MTP"
4. On your computer, open your phone's folder
5. Copy the APK file to your phone's Downloads folder
6. On your phone, open the Files app
7. Find the APK and tap it
8. If it says "Install from unknown sources," tap Settings and enable "Allow from this source"
9. Tap Install

### Method 2: Email or messaging

1. Email the APK to yourself (or send it via Telegram/WhatsApp)
2. Open the email on your phone
3. Download the attachment
4. Tap it to install

### Method 3: Cloud storage

1. Upload the APK to Google Drive, Dropbox, or OneDrive
2. Open the cloud app on your phone
3. Download the APK
4. Tap it to install

---

## How to Use the App

### Opening a Book

1. Open the app
2. Tap "Open PDF" (the button at the bottom)
3. Find your scanned book PDF on your phone
4. Tap it to open

### Reading a Book

Once a book is open:
- **Swipe left/right** or tap the arrows to change pages
- **Tap the text icon** (top right) to see the OCR text for the current page
- **Tap the brain icon** to open the Deep Reading panel

### The Deep Reading Panel

The Deep Reading panel has three tabs:

**OCR Text** — Shows the extracted text for the current page. Toggle between "cleaned" (headers removed, fixed) and "raw" (exactly what OCR produced).

**Analysis** — Three-pass chapter analysis:
- **1st Pass**: What happened (events, facts)
- **2nd Pass**: What it means to the author (interpretation, symbols)
- **3rd Pass**: Modern view (what holds up today, what needs caution)

**Reading Map** — Shows the chapter structure: which pages belong to which chapter.

### Adjusting Settings

Tap the gear icon (top right) to open Settings:

| Setting | What It Does | Recommendation |
|---------|-------------|----------------|
| Language | Which language OCR should read | English for most books |
| PSM (Page Segmentation) | How Tesseract interprets page layout | 6 for normal book pages |
| Contrast | How much to enhance the image | 1.4x is usually best |
| Auto-split spreads | Automatically detect and split two-page spreads | Keep ON |
| Strip headers | Remove repeated headers and page numbers | Keep ON |

---

## Understanding the Three-Pass Analysis

This is the same method used to analyze "Journeys into the Bright World":

**Pass 1 — What Happened**: Just the facts. Who was there? What did they do? What dose? What date? Where? No interpretation.

**Pass 2 — What It Means**: The author's interpretation. What symbols do they use? What conclusions do they draw? What metaphors appear?

**Pass 3 — Modern View**: How does this compare to current understanding? What holds up? What needs caution? What risks did they miss?

The key insight: always separate the actual experience from the author's interpretation of that experience.

---

## Troubleshooting

### "App not installed"
- Make sure "Install from unknown sources" is enabled in your phone settings
- The APK might be corrupted — download it again
- Your phone might be too old — Android 5.0 or newer required

### "Parse error — There was a problem parsing the package"
- The APK download was incomplete. Download it again.
- Make sure you have enough storage space.

### OCR produces garbled text
- Try adjusting the PSM setting (try 4 for sparse text, 6 for normal pages, 3 for complex layouts)
- Try increasing contrast to 1.8 or 2.0 for faded text
- Some old books with decorative fonts will always have imperfect OCR — that's normal

### The app crashes when opening a PDF
- The PDF might be too large for your phone's memory
- Try a smaller book first to test
- Close other apps to free up memory

### OCR takes a long time
- OCR runs on-device and doesn't use the internet. It's CPU-intensive.
- Each page takes 2-5 seconds. A 200-page book takes 7-15 minutes.
- Let it run in the background while you do other things.

### "Flutter not found" when building
- Flutter isn't in your PATH. Restart your terminal after installing.
- On Windows: make sure you ran the Flutter installer, not just downloaded it.
- On Mac: try `export PATH="$PATH:/Users/yourname/flutter/bin"`

---

## For Developers — Project Structure

```
ocr_book_reader/
├── lib/                    # Flutter/Dart UI code
│   ├── main.dart           # App entry point
│   ├── screens/            # Home, Reader, Settings screens
│   ├── widgets/            # Reusable UI components
│   ├── services/           # Dart service layer
│   └── messages/           # rinf message stubs
├── rust/                   # Rust backend
│   ├── src/
│   │   ├── lib.rs          # Backend entry
│   │   ├── ocr_engine.rs   # Tesseract OCR via leptess
│   │   ├── pdf_processor.rs # PDF rendering, spread splitting
│   │   ├── text_cleaner.rs  # Header stripping, hyphen repair
│   │   └── messages.rs     # Dart↔Rust message definitions
│   └── Cargo.toml          # Rust dependencies
├── android/                # Android platform files (auto-generated)
├── pubspec.yaml            # Flutter dependencies
└── .github/workflows/      # CI/CD pipeline
```

---

## Quick Reference

```bash
# Download the project
git clone https://github.com/zhilsinger/ocr-book-reader.git
cd ocr_book_reader

# Get dependencies
flutter pub get

# Build Android APK
flutter build apk --debug

# Check for code issues
flutter analyze

# Run tests (when available)
flutter test
```
