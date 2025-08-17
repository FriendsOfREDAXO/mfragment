-- ================================================================================
-- GENERISCHES RESPONSIVE MEDIA MANAGER SYSTEM FÜR REDAXO FOR ADDON
-- Neue Namenskonvention: [series]_[ratio]_[modus]_[breakpoint]
-- Minimum (Standard): half_576, half_4x3_1200
-- Maximum: half_max_576, half_4x3_max_1200
-- WebP-Konvertierung: Automatisch für alle Types
-- Datum: 2025-08-13 07:38:31
-- ================================================================================

-- VORBEREITUNG: Temporäre Tabelle für sichere ID-Mapping
DROP TABLE IF EXISTS temp_media_types;
CREATE TEMPORARY TABLE temp_media_types (
    temp_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(191) UNIQUE,
    type_description TEXT,
    type_width INT,
    type_height INT NULL,
    resize_style VARCHAR(20),
    has_ratio BOOLEAN DEFAULT FALSE,
    mode_suffix VARCHAR(10)
);

-- ================================================================================
-- PHASE 1: SAMMLE ALLE TYPES IN TEMPORÄRER TABELLE
-- ================================================================================

INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_320', 'small für Breakpoint 320px (Breite 120px) - Minimum (behält Proportionen, passt in Rahmen)', 120, NULL, 'minimum', FALSE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_max_320', 'small für Breakpoint 320px (Breite 120px) - Maximum (behält Proportionen, füllt Rahmen)', 120, NULL, 'maximum', FALSE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_576', 'small für Breakpoint 576px (Breite 180px) - Minimum (behält Proportionen, passt in Rahmen)', 180, NULL, 'minimum', FALSE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_max_576', 'small für Breakpoint 576px (Breite 180px) - Maximum (behält Proportionen, füllt Rahmen)', 180, NULL, 'maximum', FALSE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_768', 'small für Breakpoint 768px (Breite 240px) - Minimum (behält Proportionen, passt in Rahmen)', 240, NULL, 'minimum', FALSE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_max_768', 'small für Breakpoint 768px (Breite 240px) - Maximum (behält Proportionen, füllt Rahmen)', 240, NULL, 'maximum', FALSE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_320', 'half für Breakpoint 320px (Breite 140px) - Minimum (behält Proportionen, passt in Rahmen)', 140, NULL, 'minimum', FALSE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_max_320', 'half für Breakpoint 320px (Breite 140px) - Maximum (behält Proportionen, füllt Rahmen)', 140, NULL, 'maximum', FALSE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_576', 'half für Breakpoint 576px (Breite 260px) - Minimum (behält Proportionen, passt in Rahmen)', 260, NULL, 'minimum', FALSE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_max_576', 'half für Breakpoint 576px (Breite 260px) - Maximum (behält Proportionen, füllt Rahmen)', 260, NULL, 'maximum', FALSE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_768', 'half für Breakpoint 768px (Breite 360px) - Minimum (behält Proportionen, passt in Rahmen)', 360, NULL, 'minimum', FALSE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_max_768', 'half für Breakpoint 768px (Breite 360px) - Maximum (behält Proportionen, füllt Rahmen)', 360, NULL, 'maximum', FALSE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_992', 'half für Breakpoint 992px (Breite 480px) - Minimum (behält Proportionen, passt in Rahmen)', 480, NULL, 'minimum', FALSE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_max_992', 'half für Breakpoint 992px (Breite 480px) - Maximum (behält Proportionen, füllt Rahmen)', 480, NULL, 'maximum', FALSE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_1200', 'half für Breakpoint 1200px (Breite 570px) - Minimum (behält Proportionen, passt in Rahmen)', 570, NULL, 'minimum', FALSE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_max_1200', 'half für Breakpoint 1200px (Breite 570px) - Maximum (behält Proportionen, füllt Rahmen)', 570, NULL, 'maximum', FALSE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_1400', 'half für Breakpoint 1400px (Breite 670px) - Minimum (behält Proportionen, passt in Rahmen)', 670, NULL, 'minimum', FALSE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_max_1400', 'half für Breakpoint 1400px (Breite 670px) - Maximum (behält Proportionen, füllt Rahmen)', 670, NULL, 'maximum', FALSE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_320', 'full für Breakpoint 320px (Breite 280px) - Minimum (behält Proportionen, passt in Rahmen)', 280, NULL, 'minimum', FALSE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_max_320', 'full für Breakpoint 320px (Breite 280px) - Maximum (behält Proportionen, füllt Rahmen)', 280, NULL, 'maximum', FALSE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_576', 'full für Breakpoint 576px (Breite 520px) - Minimum (behält Proportionen, passt in Rahmen)', 520, NULL, 'minimum', FALSE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_max_576', 'full für Breakpoint 576px (Breite 520px) - Maximum (behält Proportionen, füllt Rahmen)', 520, NULL, 'maximum', FALSE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_768', 'full für Breakpoint 768px (Breite 720px) - Minimum (behält Proportionen, passt in Rahmen)', 720, NULL, 'minimum', FALSE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_max_768', 'full für Breakpoint 768px (Breite 720px) - Maximum (behält Proportionen, füllt Rahmen)', 720, NULL, 'maximum', FALSE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_992', 'full für Breakpoint 992px (Breite 960px) - Minimum (behält Proportionen, passt in Rahmen)', 960, NULL, 'minimum', FALSE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_max_992', 'full für Breakpoint 992px (Breite 960px) - Maximum (behält Proportionen, füllt Rahmen)', 960, NULL, 'maximum', FALSE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_1200', 'full für Breakpoint 1200px (Breite 1140px) - Minimum (behält Proportionen, passt in Rahmen)', 1140, NULL, 'minimum', FALSE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_max_1200', 'full für Breakpoint 1200px (Breite 1140px) - Maximum (behält Proportionen, füllt Rahmen)', 1140, NULL, 'maximum', FALSE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_1400', 'full für Breakpoint 1400px (Breite 1320px) - Minimum (behält Proportionen, passt in Rahmen)', 1320, NULL, 'minimum', FALSE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_max_1400', 'full für Breakpoint 1400px (Breite 1320px) - Maximum (behält Proportionen, füllt Rahmen)', 1320, NULL, 'maximum', FALSE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_768', 'hero für Breakpoint 768px (Breite 768px) - Minimum (behält Proportionen, passt in Rahmen)', 768, NULL, 'minimum', FALSE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_max_768', 'hero für Breakpoint 768px (Breite 768px) - Maximum (behält Proportionen, füllt Rahmen)', 768, NULL, 'maximum', FALSE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_992', 'hero für Breakpoint 992px (Breite 992px) - Minimum (behält Proportionen, passt in Rahmen)', 992, NULL, 'minimum', FALSE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_max_992', 'hero für Breakpoint 992px (Breite 992px) - Maximum (behält Proportionen, füllt Rahmen)', 992, NULL, 'maximum', FALSE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_1200', 'hero für Breakpoint 1200px (Breite 1200px) - Minimum (behält Proportionen, passt in Rahmen)', 1200, NULL, 'minimum', FALSE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_max_1200', 'hero für Breakpoint 1200px (Breite 1200px) - Maximum (behält Proportionen, füllt Rahmen)', 1200, NULL, 'maximum', FALSE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_1400', 'hero für Breakpoint 1400px (Breite 1400px) - Minimum (behält Proportionen, passt in Rahmen)', 1400, NULL, 'minimum', FALSE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_max_1400', 'hero für Breakpoint 1400px (Breite 1400px) - Maximum (behält Proportionen, füllt Rahmen)', 1400, NULL, 'maximum', FALSE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_1920', 'hero für Breakpoint 1920px (Breite 1920px) - Minimum (behält Proportionen, passt in Rahmen)', 1920, NULL, 'minimum', FALSE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_max_1920', 'hero für Breakpoint 1920px (Breite 1920px) - Maximum (behält Proportionen, füllt Rahmen)', 1920, NULL, 'maximum', FALSE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_1x1_320', 'small 1x1 für Breakpoint 320px (120x120) - Minimum (behält Proportionen, passt in Rahmen)', 120, 120, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_1x1_max_320', 'small 1x1 für Breakpoint 320px (120x120) - Maximum (behält Proportionen, füllt Rahmen)', 120, 120, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_1x1_576', 'small 1x1 für Breakpoint 576px (180x180) - Minimum (behält Proportionen, passt in Rahmen)', 180, 180, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_1x1_max_576', 'small 1x1 für Breakpoint 576px (180x180) - Maximum (behält Proportionen, füllt Rahmen)', 180, 180, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_1x1_768', 'small 1x1 für Breakpoint 768px (240x240) - Minimum (behält Proportionen, passt in Rahmen)', 240, 240, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_1x1_max_768', 'small 1x1 für Breakpoint 768px (240x240) - Maximum (behält Proportionen, füllt Rahmen)', 240, 240, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_1x1_320', 'half 1x1 für Breakpoint 320px (140x140) - Minimum (behält Proportionen, passt in Rahmen)', 140, 140, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_1x1_max_320', 'half 1x1 für Breakpoint 320px (140x140) - Maximum (behält Proportionen, füllt Rahmen)', 140, 140, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_1x1_576', 'half 1x1 für Breakpoint 576px (260x260) - Minimum (behält Proportionen, passt in Rahmen)', 260, 260, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_1x1_max_576', 'half 1x1 für Breakpoint 576px (260x260) - Maximum (behält Proportionen, füllt Rahmen)', 260, 260, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_1x1_768', 'half 1x1 für Breakpoint 768px (360x360) - Minimum (behält Proportionen, passt in Rahmen)', 360, 360, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_1x1_max_768', 'half 1x1 für Breakpoint 768px (360x360) - Maximum (behält Proportionen, füllt Rahmen)', 360, 360, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_1x1_992', 'half 1x1 für Breakpoint 992px (480x480) - Minimum (behält Proportionen, passt in Rahmen)', 480, 480, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_1x1_max_992', 'half 1x1 für Breakpoint 992px (480x480) - Maximum (behält Proportionen, füllt Rahmen)', 480, 480, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_1x1_1200', 'half 1x1 für Breakpoint 1200px (570x570) - Minimum (behält Proportionen, passt in Rahmen)', 570, 570, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_1x1_max_1200', 'half 1x1 für Breakpoint 1200px (570x570) - Maximum (behält Proportionen, füllt Rahmen)', 570, 570, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_1x1_1400', 'half 1x1 für Breakpoint 1400px (670x670) - Minimum (behält Proportionen, passt in Rahmen)', 670, 670, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_1x1_max_1400', 'half 1x1 für Breakpoint 1400px (670x670) - Maximum (behält Proportionen, füllt Rahmen)', 670, 670, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_1x1_320', 'full 1x1 für Breakpoint 320px (280x280) - Minimum (behält Proportionen, passt in Rahmen)', 280, 280, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_1x1_max_320', 'full 1x1 für Breakpoint 320px (280x280) - Maximum (behält Proportionen, füllt Rahmen)', 280, 280, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_1x1_576', 'full 1x1 für Breakpoint 576px (520x520) - Minimum (behält Proportionen, passt in Rahmen)', 520, 520, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_1x1_max_576', 'full 1x1 für Breakpoint 576px (520x520) - Maximum (behält Proportionen, füllt Rahmen)', 520, 520, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_1x1_768', 'full 1x1 für Breakpoint 768px (720x720) - Minimum (behält Proportionen, passt in Rahmen)', 720, 720, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_1x1_max_768', 'full 1x1 für Breakpoint 768px (720x720) - Maximum (behält Proportionen, füllt Rahmen)', 720, 720, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_1x1_992', 'full 1x1 für Breakpoint 992px (960x960) - Minimum (behält Proportionen, passt in Rahmen)', 960, 960, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_1x1_max_992', 'full 1x1 für Breakpoint 992px (960x960) - Maximum (behält Proportionen, füllt Rahmen)', 960, 960, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_1x1_1200', 'full 1x1 für Breakpoint 1200px (1140x1140) - Minimum (behält Proportionen, passt in Rahmen)', 1140, 1140, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_1x1_max_1200', 'full 1x1 für Breakpoint 1200px (1140x1140) - Maximum (behält Proportionen, füllt Rahmen)', 1140, 1140, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_1x1_1400', 'full 1x1 für Breakpoint 1400px (1320x1320) - Minimum (behält Proportionen, passt in Rahmen)', 1320, 1320, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_1x1_max_1400', 'full 1x1 für Breakpoint 1400px (1320x1320) - Maximum (behält Proportionen, füllt Rahmen)', 1320, 1320, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_1x1_768', 'hero 1x1 für Breakpoint 768px (768x768) - Minimum (behält Proportionen, passt in Rahmen)', 768, 768, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_1x1_max_768', 'hero 1x1 für Breakpoint 768px (768x768) - Maximum (behält Proportionen, füllt Rahmen)', 768, 768, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_1x1_992', 'hero 1x1 für Breakpoint 992px (992x992) - Minimum (behält Proportionen, passt in Rahmen)', 992, 992, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_1x1_max_992', 'hero 1x1 für Breakpoint 992px (992x992) - Maximum (behält Proportionen, füllt Rahmen)', 992, 992, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_1x1_1200', 'hero 1x1 für Breakpoint 1200px (1200x1200) - Minimum (behält Proportionen, passt in Rahmen)', 1200, 1200, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_1x1_max_1200', 'hero 1x1 für Breakpoint 1200px (1200x1200) - Maximum (behält Proportionen, füllt Rahmen)', 1200, 1200, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_1x1_1400', 'hero 1x1 für Breakpoint 1400px (1400x1400) - Minimum (behält Proportionen, passt in Rahmen)', 1400, 1400, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_1x1_max_1400', 'hero 1x1 für Breakpoint 1400px (1400x1400) - Maximum (behält Proportionen, füllt Rahmen)', 1400, 1400, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_1x1_1920', 'hero 1x1 für Breakpoint 1920px (1920x1920) - Minimum (behält Proportionen, passt in Rahmen)', 1920, 1920, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_1x1_max_1920', 'hero 1x1 für Breakpoint 1920px (1920x1920) - Maximum (behält Proportionen, füllt Rahmen)', 1920, 1920, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_3x2_320', 'small 3x2 für Breakpoint 320px (120x80) - Minimum (behält Proportionen, passt in Rahmen)', 120, 80, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_3x2_max_320', 'small 3x2 für Breakpoint 320px (120x80) - Maximum (behält Proportionen, füllt Rahmen)', 120, 80, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_3x2_576', 'small 3x2 für Breakpoint 576px (180x120) - Minimum (behält Proportionen, passt in Rahmen)', 180, 120, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_3x2_max_576', 'small 3x2 für Breakpoint 576px (180x120) - Maximum (behält Proportionen, füllt Rahmen)', 180, 120, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_3x2_768', 'small 3x2 für Breakpoint 768px (240x160) - Minimum (behält Proportionen, passt in Rahmen)', 240, 160, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_3x2_max_768', 'small 3x2 für Breakpoint 768px (240x160) - Maximum (behält Proportionen, füllt Rahmen)', 240, 160, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_3x2_320', 'half 3x2 für Breakpoint 320px (140x93) - Minimum (behält Proportionen, passt in Rahmen)', 140, 93, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_3x2_max_320', 'half 3x2 für Breakpoint 320px (140x93) - Maximum (behält Proportionen, füllt Rahmen)', 140, 93, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_3x2_576', 'half 3x2 für Breakpoint 576px (260x173) - Minimum (behält Proportionen, passt in Rahmen)', 260, 173, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_3x2_max_576', 'half 3x2 für Breakpoint 576px (260x173) - Maximum (behält Proportionen, füllt Rahmen)', 260, 173, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_3x2_768', 'half 3x2 für Breakpoint 768px (360x240) - Minimum (behält Proportionen, passt in Rahmen)', 360, 240, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_3x2_max_768', 'half 3x2 für Breakpoint 768px (360x240) - Maximum (behält Proportionen, füllt Rahmen)', 360, 240, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_3x2_992', 'half 3x2 für Breakpoint 992px (480x320) - Minimum (behält Proportionen, passt in Rahmen)', 480, 320, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_3x2_max_992', 'half 3x2 für Breakpoint 992px (480x320) - Maximum (behält Proportionen, füllt Rahmen)', 480, 320, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_3x2_1200', 'half 3x2 für Breakpoint 1200px (570x380) - Minimum (behält Proportionen, passt in Rahmen)', 570, 380, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_3x2_max_1200', 'half 3x2 für Breakpoint 1200px (570x380) - Maximum (behält Proportionen, füllt Rahmen)', 570, 380, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_3x2_1400', 'half 3x2 für Breakpoint 1400px (670x447) - Minimum (behält Proportionen, passt in Rahmen)', 670, 447, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_3x2_max_1400', 'half 3x2 für Breakpoint 1400px (670x447) - Maximum (behält Proportionen, füllt Rahmen)', 670, 447, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_3x2_320', 'full 3x2 für Breakpoint 320px (280x187) - Minimum (behält Proportionen, passt in Rahmen)', 280, 187, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_3x2_max_320', 'full 3x2 für Breakpoint 320px (280x187) - Maximum (behält Proportionen, füllt Rahmen)', 280, 187, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_3x2_576', 'full 3x2 für Breakpoint 576px (520x347) - Minimum (behält Proportionen, passt in Rahmen)', 520, 347, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_3x2_max_576', 'full 3x2 für Breakpoint 576px (520x347) - Maximum (behält Proportionen, füllt Rahmen)', 520, 347, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_3x2_768', 'full 3x2 für Breakpoint 768px (720x480) - Minimum (behält Proportionen, passt in Rahmen)', 720, 480, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_3x2_max_768', 'full 3x2 für Breakpoint 768px (720x480) - Maximum (behält Proportionen, füllt Rahmen)', 720, 480, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_3x2_992', 'full 3x2 für Breakpoint 992px (960x640) - Minimum (behält Proportionen, passt in Rahmen)', 960, 640, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_3x2_max_992', 'full 3x2 für Breakpoint 992px (960x640) - Maximum (behält Proportionen, füllt Rahmen)', 960, 640, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_3x2_1200', 'full 3x2 für Breakpoint 1200px (1140x760) - Minimum (behält Proportionen, passt in Rahmen)', 1140, 760, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_3x2_max_1200', 'full 3x2 für Breakpoint 1200px (1140x760) - Maximum (behält Proportionen, füllt Rahmen)', 1140, 760, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_3x2_1400', 'full 3x2 für Breakpoint 1400px (1320x880) - Minimum (behält Proportionen, passt in Rahmen)', 1320, 880, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_3x2_max_1400', 'full 3x2 für Breakpoint 1400px (1320x880) - Maximum (behält Proportionen, füllt Rahmen)', 1320, 880, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_3x2_768', 'hero 3x2 für Breakpoint 768px (768x512) - Minimum (behält Proportionen, passt in Rahmen)', 768, 512, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_3x2_max_768', 'hero 3x2 für Breakpoint 768px (768x512) - Maximum (behält Proportionen, füllt Rahmen)', 768, 512, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_3x2_992', 'hero 3x2 für Breakpoint 992px (992x661) - Minimum (behält Proportionen, passt in Rahmen)', 992, 661, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_3x2_max_992', 'hero 3x2 für Breakpoint 992px (992x661) - Maximum (behält Proportionen, füllt Rahmen)', 992, 661, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_3x2_1200', 'hero 3x2 für Breakpoint 1200px (1200x800) - Minimum (behält Proportionen, passt in Rahmen)', 1200, 800, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_3x2_max_1200', 'hero 3x2 für Breakpoint 1200px (1200x800) - Maximum (behält Proportionen, füllt Rahmen)', 1200, 800, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_3x2_1400', 'hero 3x2 für Breakpoint 1400px (1400x933) - Minimum (behält Proportionen, passt in Rahmen)', 1400, 933, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_3x2_max_1400', 'hero 3x2 für Breakpoint 1400px (1400x933) - Maximum (behält Proportionen, füllt Rahmen)', 1400, 933, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_3x2_1920', 'hero 3x2 für Breakpoint 1920px (1920x1280) - Minimum (behält Proportionen, passt in Rahmen)', 1920, 1280, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_3x2_max_1920', 'hero 3x2 für Breakpoint 1920px (1920x1280) - Maximum (behält Proportionen, füllt Rahmen)', 1920, 1280, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_4x3_320', 'small 4x3 für Breakpoint 320px (120x90) - Minimum (behält Proportionen, passt in Rahmen)', 120, 90, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_4x3_max_320', 'small 4x3 für Breakpoint 320px (120x90) - Maximum (behält Proportionen, füllt Rahmen)', 120, 90, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_4x3_576', 'small 4x3 für Breakpoint 576px (180x135) - Minimum (behält Proportionen, passt in Rahmen)', 180, 135, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_4x3_max_576', 'small 4x3 für Breakpoint 576px (180x135) - Maximum (behält Proportionen, füllt Rahmen)', 180, 135, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_4x3_768', 'small 4x3 für Breakpoint 768px (240x180) - Minimum (behält Proportionen, passt in Rahmen)', 240, 180, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_4x3_max_768', 'small 4x3 für Breakpoint 768px (240x180) - Maximum (behält Proportionen, füllt Rahmen)', 240, 180, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_4x3_320', 'half 4x3 für Breakpoint 320px (140x105) - Minimum (behält Proportionen, passt in Rahmen)', 140, 105, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_4x3_max_320', 'half 4x3 für Breakpoint 320px (140x105) - Maximum (behält Proportionen, füllt Rahmen)', 140, 105, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_4x3_576', 'half 4x3 für Breakpoint 576px (260x195) - Minimum (behält Proportionen, passt in Rahmen)', 260, 195, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_4x3_max_576', 'half 4x3 für Breakpoint 576px (260x195) - Maximum (behält Proportionen, füllt Rahmen)', 260, 195, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_4x3_768', 'half 4x3 für Breakpoint 768px (360x270) - Minimum (behält Proportionen, passt in Rahmen)', 360, 270, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_4x3_max_768', 'half 4x3 für Breakpoint 768px (360x270) - Maximum (behält Proportionen, füllt Rahmen)', 360, 270, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_4x3_992', 'half 4x3 für Breakpoint 992px (480x360) - Minimum (behält Proportionen, passt in Rahmen)', 480, 360, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_4x3_max_992', 'half 4x3 für Breakpoint 992px (480x360) - Maximum (behält Proportionen, füllt Rahmen)', 480, 360, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_4x3_1200', 'half 4x3 für Breakpoint 1200px (570x428) - Minimum (behält Proportionen, passt in Rahmen)', 570, 428, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_4x3_max_1200', 'half 4x3 für Breakpoint 1200px (570x428) - Maximum (behält Proportionen, füllt Rahmen)', 570, 428, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_4x3_1400', 'half 4x3 für Breakpoint 1400px (670x503) - Minimum (behält Proportionen, passt in Rahmen)', 670, 503, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_4x3_max_1400', 'half 4x3 für Breakpoint 1400px (670x503) - Maximum (behält Proportionen, füllt Rahmen)', 670, 503, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_4x3_320', 'full 4x3 für Breakpoint 320px (280x210) - Minimum (behält Proportionen, passt in Rahmen)', 280, 210, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_4x3_max_320', 'full 4x3 für Breakpoint 320px (280x210) - Maximum (behält Proportionen, füllt Rahmen)', 280, 210, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_4x3_576', 'full 4x3 für Breakpoint 576px (520x390) - Minimum (behält Proportionen, passt in Rahmen)', 520, 390, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_4x3_max_576', 'full 4x3 für Breakpoint 576px (520x390) - Maximum (behält Proportionen, füllt Rahmen)', 520, 390, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_4x3_768', 'full 4x3 für Breakpoint 768px (720x540) - Minimum (behält Proportionen, passt in Rahmen)', 720, 540, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_4x3_max_768', 'full 4x3 für Breakpoint 768px (720x540) - Maximum (behält Proportionen, füllt Rahmen)', 720, 540, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_4x3_992', 'full 4x3 für Breakpoint 992px (960x720) - Minimum (behält Proportionen, passt in Rahmen)', 960, 720, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_4x3_max_992', 'full 4x3 für Breakpoint 992px (960x720) - Maximum (behält Proportionen, füllt Rahmen)', 960, 720, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_4x3_1200', 'full 4x3 für Breakpoint 1200px (1140x855) - Minimum (behält Proportionen, passt in Rahmen)', 1140, 855, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_4x3_max_1200', 'full 4x3 für Breakpoint 1200px (1140x855) - Maximum (behält Proportionen, füllt Rahmen)', 1140, 855, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_4x3_1400', 'full 4x3 für Breakpoint 1400px (1320x990) - Minimum (behält Proportionen, passt in Rahmen)', 1320, 990, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_4x3_max_1400', 'full 4x3 für Breakpoint 1400px (1320x990) - Maximum (behält Proportionen, füllt Rahmen)', 1320, 990, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_4x3_768', 'hero 4x3 für Breakpoint 768px (768x576) - Minimum (behält Proportionen, passt in Rahmen)', 768, 576, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_4x3_max_768', 'hero 4x3 für Breakpoint 768px (768x576) - Maximum (behält Proportionen, füllt Rahmen)', 768, 576, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_4x3_992', 'hero 4x3 für Breakpoint 992px (992x744) - Minimum (behält Proportionen, passt in Rahmen)', 992, 744, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_4x3_max_992', 'hero 4x3 für Breakpoint 992px (992x744) - Maximum (behält Proportionen, füllt Rahmen)', 992, 744, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_4x3_1200', 'hero 4x3 für Breakpoint 1200px (1200x900) - Minimum (behält Proportionen, passt in Rahmen)', 1200, 900, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_4x3_max_1200', 'hero 4x3 für Breakpoint 1200px (1200x900) - Maximum (behält Proportionen, füllt Rahmen)', 1200, 900, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_4x3_1400', 'hero 4x3 für Breakpoint 1400px (1400x1050) - Minimum (behält Proportionen, passt in Rahmen)', 1400, 1050, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_4x3_max_1400', 'hero 4x3 für Breakpoint 1400px (1400x1050) - Maximum (behält Proportionen, füllt Rahmen)', 1400, 1050, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_4x3_1920', 'hero 4x3 für Breakpoint 1920px (1920x1440) - Minimum (behält Proportionen, passt in Rahmen)', 1920, 1440, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_4x3_max_1920', 'hero 4x3 für Breakpoint 1920px (1920x1440) - Maximum (behält Proportionen, füllt Rahmen)', 1920, 1440, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_5x2_320', 'small 5x2 für Breakpoint 320px (120x48) - Minimum (behält Proportionen, passt in Rahmen)', 120, 48, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_5x2_max_320', 'small 5x2 für Breakpoint 320px (120x48) - Maximum (behält Proportionen, füllt Rahmen)', 120, 48, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_5x2_576', 'small 5x2 für Breakpoint 576px (180x72) - Minimum (behält Proportionen, passt in Rahmen)', 180, 72, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_5x2_max_576', 'small 5x2 für Breakpoint 576px (180x72) - Maximum (behält Proportionen, füllt Rahmen)', 180, 72, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_5x2_768', 'small 5x2 für Breakpoint 768px (240x96) - Minimum (behält Proportionen, passt in Rahmen)', 240, 96, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_5x2_max_768', 'small 5x2 für Breakpoint 768px (240x96) - Maximum (behält Proportionen, füllt Rahmen)', 240, 96, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_5x2_320', 'half 5x2 für Breakpoint 320px (140x56) - Minimum (behält Proportionen, passt in Rahmen)', 140, 56, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_5x2_max_320', 'half 5x2 für Breakpoint 320px (140x56) - Maximum (behält Proportionen, füllt Rahmen)', 140, 56, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_5x2_576', 'half 5x2 für Breakpoint 576px (260x104) - Minimum (behält Proportionen, passt in Rahmen)', 260, 104, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_5x2_max_576', 'half 5x2 für Breakpoint 576px (260x104) - Maximum (behält Proportionen, füllt Rahmen)', 260, 104, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_5x2_768', 'half 5x2 für Breakpoint 768px (360x144) - Minimum (behält Proportionen, passt in Rahmen)', 360, 144, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_5x2_max_768', 'half 5x2 für Breakpoint 768px (360x144) - Maximum (behält Proportionen, füllt Rahmen)', 360, 144, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_5x2_992', 'half 5x2 für Breakpoint 992px (480x192) - Minimum (behält Proportionen, passt in Rahmen)', 480, 192, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_5x2_max_992', 'half 5x2 für Breakpoint 992px (480x192) - Maximum (behält Proportionen, füllt Rahmen)', 480, 192, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_5x2_1200', 'half 5x2 für Breakpoint 1200px (570x228) - Minimum (behält Proportionen, passt in Rahmen)', 570, 228, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_5x2_max_1200', 'half 5x2 für Breakpoint 1200px (570x228) - Maximum (behält Proportionen, füllt Rahmen)', 570, 228, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_5x2_1400', 'half 5x2 für Breakpoint 1400px (670x268) - Minimum (behält Proportionen, passt in Rahmen)', 670, 268, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_5x2_max_1400', 'half 5x2 für Breakpoint 1400px (670x268) - Maximum (behält Proportionen, füllt Rahmen)', 670, 268, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_5x2_320', 'full 5x2 für Breakpoint 320px (280x112) - Minimum (behält Proportionen, passt in Rahmen)', 280, 112, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_5x2_max_320', 'full 5x2 für Breakpoint 320px (280x112) - Maximum (behält Proportionen, füllt Rahmen)', 280, 112, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_5x2_576', 'full 5x2 für Breakpoint 576px (520x208) - Minimum (behält Proportionen, passt in Rahmen)', 520, 208, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_5x2_max_576', 'full 5x2 für Breakpoint 576px (520x208) - Maximum (behält Proportionen, füllt Rahmen)', 520, 208, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_5x2_768', 'full 5x2 für Breakpoint 768px (720x288) - Minimum (behält Proportionen, passt in Rahmen)', 720, 288, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_5x2_max_768', 'full 5x2 für Breakpoint 768px (720x288) - Maximum (behält Proportionen, füllt Rahmen)', 720, 288, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_5x2_992', 'full 5x2 für Breakpoint 992px (960x384) - Minimum (behält Proportionen, passt in Rahmen)', 960, 384, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_5x2_max_992', 'full 5x2 für Breakpoint 992px (960x384) - Maximum (behält Proportionen, füllt Rahmen)', 960, 384, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_5x2_1200', 'full 5x2 für Breakpoint 1200px (1140x456) - Minimum (behält Proportionen, passt in Rahmen)', 1140, 456, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_5x2_max_1200', 'full 5x2 für Breakpoint 1200px (1140x456) - Maximum (behält Proportionen, füllt Rahmen)', 1140, 456, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_5x2_1400', 'full 5x2 für Breakpoint 1400px (1320x528) - Minimum (behält Proportionen, passt in Rahmen)', 1320, 528, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_5x2_max_1400', 'full 5x2 für Breakpoint 1400px (1320x528) - Maximum (behält Proportionen, füllt Rahmen)', 1320, 528, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_5x2_768', 'hero 5x2 für Breakpoint 768px (768x307) - Minimum (behält Proportionen, passt in Rahmen)', 768, 307, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_5x2_max_768', 'hero 5x2 für Breakpoint 768px (768x307) - Maximum (behält Proportionen, füllt Rahmen)', 768, 307, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_5x2_992', 'hero 5x2 für Breakpoint 992px (992x397) - Minimum (behält Proportionen, passt in Rahmen)', 992, 397, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_5x2_max_992', 'hero 5x2 für Breakpoint 992px (992x397) - Maximum (behält Proportionen, füllt Rahmen)', 992, 397, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_5x2_1200', 'hero 5x2 für Breakpoint 1200px (1200x480) - Minimum (behält Proportionen, passt in Rahmen)', 1200, 480, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_5x2_max_1200', 'hero 5x2 für Breakpoint 1200px (1200x480) - Maximum (behält Proportionen, füllt Rahmen)', 1200, 480, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_5x2_1400', 'hero 5x2 für Breakpoint 1400px (1400x560) - Minimum (behält Proportionen, passt in Rahmen)', 1400, 560, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_5x2_max_1400', 'hero 5x2 für Breakpoint 1400px (1400x560) - Maximum (behält Proportionen, füllt Rahmen)', 1400, 560, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_5x2_1920', 'hero 5x2 für Breakpoint 1920px (1920x768) - Minimum (behält Proportionen, passt in Rahmen)', 1920, 768, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_5x2_max_1920', 'hero 5x2 für Breakpoint 1920px (1920x768) - Maximum (behält Proportionen, füllt Rahmen)', 1920, 768, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_4x1_320', 'small 4x1 für Breakpoint 320px (120x30) - Minimum (behält Proportionen, passt in Rahmen)', 120, 30, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_4x1_max_320', 'small 4x1 für Breakpoint 320px (120x30) - Maximum (behält Proportionen, füllt Rahmen)', 120, 30, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_4x1_576', 'small 4x1 für Breakpoint 576px (180x45) - Minimum (behält Proportionen, passt in Rahmen)', 180, 45, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_4x1_max_576', 'small 4x1 für Breakpoint 576px (180x45) - Maximum (behält Proportionen, füllt Rahmen)', 180, 45, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_4x1_768', 'small 4x1 für Breakpoint 768px (240x60) - Minimum (behält Proportionen, passt in Rahmen)', 240, 60, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_4x1_max_768', 'small 4x1 für Breakpoint 768px (240x60) - Maximum (behält Proportionen, füllt Rahmen)', 240, 60, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_4x1_320', 'half 4x1 für Breakpoint 320px (140x35) - Minimum (behält Proportionen, passt in Rahmen)', 140, 35, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_4x1_max_320', 'half 4x1 für Breakpoint 320px (140x35) - Maximum (behält Proportionen, füllt Rahmen)', 140, 35, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_4x1_576', 'half 4x1 für Breakpoint 576px (260x65) - Minimum (behält Proportionen, passt in Rahmen)', 260, 65, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_4x1_max_576', 'half 4x1 für Breakpoint 576px (260x65) - Maximum (behält Proportionen, füllt Rahmen)', 260, 65, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_4x1_768', 'half 4x1 für Breakpoint 768px (360x90) - Minimum (behält Proportionen, passt in Rahmen)', 360, 90, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_4x1_max_768', 'half 4x1 für Breakpoint 768px (360x90) - Maximum (behält Proportionen, füllt Rahmen)', 360, 90, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_4x1_992', 'half 4x1 für Breakpoint 992px (480x120) - Minimum (behält Proportionen, passt in Rahmen)', 480, 120, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_4x1_max_992', 'half 4x1 für Breakpoint 992px (480x120) - Maximum (behält Proportionen, füllt Rahmen)', 480, 120, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_4x1_1200', 'half 4x1 für Breakpoint 1200px (570x143) - Minimum (behält Proportionen, passt in Rahmen)', 570, 143, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_4x1_max_1200', 'half 4x1 für Breakpoint 1200px (570x143) - Maximum (behält Proportionen, füllt Rahmen)', 570, 143, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_4x1_1400', 'half 4x1 für Breakpoint 1400px (670x168) - Minimum (behält Proportionen, passt in Rahmen)', 670, 168, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_4x1_max_1400', 'half 4x1 für Breakpoint 1400px (670x168) - Maximum (behält Proportionen, füllt Rahmen)', 670, 168, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_4x1_320', 'full 4x1 für Breakpoint 320px (280x70) - Minimum (behält Proportionen, passt in Rahmen)', 280, 70, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_4x1_max_320', 'full 4x1 für Breakpoint 320px (280x70) - Maximum (behält Proportionen, füllt Rahmen)', 280, 70, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_4x1_576', 'full 4x1 für Breakpoint 576px (520x130) - Minimum (behält Proportionen, passt in Rahmen)', 520, 130, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_4x1_max_576', 'full 4x1 für Breakpoint 576px (520x130) - Maximum (behält Proportionen, füllt Rahmen)', 520, 130, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_4x1_768', 'full 4x1 für Breakpoint 768px (720x180) - Minimum (behält Proportionen, passt in Rahmen)', 720, 180, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_4x1_max_768', 'full 4x1 für Breakpoint 768px (720x180) - Maximum (behält Proportionen, füllt Rahmen)', 720, 180, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_4x1_992', 'full 4x1 für Breakpoint 992px (960x240) - Minimum (behält Proportionen, passt in Rahmen)', 960, 240, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_4x1_max_992', 'full 4x1 für Breakpoint 992px (960x240) - Maximum (behält Proportionen, füllt Rahmen)', 960, 240, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_4x1_1200', 'full 4x1 für Breakpoint 1200px (1140x285) - Minimum (behält Proportionen, passt in Rahmen)', 1140, 285, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_4x1_max_1200', 'full 4x1 für Breakpoint 1200px (1140x285) - Maximum (behält Proportionen, füllt Rahmen)', 1140, 285, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_4x1_1400', 'full 4x1 für Breakpoint 1400px (1320x330) - Minimum (behält Proportionen, passt in Rahmen)', 1320, 330, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_4x1_max_1400', 'full 4x1 für Breakpoint 1400px (1320x330) - Maximum (behält Proportionen, füllt Rahmen)', 1320, 330, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_4x1_768', 'hero 4x1 für Breakpoint 768px (768x192) - Minimum (behält Proportionen, passt in Rahmen)', 768, 192, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_4x1_max_768', 'hero 4x1 für Breakpoint 768px (768x192) - Maximum (behält Proportionen, füllt Rahmen)', 768, 192, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_4x1_992', 'hero 4x1 für Breakpoint 992px (992x248) - Minimum (behält Proportionen, passt in Rahmen)', 992, 248, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_4x1_max_992', 'hero 4x1 für Breakpoint 992px (992x248) - Maximum (behält Proportionen, füllt Rahmen)', 992, 248, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_4x1_1200', 'hero 4x1 für Breakpoint 1200px (1200x300) - Minimum (behält Proportionen, passt in Rahmen)', 1200, 300, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_4x1_max_1200', 'hero 4x1 für Breakpoint 1200px (1200x300) - Maximum (behält Proportionen, füllt Rahmen)', 1200, 300, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_4x1_1400', 'hero 4x1 für Breakpoint 1400px (1400x350) - Minimum (behält Proportionen, passt in Rahmen)', 1400, 350, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_4x1_max_1400', 'hero 4x1 für Breakpoint 1400px (1400x350) - Maximum (behält Proportionen, füllt Rahmen)', 1400, 350, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_4x1_1920', 'hero 4x1 für Breakpoint 1920px (1920x480) - Minimum (behält Proportionen, passt in Rahmen)', 1920, 480, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_4x1_max_1920', 'hero 4x1 für Breakpoint 1920px (1920x480) - Maximum (behält Proportionen, füllt Rahmen)', 1920, 480, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_2x1_320', 'small 2x1 für Breakpoint 320px (120x60) - Minimum (behält Proportionen, passt in Rahmen)', 120, 60, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_2x1_max_320', 'small 2x1 für Breakpoint 320px (120x60) - Maximum (behält Proportionen, füllt Rahmen)', 120, 60, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_2x1_576', 'small 2x1 für Breakpoint 576px (180x90) - Minimum (behält Proportionen, passt in Rahmen)', 180, 90, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_2x1_max_576', 'small 2x1 für Breakpoint 576px (180x90) - Maximum (behält Proportionen, füllt Rahmen)', 180, 90, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_2x1_768', 'small 2x1 für Breakpoint 768px (240x120) - Minimum (behält Proportionen, passt in Rahmen)', 240, 120, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_2x1_max_768', 'small 2x1 für Breakpoint 768px (240x120) - Maximum (behält Proportionen, füllt Rahmen)', 240, 120, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_2x1_320', 'half 2x1 für Breakpoint 320px (140x70) - Minimum (behält Proportionen, passt in Rahmen)', 140, 70, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_2x1_max_320', 'half 2x1 für Breakpoint 320px (140x70) - Maximum (behält Proportionen, füllt Rahmen)', 140, 70, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_2x1_576', 'half 2x1 für Breakpoint 576px (260x130) - Minimum (behält Proportionen, passt in Rahmen)', 260, 130, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_2x1_max_576', 'half 2x1 für Breakpoint 576px (260x130) - Maximum (behält Proportionen, füllt Rahmen)', 260, 130, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_2x1_768', 'half 2x1 für Breakpoint 768px (360x180) - Minimum (behält Proportionen, passt in Rahmen)', 360, 180, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_2x1_max_768', 'half 2x1 für Breakpoint 768px (360x180) - Maximum (behält Proportionen, füllt Rahmen)', 360, 180, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_2x1_992', 'half 2x1 für Breakpoint 992px (480x240) - Minimum (behält Proportionen, passt in Rahmen)', 480, 240, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_2x1_max_992', 'half 2x1 für Breakpoint 992px (480x240) - Maximum (behält Proportionen, füllt Rahmen)', 480, 240, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_2x1_1200', 'half 2x1 für Breakpoint 1200px (570x285) - Minimum (behält Proportionen, passt in Rahmen)', 570, 285, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_2x1_max_1200', 'half 2x1 für Breakpoint 1200px (570x285) - Maximum (behält Proportionen, füllt Rahmen)', 570, 285, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_2x1_1400', 'half 2x1 für Breakpoint 1400px (670x335) - Minimum (behält Proportionen, passt in Rahmen)', 670, 335, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_2x1_max_1400', 'half 2x1 für Breakpoint 1400px (670x335) - Maximum (behält Proportionen, füllt Rahmen)', 670, 335, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_2x1_320', 'full 2x1 für Breakpoint 320px (280x140) - Minimum (behält Proportionen, passt in Rahmen)', 280, 140, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_2x1_max_320', 'full 2x1 für Breakpoint 320px (280x140) - Maximum (behält Proportionen, füllt Rahmen)', 280, 140, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_2x1_576', 'full 2x1 für Breakpoint 576px (520x260) - Minimum (behält Proportionen, passt in Rahmen)', 520, 260, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_2x1_max_576', 'full 2x1 für Breakpoint 576px (520x260) - Maximum (behält Proportionen, füllt Rahmen)', 520, 260, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_2x1_768', 'full 2x1 für Breakpoint 768px (720x360) - Minimum (behält Proportionen, passt in Rahmen)', 720, 360, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_2x1_max_768', 'full 2x1 für Breakpoint 768px (720x360) - Maximum (behält Proportionen, füllt Rahmen)', 720, 360, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_2x1_992', 'full 2x1 für Breakpoint 992px (960x480) - Minimum (behält Proportionen, passt in Rahmen)', 960, 480, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_2x1_max_992', 'full 2x1 für Breakpoint 992px (960x480) - Maximum (behält Proportionen, füllt Rahmen)', 960, 480, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_2x1_1200', 'full 2x1 für Breakpoint 1200px (1140x570) - Minimum (behält Proportionen, passt in Rahmen)', 1140, 570, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_2x1_max_1200', 'full 2x1 für Breakpoint 1200px (1140x570) - Maximum (behält Proportionen, füllt Rahmen)', 1140, 570, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_2x1_1400', 'full 2x1 für Breakpoint 1400px (1320x660) - Minimum (behält Proportionen, passt in Rahmen)', 1320, 660, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_2x1_max_1400', 'full 2x1 für Breakpoint 1400px (1320x660) - Maximum (behält Proportionen, füllt Rahmen)', 1320, 660, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_2x1_768', 'hero 2x1 für Breakpoint 768px (768x384) - Minimum (behält Proportionen, passt in Rahmen)', 768, 384, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_2x1_max_768', 'hero 2x1 für Breakpoint 768px (768x384) - Maximum (behält Proportionen, füllt Rahmen)', 768, 384, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_2x1_992', 'hero 2x1 für Breakpoint 992px (992x496) - Minimum (behält Proportionen, passt in Rahmen)', 992, 496, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_2x1_max_992', 'hero 2x1 für Breakpoint 992px (992x496) - Maximum (behält Proportionen, füllt Rahmen)', 992, 496, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_2x1_1200', 'hero 2x1 für Breakpoint 1200px (1200x600) - Minimum (behält Proportionen, passt in Rahmen)', 1200, 600, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_2x1_max_1200', 'hero 2x1 für Breakpoint 1200px (1200x600) - Maximum (behält Proportionen, füllt Rahmen)', 1200, 600, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_2x1_1400', 'hero 2x1 für Breakpoint 1400px (1400x700) - Minimum (behält Proportionen, passt in Rahmen)', 1400, 700, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_2x1_max_1400', 'hero 2x1 für Breakpoint 1400px (1400x700) - Maximum (behält Proportionen, füllt Rahmen)', 1400, 700, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_2x1_1920', 'hero 2x1 für Breakpoint 1920px (1920x960) - Minimum (behält Proportionen, passt in Rahmen)', 1920, 960, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_2x1_max_1920', 'hero 2x1 für Breakpoint 1920px (1920x960) - Maximum (behält Proportionen, füllt Rahmen)', 1920, 960, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_16x9_320', 'small 16x9 für Breakpoint 320px (120x68) - Minimum (behält Proportionen, passt in Rahmen)', 120, 68, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_16x9_max_320', 'small 16x9 für Breakpoint 320px (120x68) - Maximum (behält Proportionen, füllt Rahmen)', 120, 68, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_16x9_576', 'small 16x9 für Breakpoint 576px (180x101) - Minimum (behält Proportionen, passt in Rahmen)', 180, 101, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_16x9_max_576', 'small 16x9 für Breakpoint 576px (180x101) - Maximum (behält Proportionen, füllt Rahmen)', 180, 101, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_16x9_768', 'small 16x9 für Breakpoint 768px (240x135) - Minimum (behält Proportionen, passt in Rahmen)', 240, 135, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_16x9_max_768', 'small 16x9 für Breakpoint 768px (240x135) - Maximum (behält Proportionen, füllt Rahmen)', 240, 135, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_16x9_320', 'half 16x9 für Breakpoint 320px (140x79) - Minimum (behält Proportionen, passt in Rahmen)', 140, 79, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_16x9_max_320', 'half 16x9 für Breakpoint 320px (140x79) - Maximum (behält Proportionen, füllt Rahmen)', 140, 79, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_16x9_576', 'half 16x9 für Breakpoint 576px (260x146) - Minimum (behält Proportionen, passt in Rahmen)', 260, 146, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_16x9_max_576', 'half 16x9 für Breakpoint 576px (260x146) - Maximum (behält Proportionen, füllt Rahmen)', 260, 146, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_16x9_768', 'half 16x9 für Breakpoint 768px (360x203) - Minimum (behält Proportionen, passt in Rahmen)', 360, 203, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_16x9_max_768', 'half 16x9 für Breakpoint 768px (360x203) - Maximum (behält Proportionen, füllt Rahmen)', 360, 203, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_16x9_992', 'half 16x9 für Breakpoint 992px (480x270) - Minimum (behält Proportionen, passt in Rahmen)', 480, 270, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_16x9_max_992', 'half 16x9 für Breakpoint 992px (480x270) - Maximum (behält Proportionen, füllt Rahmen)', 480, 270, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_16x9_1200', 'half 16x9 für Breakpoint 1200px (570x321) - Minimum (behält Proportionen, passt in Rahmen)', 570, 321, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_16x9_max_1200', 'half 16x9 für Breakpoint 1200px (570x321) - Maximum (behält Proportionen, füllt Rahmen)', 570, 321, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_16x9_1400', 'half 16x9 für Breakpoint 1400px (670x377) - Minimum (behält Proportionen, passt in Rahmen)', 670, 377, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_16x9_max_1400', 'half 16x9 für Breakpoint 1400px (670x377) - Maximum (behält Proportionen, füllt Rahmen)', 670, 377, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_16x9_320', 'full 16x9 für Breakpoint 320px (280x158) - Minimum (behält Proportionen, passt in Rahmen)', 280, 158, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_16x9_max_320', 'full 16x9 für Breakpoint 320px (280x158) - Maximum (behält Proportionen, füllt Rahmen)', 280, 158, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_16x9_576', 'full 16x9 für Breakpoint 576px (520x293) - Minimum (behält Proportionen, passt in Rahmen)', 520, 293, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_16x9_max_576', 'full 16x9 für Breakpoint 576px (520x293) - Maximum (behält Proportionen, füllt Rahmen)', 520, 293, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_16x9_768', 'full 16x9 für Breakpoint 768px (720x405) - Minimum (behält Proportionen, passt in Rahmen)', 720, 405, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_16x9_max_768', 'full 16x9 für Breakpoint 768px (720x405) - Maximum (behält Proportionen, füllt Rahmen)', 720, 405, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_16x9_992', 'full 16x9 für Breakpoint 992px (960x540) - Minimum (behält Proportionen, passt in Rahmen)', 960, 540, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_16x9_max_992', 'full 16x9 für Breakpoint 992px (960x540) - Maximum (behält Proportionen, füllt Rahmen)', 960, 540, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_16x9_1200', 'full 16x9 für Breakpoint 1200px (1140x641) - Minimum (behält Proportionen, passt in Rahmen)', 1140, 641, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_16x9_max_1200', 'full 16x9 für Breakpoint 1200px (1140x641) - Maximum (behält Proportionen, füllt Rahmen)', 1140, 641, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_16x9_1400', 'full 16x9 für Breakpoint 1400px (1320x743) - Minimum (behält Proportionen, passt in Rahmen)', 1320, 743, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_16x9_max_1400', 'full 16x9 für Breakpoint 1400px (1320x743) - Maximum (behält Proportionen, füllt Rahmen)', 1320, 743, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_16x9_768', 'hero 16x9 für Breakpoint 768px (768x432) - Minimum (behält Proportionen, passt in Rahmen)', 768, 432, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_16x9_max_768', 'hero 16x9 für Breakpoint 768px (768x432) - Maximum (behält Proportionen, füllt Rahmen)', 768, 432, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_16x9_992', 'hero 16x9 für Breakpoint 992px (992x558) - Minimum (behält Proportionen, passt in Rahmen)', 992, 558, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_16x9_max_992', 'hero 16x9 für Breakpoint 992px (992x558) - Maximum (behält Proportionen, füllt Rahmen)', 992, 558, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_16x9_1200', 'hero 16x9 für Breakpoint 1200px (1200x675) - Minimum (behält Proportionen, passt in Rahmen)', 1200, 675, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_16x9_max_1200', 'hero 16x9 für Breakpoint 1200px (1200x675) - Maximum (behält Proportionen, füllt Rahmen)', 1200, 675, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_16x9_1400', 'hero 16x9 für Breakpoint 1400px (1400x788) - Minimum (behält Proportionen, passt in Rahmen)', 1400, 788, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_16x9_max_1400', 'hero 16x9 für Breakpoint 1400px (1400x788) - Maximum (behält Proportionen, füllt Rahmen)', 1400, 788, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_16x9_1920', 'hero 16x9 für Breakpoint 1920px (1920x1080) - Minimum (behält Proportionen, passt in Rahmen)', 1920, 1080, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_16x9_max_1920', 'hero 16x9 für Breakpoint 1920px (1920x1080) - Maximum (behält Proportionen, füllt Rahmen)', 1920, 1080, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_21x9_320', 'small 21x9 für Breakpoint 320px (120x51) - Minimum (behält Proportionen, passt in Rahmen)', 120, 51, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_21x9_max_320', 'small 21x9 für Breakpoint 320px (120x51) - Maximum (behält Proportionen, füllt Rahmen)', 120, 51, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_21x9_576', 'small 21x9 für Breakpoint 576px (180x77) - Minimum (behält Proportionen, passt in Rahmen)', 180, 77, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_21x9_max_576', 'small 21x9 für Breakpoint 576px (180x77) - Maximum (behält Proportionen, füllt Rahmen)', 180, 77, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_21x9_768', 'small 21x9 für Breakpoint 768px (240x103) - Minimum (behält Proportionen, passt in Rahmen)', 240, 103, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('small_21x9_max_768', 'small 21x9 für Breakpoint 768px (240x103) - Maximum (behält Proportionen, füllt Rahmen)', 240, 103, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_21x9_320', 'half 21x9 für Breakpoint 320px (140x60) - Minimum (behält Proportionen, passt in Rahmen)', 140, 60, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_21x9_max_320', 'half 21x9 für Breakpoint 320px (140x60) - Maximum (behält Proportionen, füllt Rahmen)', 140, 60, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_21x9_576', 'half 21x9 für Breakpoint 576px (260x111) - Minimum (behält Proportionen, passt in Rahmen)', 260, 111, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_21x9_max_576', 'half 21x9 für Breakpoint 576px (260x111) - Maximum (behält Proportionen, füllt Rahmen)', 260, 111, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_21x9_768', 'half 21x9 für Breakpoint 768px (360x154) - Minimum (behält Proportionen, passt in Rahmen)', 360, 154, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_21x9_max_768', 'half 21x9 für Breakpoint 768px (360x154) - Maximum (behält Proportionen, füllt Rahmen)', 360, 154, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_21x9_992', 'half 21x9 für Breakpoint 992px (480x206) - Minimum (behält Proportionen, passt in Rahmen)', 480, 206, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_21x9_max_992', 'half 21x9 für Breakpoint 992px (480x206) - Maximum (behält Proportionen, füllt Rahmen)', 480, 206, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_21x9_1200', 'half 21x9 für Breakpoint 1200px (570x244) - Minimum (behält Proportionen, passt in Rahmen)', 570, 244, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_21x9_max_1200', 'half 21x9 für Breakpoint 1200px (570x244) - Maximum (behält Proportionen, füllt Rahmen)', 570, 244, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_21x9_1400', 'half 21x9 für Breakpoint 1400px (670x287) - Minimum (behält Proportionen, passt in Rahmen)', 670, 287, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('half_21x9_max_1400', 'half 21x9 für Breakpoint 1400px (670x287) - Maximum (behält Proportionen, füllt Rahmen)', 670, 287, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_21x9_320', 'full 21x9 für Breakpoint 320px (280x120) - Minimum (behält Proportionen, passt in Rahmen)', 280, 120, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_21x9_max_320', 'full 21x9 für Breakpoint 320px (280x120) - Maximum (behält Proportionen, füllt Rahmen)', 280, 120, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_21x9_576', 'full 21x9 für Breakpoint 576px (520x223) - Minimum (behält Proportionen, passt in Rahmen)', 520, 223, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_21x9_max_576', 'full 21x9 für Breakpoint 576px (520x223) - Maximum (behält Proportionen, füllt Rahmen)', 520, 223, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_21x9_768', 'full 21x9 für Breakpoint 768px (720x309) - Minimum (behält Proportionen, passt in Rahmen)', 720, 309, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_21x9_max_768', 'full 21x9 für Breakpoint 768px (720x309) - Maximum (behält Proportionen, füllt Rahmen)', 720, 309, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_21x9_992', 'full 21x9 für Breakpoint 992px (960x411) - Minimum (behält Proportionen, passt in Rahmen)', 960, 411, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_21x9_max_992', 'full 21x9 für Breakpoint 992px (960x411) - Maximum (behält Proportionen, füllt Rahmen)', 960, 411, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_21x9_1200', 'full 21x9 für Breakpoint 1200px (1140x489) - Minimum (behält Proportionen, passt in Rahmen)', 1140, 489, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_21x9_max_1200', 'full 21x9 für Breakpoint 1200px (1140x489) - Maximum (behält Proportionen, füllt Rahmen)', 1140, 489, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_21x9_1400', 'full 21x9 für Breakpoint 1400px (1320x566) - Minimum (behält Proportionen, passt in Rahmen)', 1320, 566, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('full_21x9_max_1400', 'full 21x9 für Breakpoint 1400px (1320x566) - Maximum (behält Proportionen, füllt Rahmen)', 1320, 566, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_21x9_768', 'hero 21x9 für Breakpoint 768px (768x329) - Minimum (behält Proportionen, passt in Rahmen)', 768, 329, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_21x9_max_768', 'hero 21x9 für Breakpoint 768px (768x329) - Maximum (behält Proportionen, füllt Rahmen)', 768, 329, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_21x9_992', 'hero 21x9 für Breakpoint 992px (992x425) - Minimum (behält Proportionen, passt in Rahmen)', 992, 425, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_21x9_max_992', 'hero 21x9 für Breakpoint 992px (992x425) - Maximum (behält Proportionen, füllt Rahmen)', 992, 425, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_21x9_1200', 'hero 21x9 für Breakpoint 1200px (1200x514) - Minimum (behält Proportionen, passt in Rahmen)', 1200, 514, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_21x9_max_1200', 'hero 21x9 für Breakpoint 1200px (1200x514) - Maximum (behält Proportionen, füllt Rahmen)', 1200, 514, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_21x9_1400', 'hero 21x9 für Breakpoint 1400px (1400x600) - Minimum (behält Proportionen, passt in Rahmen)', 1400, 600, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_21x9_max_1400', 'hero 21x9 für Breakpoint 1400px (1400x600) - Maximum (behält Proportionen, füllt Rahmen)', 1400, 600, 'maximum', TRUE, '_max');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_21x9_1920', 'hero 21x9 für Breakpoint 1920px (1920x823) - Minimum (behält Proportionen, passt in Rahmen)', 1920, 823, 'minimum', TRUE, '');
INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('hero_21x9_max_1920', 'hero 21x9 für Breakpoint 1920px (1920x823) - Maximum (behält Proportionen, füllt Rahmen)', 1920, 823, 'maximum', TRUE, '_max');

-- PHASE 2: Sichere Erstellung der Media Manager Types
INSERT INTO rex_media_manager_type (name, description, status, createdate, createuser, updatedate, updateuser)
SELECT 
    type_name,
    type_description,
    0,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM temp_media_types
ON DUPLICATE KEY UPDATE 
    description = VALUES(description),
    updatedate = VALUES(updatedate);

-- ================================================================================
-- PHASE 3: ERWEITERTE EFFEKT-ERSTELLUNG MIT MODUS-BERÜCKSICHTIGUNG
-- Standard-Types: Resize mit minimum/maximum Style
-- Ratio-Types: Resize (mit Modus) + Crop für exakte Dimensionen
-- ================================================================================

-- Lösche existierende Effekte für Update-Fähigkeit
DELETE effect FROM rex_media_manager_type_effect effect 
INNER JOIN rex_media_manager_type type ON effect.type_id = type.id 
WHERE type.name IN (
    'small_320',
    'small_max_320',
    'small_576',
    'small_max_576',
    'small_768',
    'small_max_768',
    'half_320',
    'half_max_320',
    'half_576',
    'half_max_576',
    'half_768',
    'half_max_768',
    'half_992',
    'half_max_992',
    'half_1200',
    'half_max_1200',
    'half_1400',
    'half_max_1400',
    'full_320',
    'full_max_320',
    'full_576',
    'full_max_576',
    'full_768',
    'full_max_768',
    'full_992',
    'full_max_992',
    'full_1200',
    'full_max_1200',
    'full_1400',
    'full_max_1400',
    'hero_768',
    'hero_max_768',
    'hero_992',
    'hero_max_992',
    'hero_1200',
    'hero_max_1200',
    'hero_1400',
    'hero_max_1400',
    'hero_1920',
    'hero_max_1920',
    'small_1x1_320',
    'small_1x1_max_320',
    'small_1x1_576',
    'small_1x1_max_576',
    'small_1x1_768',
    'small_1x1_max_768',
    'half_1x1_320',
    'half_1x1_max_320',
    'half_1x1_576',
    'half_1x1_max_576',
    'half_1x1_768',
    'half_1x1_max_768',
    'half_1x1_992',
    'half_1x1_max_992',
    'half_1x1_1200',
    'half_1x1_max_1200',
    'half_1x1_1400',
    'half_1x1_max_1400',
    'full_1x1_320',
    'full_1x1_max_320',
    'full_1x1_576',
    'full_1x1_max_576',
    'full_1x1_768',
    'full_1x1_max_768',
    'full_1x1_992',
    'full_1x1_max_992',
    'full_1x1_1200',
    'full_1x1_max_1200',
    'full_1x1_1400',
    'full_1x1_max_1400',
    'hero_1x1_768',
    'hero_1x1_max_768',
    'hero_1x1_992',
    'hero_1x1_max_992',
    'hero_1x1_1200',
    'hero_1x1_max_1200',
    'hero_1x1_1400',
    'hero_1x1_max_1400',
    'hero_1x1_1920',
    'hero_1x1_max_1920',
    'small_3x2_320',
    'small_3x2_max_320',
    'small_3x2_576',
    'small_3x2_max_576',
    'small_3x2_768',
    'small_3x2_max_768',
    'half_3x2_320',
    'half_3x2_max_320',
    'half_3x2_576',
    'half_3x2_max_576',
    'half_3x2_768',
    'half_3x2_max_768',
    'half_3x2_992',
    'half_3x2_max_992',
    'half_3x2_1200',
    'half_3x2_max_1200',
    'half_3x2_1400',
    'half_3x2_max_1400',
    'full_3x2_320',
    'full_3x2_max_320',
    'full_3x2_576',
    'full_3x2_max_576',
    'full_3x2_768',
    'full_3x2_max_768',
    'full_3x2_992',
    'full_3x2_max_992',
    'full_3x2_1200',
    'full_3x2_max_1200',
    'full_3x2_1400',
    'full_3x2_max_1400',
    'hero_3x2_768',
    'hero_3x2_max_768',
    'hero_3x2_992',
    'hero_3x2_max_992',
    'hero_3x2_1200',
    'hero_3x2_max_1200',
    'hero_3x2_1400',
    'hero_3x2_max_1400',
    'hero_3x2_1920',
    'hero_3x2_max_1920',
    'small_4x3_320',
    'small_4x3_max_320',
    'small_4x3_576',
    'small_4x3_max_576',
    'small_4x3_768',
    'small_4x3_max_768',
    'half_4x3_320',
    'half_4x3_max_320',
    'half_4x3_576',
    'half_4x3_max_576',
    'half_4x3_768',
    'half_4x3_max_768',
    'half_4x3_992',
    'half_4x3_max_992',
    'half_4x3_1200',
    'half_4x3_max_1200',
    'half_4x3_1400',
    'half_4x3_max_1400',
    'full_4x3_320',
    'full_4x3_max_320',
    'full_4x3_576',
    'full_4x3_max_576',
    'full_4x3_768',
    'full_4x3_max_768',
    'full_4x3_992',
    'full_4x3_max_992',
    'full_4x3_1200',
    'full_4x3_max_1200',
    'full_4x3_1400',
    'full_4x3_max_1400',
    'hero_4x3_768',
    'hero_4x3_max_768',
    'hero_4x3_992',
    'hero_4x3_max_992',
    'hero_4x3_1200',
    'hero_4x3_max_1200',
    'hero_4x3_1400',
    'hero_4x3_max_1400',
    'hero_4x3_1920',
    'hero_4x3_max_1920',
    'small_5x2_320',
    'small_5x2_max_320',
    'small_5x2_576',
    'small_5x2_max_576',
    'small_5x2_768',
    'small_5x2_max_768',
    'half_5x2_320',
    'half_5x2_max_320',
    'half_5x2_576',
    'half_5x2_max_576',
    'half_5x2_768',
    'half_5x2_max_768',
    'half_5x2_992',
    'half_5x2_max_992',
    'half_5x2_1200',
    'half_5x2_max_1200',
    'half_5x2_1400',
    'half_5x2_max_1400',
    'full_5x2_320',
    'full_5x2_max_320',
    'full_5x2_576',
    'full_5x2_max_576',
    'full_5x2_768',
    'full_5x2_max_768',
    'full_5x2_992',
    'full_5x2_max_992',
    'full_5x2_1200',
    'full_5x2_max_1200',
    'full_5x2_1400',
    'full_5x2_max_1400',
    'hero_5x2_768',
    'hero_5x2_max_768',
    'hero_5x2_992',
    'hero_5x2_max_992',
    'hero_5x2_1200',
    'hero_5x2_max_1200',
    'hero_5x2_1400',
    'hero_5x2_max_1400',
    'hero_5x2_1920',
    'hero_5x2_max_1920',
    'small_4x1_320',
    'small_4x1_max_320',
    'small_4x1_576',
    'small_4x1_max_576',
    'small_4x1_768',
    'small_4x1_max_768',
    'half_4x1_320',
    'half_4x1_max_320',
    'half_4x1_576',
    'half_4x1_max_576',
    'half_4x1_768',
    'half_4x1_max_768',
    'half_4x1_992',
    'half_4x1_max_992',
    'half_4x1_1200',
    'half_4x1_max_1200',
    'half_4x1_1400',
    'half_4x1_max_1400',
    'full_4x1_320',
    'full_4x1_max_320',
    'full_4x1_576',
    'full_4x1_max_576',
    'full_4x1_768',
    'full_4x1_max_768',
    'full_4x1_992',
    'full_4x1_max_992',
    'full_4x1_1200',
    'full_4x1_max_1200',
    'full_4x1_1400',
    'full_4x1_max_1400',
    'hero_4x1_768',
    'hero_4x1_max_768',
    'hero_4x1_992',
    'hero_4x1_max_992',
    'hero_4x1_1200',
    'hero_4x1_max_1200',
    'hero_4x1_1400',
    'hero_4x1_max_1400',
    'hero_4x1_1920',
    'hero_4x1_max_1920',
    'small_2x1_320',
    'small_2x1_max_320',
    'small_2x1_576',
    'small_2x1_max_576',
    'small_2x1_768',
    'small_2x1_max_768',
    'half_2x1_320',
    'half_2x1_max_320',
    'half_2x1_576',
    'half_2x1_max_576',
    'half_2x1_768',
    'half_2x1_max_768',
    'half_2x1_992',
    'half_2x1_max_992',
    'half_2x1_1200',
    'half_2x1_max_1200',
    'half_2x1_1400',
    'half_2x1_max_1400',
    'full_2x1_320',
    'full_2x1_max_320',
    'full_2x1_576',
    'full_2x1_max_576',
    'full_2x1_768',
    'full_2x1_max_768',
    'full_2x1_992',
    'full_2x1_max_992',
    'full_2x1_1200',
    'full_2x1_max_1200',
    'full_2x1_1400',
    'full_2x1_max_1400',
    'hero_2x1_768',
    'hero_2x1_max_768',
    'hero_2x1_992',
    'hero_2x1_max_992',
    'hero_2x1_1200',
    'hero_2x1_max_1200',
    'hero_2x1_1400',
    'hero_2x1_max_1400',
    'hero_2x1_1920',
    'hero_2x1_max_1920',
    'small_16x9_320',
    'small_16x9_max_320',
    'small_16x9_576',
    'small_16x9_max_576',
    'small_16x9_768',
    'small_16x9_max_768',
    'half_16x9_320',
    'half_16x9_max_320',
    'half_16x9_576',
    'half_16x9_max_576',
    'half_16x9_768',
    'half_16x9_max_768',
    'half_16x9_992',
    'half_16x9_max_992',
    'half_16x9_1200',
    'half_16x9_max_1200',
    'half_16x9_1400',
    'half_16x9_max_1400',
    'full_16x9_320',
    'full_16x9_max_320',
    'full_16x9_576',
    'full_16x9_max_576',
    'full_16x9_768',
    'full_16x9_max_768',
    'full_16x9_992',
    'full_16x9_max_992',
    'full_16x9_1200',
    'full_16x9_max_1200',
    'full_16x9_1400',
    'full_16x9_max_1400',
    'hero_16x9_768',
    'hero_16x9_max_768',
    'hero_16x9_992',
    'hero_16x9_max_992',
    'hero_16x9_1200',
    'hero_16x9_max_1200',
    'hero_16x9_1400',
    'hero_16x9_max_1400',
    'hero_16x9_1920',
    'hero_16x9_max_1920',
    'small_21x9_320',
    'small_21x9_max_320',
    'small_21x9_576',
    'small_21x9_max_576',
    'small_21x9_768',
    'small_21x9_max_768',
    'half_21x9_320',
    'half_21x9_max_320',
    'half_21x9_576',
    'half_21x9_max_576',
    'half_21x9_768',
    'half_21x9_max_768',
    'half_21x9_992',
    'half_21x9_max_992',
    'half_21x9_1200',
    'half_21x9_max_1200',
    'half_21x9_1400',
    'half_21x9_max_1400',
    'full_21x9_320',
    'full_21x9_max_320',
    'full_21x9_576',
    'full_21x9_max_576',
    'full_21x9_768',
    'full_21x9_max_768',
    'full_21x9_992',
    'full_21x9_max_992',
    'full_21x9_1200',
    'full_21x9_max_1200',
    'full_21x9_1400',
    'full_21x9_max_1400',
    'hero_21x9_768',
    'hero_21x9_max_768',
    'hero_21x9_992',
    'hero_21x9_max_992',
    'hero_21x9_1200',
    'hero_21x9_max_1200',
    'hero_21x9_1400',
    'hero_21x9_max_1400',
    'hero_21x9_1920',
    'hero_21x9_max_1920'
);

-- Type: small_320 (Breite 120px) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"120\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_320';

-- Type: small_max_320 (Breite 120px) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"120\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_max_320';

-- Type: small_576 (Breite 180px) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"180\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_576';

-- Type: small_max_576 (Breite 180px) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"180\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_max_576';

-- Type: small_768 (Breite 240px) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"240\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_768';

-- Type: small_max_768 (Breite 240px) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"240\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_max_768';

-- Type: half_320 (Breite 140px) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"140\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_320';

-- Type: half_max_320 (Breite 140px) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"140\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_max_320';

-- Type: half_576 (Breite 260px) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"260\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_576';

-- Type: half_max_576 (Breite 260px) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"260\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_max_576';

-- Type: half_768 (Breite 360px) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"360\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_768';

-- Type: half_max_768 (Breite 360px) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"360\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_max_768';

-- Type: half_992 (Breite 480px) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"480\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_992';

-- Type: half_max_992 (Breite 480px) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"480\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_max_992';

-- Type: half_1200 (Breite 570px) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"570\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1200';

-- Type: half_max_1200 (Breite 570px) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"570\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_max_1200';

-- Type: half_1400 (Breite 670px) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"670\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1400';

-- Type: half_max_1400 (Breite 670px) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"670\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_max_1400';

-- Type: full_320 (Breite 280px) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"280\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_320';

-- Type: full_max_320 (Breite 280px) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"280\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_max_320';

-- Type: full_576 (Breite 520px) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"520\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_576';

-- Type: full_max_576 (Breite 520px) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"520\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_max_576';

-- Type: full_768 (Breite 720px) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"720\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_768';

-- Type: full_max_768 (Breite 720px) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"720\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_max_768';

-- Type: full_992 (Breite 960px) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"960\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_992';

-- Type: full_max_992 (Breite 960px) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"960\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_max_992';

-- Type: full_1200 (Breite 1140px) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1140\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1200';

-- Type: full_max_1200 (Breite 1140px) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1140\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_max_1200';

-- Type: full_1400 (Breite 1320px) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1320\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1400';

-- Type: full_max_1400 (Breite 1320px) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1320\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_max_1400';

-- Type: hero_768 (Breite 768px) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"768\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_768';

-- Type: hero_max_768 (Breite 768px) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"768\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_max_768';

-- Type: hero_992 (Breite 992px) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"992\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_992';

-- Type: hero_max_992 (Breite 992px) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"992\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_max_992';

-- Type: hero_1200 (Breite 1200px) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1200\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1200';

-- Type: hero_max_1200 (Breite 1200px) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1200\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_max_1200';

-- Type: hero_1400 (Breite 1400px) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1400\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1400';

-- Type: hero_max_1400 (Breite 1400px) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1400\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_max_1400';

-- Type: hero_1920 (Breite 1920px) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1920\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1920';

-- Type: hero_max_1920 (Breite 1920px) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1920\",\"rex_effect_resize_height\":\"\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_max_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_max_1920';

-- Type: small_1x1_320 (120x120) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"120\",\"rex_effect_resize_height\":\"120\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_1x1_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"120\",\"rex_effect_crop_height\":\"120\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_1x1_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_1x1_320';

-- Type: small_1x1_max_320 (120x120) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"120\",\"rex_effect_resize_height\":\"120\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_1x1_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"120\",\"rex_effect_crop_height\":\"120\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_1x1_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_1x1_max_320';

-- Type: small_1x1_576 (180x180) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"180\",\"rex_effect_resize_height\":\"180\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_1x1_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"180\",\"rex_effect_crop_height\":\"180\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_1x1_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_1x1_576';

-- Type: small_1x1_max_576 (180x180) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"180\",\"rex_effect_resize_height\":\"180\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_1x1_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"180\",\"rex_effect_crop_height\":\"180\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_1x1_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_1x1_max_576';

-- Type: small_1x1_768 (240x240) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"240\",\"rex_effect_resize_height\":\"240\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_1x1_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"240\",\"rex_effect_crop_height\":\"240\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_1x1_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_1x1_768';

-- Type: small_1x1_max_768 (240x240) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"240\",\"rex_effect_resize_height\":\"240\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_1x1_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"240\",\"rex_effect_crop_height\":\"240\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_1x1_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_1x1_max_768';

-- Type: half_1x1_320 (140x140) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"140\",\"rex_effect_resize_height\":\"140\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"140\",\"rex_effect_crop_height\":\"140\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_320';

-- Type: half_1x1_max_320 (140x140) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"140\",\"rex_effect_resize_height\":\"140\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"140\",\"rex_effect_crop_height\":\"140\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_max_320';

-- Type: half_1x1_576 (260x260) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"260\",\"rex_effect_resize_height\":\"260\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"260\",\"rex_effect_crop_height\":\"260\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_576';

-- Type: half_1x1_max_576 (260x260) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"260\",\"rex_effect_resize_height\":\"260\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"260\",\"rex_effect_crop_height\":\"260\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_max_576';

-- Type: half_1x1_768 (360x360) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"360\",\"rex_effect_resize_height\":\"360\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"360\",\"rex_effect_crop_height\":\"360\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_768';

-- Type: half_1x1_max_768 (360x360) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"360\",\"rex_effect_resize_height\":\"360\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"360\",\"rex_effect_crop_height\":\"360\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_max_768';

-- Type: half_1x1_992 (480x480) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"480\",\"rex_effect_resize_height\":\"480\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"480\",\"rex_effect_crop_height\":\"480\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_992';

-- Type: half_1x1_max_992 (480x480) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"480\",\"rex_effect_resize_height\":\"480\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"480\",\"rex_effect_crop_height\":\"480\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_max_992';

-- Type: half_1x1_1200 (570x570) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"570\",\"rex_effect_resize_height\":\"570\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"570\",\"rex_effect_crop_height\":\"570\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_1200';

-- Type: half_1x1_max_1200 (570x570) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"570\",\"rex_effect_resize_height\":\"570\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"570\",\"rex_effect_crop_height\":\"570\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_max_1200';

-- Type: half_1x1_1400 (670x670) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"670\",\"rex_effect_resize_height\":\"670\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"670\",\"rex_effect_crop_height\":\"670\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_1400';

-- Type: half_1x1_max_1400 (670x670) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"670\",\"rex_effect_resize_height\":\"670\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"670\",\"rex_effect_crop_height\":\"670\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_1x1_max_1400';

-- Type: full_1x1_320 (280x280) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"280\",\"rex_effect_resize_height\":\"280\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"280\",\"rex_effect_crop_height\":\"280\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_320';

-- Type: full_1x1_max_320 (280x280) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"280\",\"rex_effect_resize_height\":\"280\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"280\",\"rex_effect_crop_height\":\"280\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_max_320';

-- Type: full_1x1_576 (520x520) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"520\",\"rex_effect_resize_height\":\"520\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"520\",\"rex_effect_crop_height\":\"520\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_576';

-- Type: full_1x1_max_576 (520x520) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"520\",\"rex_effect_resize_height\":\"520\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"520\",\"rex_effect_crop_height\":\"520\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_max_576';

-- Type: full_1x1_768 (720x720) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"720\",\"rex_effect_resize_height\":\"720\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"720\",\"rex_effect_crop_height\":\"720\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_768';

-- Type: full_1x1_max_768 (720x720) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"720\",\"rex_effect_resize_height\":\"720\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"720\",\"rex_effect_crop_height\":\"720\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_max_768';

-- Type: full_1x1_992 (960x960) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"960\",\"rex_effect_resize_height\":\"960\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"960\",\"rex_effect_crop_height\":\"960\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_992';

-- Type: full_1x1_max_992 (960x960) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"960\",\"rex_effect_resize_height\":\"960\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"960\",\"rex_effect_crop_height\":\"960\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_max_992';

-- Type: full_1x1_1200 (1140x1140) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1140\",\"rex_effect_resize_height\":\"1140\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1140\",\"rex_effect_crop_height\":\"1140\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_1200';

-- Type: full_1x1_max_1200 (1140x1140) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1140\",\"rex_effect_resize_height\":\"1140\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1140\",\"rex_effect_crop_height\":\"1140\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_max_1200';

-- Type: full_1x1_1400 (1320x1320) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1320\",\"rex_effect_resize_height\":\"1320\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1320\",\"rex_effect_crop_height\":\"1320\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_1400';

-- Type: full_1x1_max_1400 (1320x1320) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1320\",\"rex_effect_resize_height\":\"1320\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1320\",\"rex_effect_crop_height\":\"1320\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_1x1_max_1400';

-- Type: hero_1x1_768 (768x768) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"768\",\"rex_effect_resize_height\":\"768\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"768\",\"rex_effect_crop_height\":\"768\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_768';

-- Type: hero_1x1_max_768 (768x768) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"768\",\"rex_effect_resize_height\":\"768\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"768\",\"rex_effect_crop_height\":\"768\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_max_768';

-- Type: hero_1x1_992 (992x992) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"992\",\"rex_effect_resize_height\":\"992\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"992\",\"rex_effect_crop_height\":\"992\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_992';

-- Type: hero_1x1_max_992 (992x992) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"992\",\"rex_effect_resize_height\":\"992\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"992\",\"rex_effect_crop_height\":\"992\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_max_992';

-- Type: hero_1x1_1200 (1200x1200) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1200\",\"rex_effect_resize_height\":\"1200\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1200\",\"rex_effect_crop_height\":\"1200\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_1200';

-- Type: hero_1x1_max_1200 (1200x1200) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1200\",\"rex_effect_resize_height\":\"1200\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1200\",\"rex_effect_crop_height\":\"1200\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_max_1200';

-- Type: hero_1x1_1400 (1400x1400) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1400\",\"rex_effect_resize_height\":\"1400\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1400\",\"rex_effect_crop_height\":\"1400\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_1400';

-- Type: hero_1x1_max_1400 (1400x1400) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1400\",\"rex_effect_resize_height\":\"1400\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1400\",\"rex_effect_crop_height\":\"1400\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_max_1400';

-- Type: hero_1x1_1920 (1920x1920) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1920\",\"rex_effect_resize_height\":\"1920\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1920\",\"rex_effect_crop_height\":\"1920\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_1920';

-- Type: hero_1x1_max_1920 (1920x1920) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1920\",\"rex_effect_resize_height\":\"1920\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_max_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1920\",\"rex_effect_crop_height\":\"1920\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_max_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_1x1_max_1920';

-- Type: small_3x2_320 (120x80) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"120\",\"rex_effect_resize_height\":\"80\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_3x2_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"120\",\"rex_effect_crop_height\":\"80\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_3x2_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_3x2_320';

-- Type: small_3x2_max_320 (120x80) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"120\",\"rex_effect_resize_height\":\"80\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_3x2_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"120\",\"rex_effect_crop_height\":\"80\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_3x2_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_3x2_max_320';

-- Type: small_3x2_576 (180x120) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"180\",\"rex_effect_resize_height\":\"120\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_3x2_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"180\",\"rex_effect_crop_height\":\"120\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_3x2_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_3x2_576';

-- Type: small_3x2_max_576 (180x120) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"180\",\"rex_effect_resize_height\":\"120\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_3x2_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"180\",\"rex_effect_crop_height\":\"120\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_3x2_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_3x2_max_576';

-- Type: small_3x2_768 (240x160) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"240\",\"rex_effect_resize_height\":\"160\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_3x2_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"240\",\"rex_effect_crop_height\":\"160\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_3x2_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_3x2_768';

-- Type: small_3x2_max_768 (240x160) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"240\",\"rex_effect_resize_height\":\"160\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_3x2_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"240\",\"rex_effect_crop_height\":\"160\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_3x2_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_3x2_max_768';

-- Type: half_3x2_320 (140x93) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"140\",\"rex_effect_resize_height\":\"93\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"140\",\"rex_effect_crop_height\":\"93\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_320';

-- Type: half_3x2_max_320 (140x93) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"140\",\"rex_effect_resize_height\":\"93\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"140\",\"rex_effect_crop_height\":\"93\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_max_320';

-- Type: half_3x2_576 (260x173) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"260\",\"rex_effect_resize_height\":\"173\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"260\",\"rex_effect_crop_height\":\"173\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_576';

-- Type: half_3x2_max_576 (260x173) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"260\",\"rex_effect_resize_height\":\"173\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"260\",\"rex_effect_crop_height\":\"173\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_max_576';

-- Type: half_3x2_768 (360x240) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"360\",\"rex_effect_resize_height\":\"240\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"360\",\"rex_effect_crop_height\":\"240\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_768';

-- Type: half_3x2_max_768 (360x240) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"360\",\"rex_effect_resize_height\":\"240\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"360\",\"rex_effect_crop_height\":\"240\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_max_768';

-- Type: half_3x2_992 (480x320) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"480\",\"rex_effect_resize_height\":\"320\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"480\",\"rex_effect_crop_height\":\"320\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_992';

-- Type: half_3x2_max_992 (480x320) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"480\",\"rex_effect_resize_height\":\"320\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"480\",\"rex_effect_crop_height\":\"320\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_max_992';

-- Type: half_3x2_1200 (570x380) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"570\",\"rex_effect_resize_height\":\"380\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"570\",\"rex_effect_crop_height\":\"380\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_1200';

-- Type: half_3x2_max_1200 (570x380) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"570\",\"rex_effect_resize_height\":\"380\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"570\",\"rex_effect_crop_height\":\"380\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_max_1200';

-- Type: half_3x2_1400 (670x447) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"670\",\"rex_effect_resize_height\":\"447\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"670\",\"rex_effect_crop_height\":\"447\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_1400';

-- Type: half_3x2_max_1400 (670x447) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"670\",\"rex_effect_resize_height\":\"447\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"670\",\"rex_effect_crop_height\":\"447\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_3x2_max_1400';

-- Type: full_3x2_320 (280x187) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"280\",\"rex_effect_resize_height\":\"187\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"280\",\"rex_effect_crop_height\":\"187\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_320';

-- Type: full_3x2_max_320 (280x187) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"280\",\"rex_effect_resize_height\":\"187\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"280\",\"rex_effect_crop_height\":\"187\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_max_320';

-- Type: full_3x2_576 (520x347) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"520\",\"rex_effect_resize_height\":\"347\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"520\",\"rex_effect_crop_height\":\"347\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_576';

-- Type: full_3x2_max_576 (520x347) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"520\",\"rex_effect_resize_height\":\"347\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"520\",\"rex_effect_crop_height\":\"347\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_max_576';

-- Type: full_3x2_768 (720x480) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"720\",\"rex_effect_resize_height\":\"480\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"720\",\"rex_effect_crop_height\":\"480\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_768';

-- Type: full_3x2_max_768 (720x480) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"720\",\"rex_effect_resize_height\":\"480\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"720\",\"rex_effect_crop_height\":\"480\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_max_768';

-- Type: full_3x2_992 (960x640) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"960\",\"rex_effect_resize_height\":\"640\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"960\",\"rex_effect_crop_height\":\"640\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_992';

-- Type: full_3x2_max_992 (960x640) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"960\",\"rex_effect_resize_height\":\"640\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"960\",\"rex_effect_crop_height\":\"640\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_max_992';

-- Type: full_3x2_1200 (1140x760) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1140\",\"rex_effect_resize_height\":\"760\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1140\",\"rex_effect_crop_height\":\"760\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_1200';

-- Type: full_3x2_max_1200 (1140x760) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1140\",\"rex_effect_resize_height\":\"760\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1140\",\"rex_effect_crop_height\":\"760\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_max_1200';

-- Type: full_3x2_1400 (1320x880) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1320\",\"rex_effect_resize_height\":\"880\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1320\",\"rex_effect_crop_height\":\"880\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_1400';

-- Type: full_3x2_max_1400 (1320x880) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1320\",\"rex_effect_resize_height\":\"880\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1320\",\"rex_effect_crop_height\":\"880\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_3x2_max_1400';

-- Type: hero_3x2_768 (768x512) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"768\",\"rex_effect_resize_height\":\"512\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"768\",\"rex_effect_crop_height\":\"512\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_768';

-- Type: hero_3x2_max_768 (768x512) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"768\",\"rex_effect_resize_height\":\"512\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"768\",\"rex_effect_crop_height\":\"512\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_max_768';

-- Type: hero_3x2_992 (992x661) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"992\",\"rex_effect_resize_height\":\"661\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"992\",\"rex_effect_crop_height\":\"661\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_992';

-- Type: hero_3x2_max_992 (992x661) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"992\",\"rex_effect_resize_height\":\"661\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"992\",\"rex_effect_crop_height\":\"661\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_max_992';

-- Type: hero_3x2_1200 (1200x800) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1200\",\"rex_effect_resize_height\":\"800\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1200\",\"rex_effect_crop_height\":\"800\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_1200';

-- Type: hero_3x2_max_1200 (1200x800) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1200\",\"rex_effect_resize_height\":\"800\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1200\",\"rex_effect_crop_height\":\"800\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_max_1200';

-- Type: hero_3x2_1400 (1400x933) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1400\",\"rex_effect_resize_height\":\"933\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1400\",\"rex_effect_crop_height\":\"933\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_1400';

-- Type: hero_3x2_max_1400 (1400x933) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1400\",\"rex_effect_resize_height\":\"933\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1400\",\"rex_effect_crop_height\":\"933\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_max_1400';

-- Type: hero_3x2_1920 (1920x1280) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1920\",\"rex_effect_resize_height\":\"1280\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1920\",\"rex_effect_crop_height\":\"1280\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_1920';

-- Type: hero_3x2_max_1920 (1920x1280) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1920\",\"rex_effect_resize_height\":\"1280\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_max_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1920\",\"rex_effect_crop_height\":\"1280\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_max_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_3x2_max_1920';

-- Type: small_4x3_320 (120x90) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"120\",\"rex_effect_resize_height\":\"90\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x3_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"120\",\"rex_effect_crop_height\":\"90\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x3_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x3_320';

-- Type: small_4x3_max_320 (120x90) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"120\",\"rex_effect_resize_height\":\"90\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x3_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"120\",\"rex_effect_crop_height\":\"90\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x3_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x3_max_320';

-- Type: small_4x3_576 (180x135) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"180\",\"rex_effect_resize_height\":\"135\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x3_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"180\",\"rex_effect_crop_height\":\"135\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x3_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x3_576';

-- Type: small_4x3_max_576 (180x135) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"180\",\"rex_effect_resize_height\":\"135\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x3_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"180\",\"rex_effect_crop_height\":\"135\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x3_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x3_max_576';

-- Type: small_4x3_768 (240x180) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"240\",\"rex_effect_resize_height\":\"180\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x3_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"240\",\"rex_effect_crop_height\":\"180\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x3_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x3_768';

-- Type: small_4x3_max_768 (240x180) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"240\",\"rex_effect_resize_height\":\"180\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x3_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"240\",\"rex_effect_crop_height\":\"180\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x3_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x3_max_768';

-- Type: half_4x3_320 (140x105) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"140\",\"rex_effect_resize_height\":\"105\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"140\",\"rex_effect_crop_height\":\"105\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_320';

-- Type: half_4x3_max_320 (140x105) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"140\",\"rex_effect_resize_height\":\"105\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"140\",\"rex_effect_crop_height\":\"105\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_max_320';

-- Type: half_4x3_576 (260x195) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"260\",\"rex_effect_resize_height\":\"195\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"260\",\"rex_effect_crop_height\":\"195\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_576';

-- Type: half_4x3_max_576 (260x195) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"260\",\"rex_effect_resize_height\":\"195\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"260\",\"rex_effect_crop_height\":\"195\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_max_576';

-- Type: half_4x3_768 (360x270) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"360\",\"rex_effect_resize_height\":\"270\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"360\",\"rex_effect_crop_height\":\"270\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_768';

-- Type: half_4x3_max_768 (360x270) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"360\",\"rex_effect_resize_height\":\"270\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"360\",\"rex_effect_crop_height\":\"270\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_max_768';

-- Type: half_4x3_992 (480x360) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"480\",\"rex_effect_resize_height\":\"360\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"480\",\"rex_effect_crop_height\":\"360\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_992';

-- Type: half_4x3_max_992 (480x360) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"480\",\"rex_effect_resize_height\":\"360\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"480\",\"rex_effect_crop_height\":\"360\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_max_992';

-- Type: half_4x3_1200 (570x428) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"570\",\"rex_effect_resize_height\":\"428\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"570\",\"rex_effect_crop_height\":\"428\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_1200';

-- Type: half_4x3_max_1200 (570x428) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"570\",\"rex_effect_resize_height\":\"428\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"570\",\"rex_effect_crop_height\":\"428\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_max_1200';

-- Type: half_4x3_1400 (670x503) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"670\",\"rex_effect_resize_height\":\"503\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"670\",\"rex_effect_crop_height\":\"503\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_1400';

-- Type: half_4x3_max_1400 (670x503) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"670\",\"rex_effect_resize_height\":\"503\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"670\",\"rex_effect_crop_height\":\"503\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x3_max_1400';

-- Type: full_4x3_320 (280x210) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"280\",\"rex_effect_resize_height\":\"210\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"280\",\"rex_effect_crop_height\":\"210\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_320';

-- Type: full_4x3_max_320 (280x210) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"280\",\"rex_effect_resize_height\":\"210\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"280\",\"rex_effect_crop_height\":\"210\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_max_320';

-- Type: full_4x3_576 (520x390) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"520\",\"rex_effect_resize_height\":\"390\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"520\",\"rex_effect_crop_height\":\"390\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_576';

-- Type: full_4x3_max_576 (520x390) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"520\",\"rex_effect_resize_height\":\"390\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"520\",\"rex_effect_crop_height\":\"390\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_max_576';

-- Type: full_4x3_768 (720x540) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"720\",\"rex_effect_resize_height\":\"540\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"720\",\"rex_effect_crop_height\":\"540\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_768';

-- Type: full_4x3_max_768 (720x540) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"720\",\"rex_effect_resize_height\":\"540\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"720\",\"rex_effect_crop_height\":\"540\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_max_768';

-- Type: full_4x3_992 (960x720) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"960\",\"rex_effect_resize_height\":\"720\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"960\",\"rex_effect_crop_height\":\"720\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_992';

-- Type: full_4x3_max_992 (960x720) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"960\",\"rex_effect_resize_height\":\"720\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"960\",\"rex_effect_crop_height\":\"720\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_max_992';

-- Type: full_4x3_1200 (1140x855) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1140\",\"rex_effect_resize_height\":\"855\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1140\",\"rex_effect_crop_height\":\"855\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_1200';

-- Type: full_4x3_max_1200 (1140x855) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1140\",\"rex_effect_resize_height\":\"855\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1140\",\"rex_effect_crop_height\":\"855\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_max_1200';

-- Type: full_4x3_1400 (1320x990) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1320\",\"rex_effect_resize_height\":\"990\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1320\",\"rex_effect_crop_height\":\"990\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_1400';

-- Type: full_4x3_max_1400 (1320x990) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1320\",\"rex_effect_resize_height\":\"990\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1320\",\"rex_effect_crop_height\":\"990\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x3_max_1400';

-- Type: hero_4x3_768 (768x576) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"768\",\"rex_effect_resize_height\":\"576\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"768\",\"rex_effect_crop_height\":\"576\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_768';

-- Type: hero_4x3_max_768 (768x576) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"768\",\"rex_effect_resize_height\":\"576\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"768\",\"rex_effect_crop_height\":\"576\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_max_768';

-- Type: hero_4x3_992 (992x744) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"992\",\"rex_effect_resize_height\":\"744\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"992\",\"rex_effect_crop_height\":\"744\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_992';

-- Type: hero_4x3_max_992 (992x744) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"992\",\"rex_effect_resize_height\":\"744\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"992\",\"rex_effect_crop_height\":\"744\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_max_992';

-- Type: hero_4x3_1200 (1200x900) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1200\",\"rex_effect_resize_height\":\"900\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1200\",\"rex_effect_crop_height\":\"900\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_1200';

-- Type: hero_4x3_max_1200 (1200x900) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1200\",\"rex_effect_resize_height\":\"900\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1200\",\"rex_effect_crop_height\":\"900\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_max_1200';

-- Type: hero_4x3_1400 (1400x1050) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1400\",\"rex_effect_resize_height\":\"1050\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1400\",\"rex_effect_crop_height\":\"1050\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_1400';

-- Type: hero_4x3_max_1400 (1400x1050) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1400\",\"rex_effect_resize_height\":\"1050\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1400\",\"rex_effect_crop_height\":\"1050\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_max_1400';

-- Type: hero_4x3_1920 (1920x1440) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1920\",\"rex_effect_resize_height\":\"1440\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1920\",\"rex_effect_crop_height\":\"1440\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_1920';

-- Type: hero_4x3_max_1920 (1920x1440) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1920\",\"rex_effect_resize_height\":\"1440\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_max_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1920\",\"rex_effect_crop_height\":\"1440\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_max_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x3_max_1920';

-- Type: small_5x2_320 (120x48) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"120\",\"rex_effect_resize_height\":\"48\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_5x2_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"120\",\"rex_effect_crop_height\":\"48\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_5x2_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_5x2_320';

-- Type: small_5x2_max_320 (120x48) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"120\",\"rex_effect_resize_height\":\"48\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_5x2_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"120\",\"rex_effect_crop_height\":\"48\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_5x2_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_5x2_max_320';

-- Type: small_5x2_576 (180x72) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"180\",\"rex_effect_resize_height\":\"72\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_5x2_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"180\",\"rex_effect_crop_height\":\"72\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_5x2_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_5x2_576';

-- Type: small_5x2_max_576 (180x72) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"180\",\"rex_effect_resize_height\":\"72\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_5x2_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"180\",\"rex_effect_crop_height\":\"72\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_5x2_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_5x2_max_576';

-- Type: small_5x2_768 (240x96) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"240\",\"rex_effect_resize_height\":\"96\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_5x2_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"240\",\"rex_effect_crop_height\":\"96\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_5x2_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_5x2_768';

-- Type: small_5x2_max_768 (240x96) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"240\",\"rex_effect_resize_height\":\"96\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_5x2_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"240\",\"rex_effect_crop_height\":\"96\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_5x2_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_5x2_max_768';

-- Type: half_5x2_320 (140x56) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"140\",\"rex_effect_resize_height\":\"56\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"140\",\"rex_effect_crop_height\":\"56\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_320';

-- Type: half_5x2_max_320 (140x56) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"140\",\"rex_effect_resize_height\":\"56\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"140\",\"rex_effect_crop_height\":\"56\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_max_320';

-- Type: half_5x2_576 (260x104) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"260\",\"rex_effect_resize_height\":\"104\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"260\",\"rex_effect_crop_height\":\"104\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_576';

-- Type: half_5x2_max_576 (260x104) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"260\",\"rex_effect_resize_height\":\"104\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"260\",\"rex_effect_crop_height\":\"104\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_max_576';

-- Type: half_5x2_768 (360x144) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"360\",\"rex_effect_resize_height\":\"144\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"360\",\"rex_effect_crop_height\":\"144\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_768';

-- Type: half_5x2_max_768 (360x144) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"360\",\"rex_effect_resize_height\":\"144\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"360\",\"rex_effect_crop_height\":\"144\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_max_768';

-- Type: half_5x2_992 (480x192) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"480\",\"rex_effect_resize_height\":\"192\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"480\",\"rex_effect_crop_height\":\"192\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_992';

-- Type: half_5x2_max_992 (480x192) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"480\",\"rex_effect_resize_height\":\"192\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"480\",\"rex_effect_crop_height\":\"192\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_max_992';

-- Type: half_5x2_1200 (570x228) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"570\",\"rex_effect_resize_height\":\"228\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"570\",\"rex_effect_crop_height\":\"228\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_1200';

-- Type: half_5x2_max_1200 (570x228) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"570\",\"rex_effect_resize_height\":\"228\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"570\",\"rex_effect_crop_height\":\"228\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_max_1200';

-- Type: half_5x2_1400 (670x268) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"670\",\"rex_effect_resize_height\":\"268\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"670\",\"rex_effect_crop_height\":\"268\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_1400';

-- Type: half_5x2_max_1400 (670x268) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"670\",\"rex_effect_resize_height\":\"268\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"670\",\"rex_effect_crop_height\":\"268\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_5x2_max_1400';

-- Type: full_5x2_320 (280x112) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"280\",\"rex_effect_resize_height\":\"112\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"280\",\"rex_effect_crop_height\":\"112\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_320';

-- Type: full_5x2_max_320 (280x112) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"280\",\"rex_effect_resize_height\":\"112\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"280\",\"rex_effect_crop_height\":\"112\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_max_320';

-- Type: full_5x2_576 (520x208) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"520\",\"rex_effect_resize_height\":\"208\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"520\",\"rex_effect_crop_height\":\"208\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_576';

-- Type: full_5x2_max_576 (520x208) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"520\",\"rex_effect_resize_height\":\"208\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"520\",\"rex_effect_crop_height\":\"208\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_max_576';

-- Type: full_5x2_768 (720x288) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"720\",\"rex_effect_resize_height\":\"288\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"720\",\"rex_effect_crop_height\":\"288\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_768';

-- Type: full_5x2_max_768 (720x288) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"720\",\"rex_effect_resize_height\":\"288\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"720\",\"rex_effect_crop_height\":\"288\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_max_768';

-- Type: full_5x2_992 (960x384) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"960\",\"rex_effect_resize_height\":\"384\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"960\",\"rex_effect_crop_height\":\"384\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_992';

-- Type: full_5x2_max_992 (960x384) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"960\",\"rex_effect_resize_height\":\"384\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"960\",\"rex_effect_crop_height\":\"384\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_max_992';

-- Type: full_5x2_1200 (1140x456) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1140\",\"rex_effect_resize_height\":\"456\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1140\",\"rex_effect_crop_height\":\"456\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_1200';

-- Type: full_5x2_max_1200 (1140x456) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1140\",\"rex_effect_resize_height\":\"456\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1140\",\"rex_effect_crop_height\":\"456\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_max_1200';

-- Type: full_5x2_1400 (1320x528) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1320\",\"rex_effect_resize_height\":\"528\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1320\",\"rex_effect_crop_height\":\"528\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_1400';

-- Type: full_5x2_max_1400 (1320x528) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1320\",\"rex_effect_resize_height\":\"528\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1320\",\"rex_effect_crop_height\":\"528\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_5x2_max_1400';

-- Type: hero_5x2_768 (768x307) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"768\",\"rex_effect_resize_height\":\"307\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"768\",\"rex_effect_crop_height\":\"307\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_768';

-- Type: hero_5x2_max_768 (768x307) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"768\",\"rex_effect_resize_height\":\"307\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"768\",\"rex_effect_crop_height\":\"307\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_max_768';

-- Type: hero_5x2_992 (992x397) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"992\",\"rex_effect_resize_height\":\"397\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"992\",\"rex_effect_crop_height\":\"397\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_992';

-- Type: hero_5x2_max_992 (992x397) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"992\",\"rex_effect_resize_height\":\"397\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"992\",\"rex_effect_crop_height\":\"397\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_max_992';

-- Type: hero_5x2_1200 (1200x480) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1200\",\"rex_effect_resize_height\":\"480\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1200\",\"rex_effect_crop_height\":\"480\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_1200';

-- Type: hero_5x2_max_1200 (1200x480) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1200\",\"rex_effect_resize_height\":\"480\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1200\",\"rex_effect_crop_height\":\"480\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_max_1200';

-- Type: hero_5x2_1400 (1400x560) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1400\",\"rex_effect_resize_height\":\"560\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1400\",\"rex_effect_crop_height\":\"560\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_1400';

-- Type: hero_5x2_max_1400 (1400x560) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1400\",\"rex_effect_resize_height\":\"560\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1400\",\"rex_effect_crop_height\":\"560\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_max_1400';

-- Type: hero_5x2_1920 (1920x768) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1920\",\"rex_effect_resize_height\":\"768\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1920\",\"rex_effect_crop_height\":\"768\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_1920';

-- Type: hero_5x2_max_1920 (1920x768) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1920\",\"rex_effect_resize_height\":\"768\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_max_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1920\",\"rex_effect_crop_height\":\"768\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_max_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_5x2_max_1920';

-- Type: small_4x1_320 (120x30) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"120\",\"rex_effect_resize_height\":\"30\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x1_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"120\",\"rex_effect_crop_height\":\"30\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x1_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x1_320';

-- Type: small_4x1_max_320 (120x30) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"120\",\"rex_effect_resize_height\":\"30\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x1_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"120\",\"rex_effect_crop_height\":\"30\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x1_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x1_max_320';

-- Type: small_4x1_576 (180x45) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"180\",\"rex_effect_resize_height\":\"45\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x1_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"180\",\"rex_effect_crop_height\":\"45\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x1_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x1_576';

-- Type: small_4x1_max_576 (180x45) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"180\",\"rex_effect_resize_height\":\"45\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x1_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"180\",\"rex_effect_crop_height\":\"45\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x1_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x1_max_576';

-- Type: small_4x1_768 (240x60) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"240\",\"rex_effect_resize_height\":\"60\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x1_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"240\",\"rex_effect_crop_height\":\"60\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x1_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x1_768';

-- Type: small_4x1_max_768 (240x60) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"240\",\"rex_effect_resize_height\":\"60\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x1_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"240\",\"rex_effect_crop_height\":\"60\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x1_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_4x1_max_768';

-- Type: half_4x1_320 (140x35) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"140\",\"rex_effect_resize_height\":\"35\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"140\",\"rex_effect_crop_height\":\"35\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_320';

-- Type: half_4x1_max_320 (140x35) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"140\",\"rex_effect_resize_height\":\"35\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"140\",\"rex_effect_crop_height\":\"35\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_max_320';

-- Type: half_4x1_576 (260x65) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"260\",\"rex_effect_resize_height\":\"65\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"260\",\"rex_effect_crop_height\":\"65\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_576';

-- Type: half_4x1_max_576 (260x65) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"260\",\"rex_effect_resize_height\":\"65\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"260\",\"rex_effect_crop_height\":\"65\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_max_576';

-- Type: half_4x1_768 (360x90) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"360\",\"rex_effect_resize_height\":\"90\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"360\",\"rex_effect_crop_height\":\"90\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_768';

-- Type: half_4x1_max_768 (360x90) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"360\",\"rex_effect_resize_height\":\"90\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"360\",\"rex_effect_crop_height\":\"90\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_max_768';

-- Type: half_4x1_992 (480x120) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"480\",\"rex_effect_resize_height\":\"120\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"480\",\"rex_effect_crop_height\":\"120\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_992';

-- Type: half_4x1_max_992 (480x120) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"480\",\"rex_effect_resize_height\":\"120\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"480\",\"rex_effect_crop_height\":\"120\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_max_992';

-- Type: half_4x1_1200 (570x143) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"570\",\"rex_effect_resize_height\":\"143\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"570\",\"rex_effect_crop_height\":\"143\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_1200';

-- Type: half_4x1_max_1200 (570x143) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"570\",\"rex_effect_resize_height\":\"143\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"570\",\"rex_effect_crop_height\":\"143\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_max_1200';

-- Type: half_4x1_1400 (670x168) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"670\",\"rex_effect_resize_height\":\"168\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"670\",\"rex_effect_crop_height\":\"168\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_1400';

-- Type: half_4x1_max_1400 (670x168) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"670\",\"rex_effect_resize_height\":\"168\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"670\",\"rex_effect_crop_height\":\"168\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_4x1_max_1400';

-- Type: full_4x1_320 (280x70) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"280\",\"rex_effect_resize_height\":\"70\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"280\",\"rex_effect_crop_height\":\"70\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_320';

-- Type: full_4x1_max_320 (280x70) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"280\",\"rex_effect_resize_height\":\"70\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"280\",\"rex_effect_crop_height\":\"70\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_max_320';

-- Type: full_4x1_576 (520x130) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"520\",\"rex_effect_resize_height\":\"130\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"520\",\"rex_effect_crop_height\":\"130\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_576';

-- Type: full_4x1_max_576 (520x130) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"520\",\"rex_effect_resize_height\":\"130\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"520\",\"rex_effect_crop_height\":\"130\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_max_576';

-- Type: full_4x1_768 (720x180) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"720\",\"rex_effect_resize_height\":\"180\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"720\",\"rex_effect_crop_height\":\"180\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_768';

-- Type: full_4x1_max_768 (720x180) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"720\",\"rex_effect_resize_height\":\"180\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"720\",\"rex_effect_crop_height\":\"180\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_max_768';

-- Type: full_4x1_992 (960x240) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"960\",\"rex_effect_resize_height\":\"240\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"960\",\"rex_effect_crop_height\":\"240\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_992';

-- Type: full_4x1_max_992 (960x240) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"960\",\"rex_effect_resize_height\":\"240\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"960\",\"rex_effect_crop_height\":\"240\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_max_992';

-- Type: full_4x1_1200 (1140x285) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1140\",\"rex_effect_resize_height\":\"285\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1140\",\"rex_effect_crop_height\":\"285\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_1200';

-- Type: full_4x1_max_1200 (1140x285) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1140\",\"rex_effect_resize_height\":\"285\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1140\",\"rex_effect_crop_height\":\"285\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_max_1200';

-- Type: full_4x1_1400 (1320x330) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1320\",\"rex_effect_resize_height\":\"330\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1320\",\"rex_effect_crop_height\":\"330\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_1400';

-- Type: full_4x1_max_1400 (1320x330) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1320\",\"rex_effect_resize_height\":\"330\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1320\",\"rex_effect_crop_height\":\"330\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_4x1_max_1400';

-- Type: hero_4x1_768 (768x192) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"768\",\"rex_effect_resize_height\":\"192\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"768\",\"rex_effect_crop_height\":\"192\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_768';

-- Type: hero_4x1_max_768 (768x192) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"768\",\"rex_effect_resize_height\":\"192\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"768\",\"rex_effect_crop_height\":\"192\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_max_768';

-- Type: hero_4x1_992 (992x248) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"992\",\"rex_effect_resize_height\":\"248\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"992\",\"rex_effect_crop_height\":\"248\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_992';

-- Type: hero_4x1_max_992 (992x248) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"992\",\"rex_effect_resize_height\":\"248\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"992\",\"rex_effect_crop_height\":\"248\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_max_992';

-- Type: hero_4x1_1200 (1200x300) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1200\",\"rex_effect_resize_height\":\"300\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1200\",\"rex_effect_crop_height\":\"300\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_1200';

-- Type: hero_4x1_max_1200 (1200x300) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1200\",\"rex_effect_resize_height\":\"300\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1200\",\"rex_effect_crop_height\":\"300\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_max_1200';

-- Type: hero_4x1_1400 (1400x350) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1400\",\"rex_effect_resize_height\":\"350\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1400\",\"rex_effect_crop_height\":\"350\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_1400';

-- Type: hero_4x1_max_1400 (1400x350) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1400\",\"rex_effect_resize_height\":\"350\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1400\",\"rex_effect_crop_height\":\"350\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_max_1400';

-- Type: hero_4x1_1920 (1920x480) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1920\",\"rex_effect_resize_height\":\"480\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1920\",\"rex_effect_crop_height\":\"480\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_1920';

-- Type: hero_4x1_max_1920 (1920x480) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1920\",\"rex_effect_resize_height\":\"480\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_max_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1920\",\"rex_effect_crop_height\":\"480\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_max_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_4x1_max_1920';

-- Type: small_2x1_320 (120x60) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"120\",\"rex_effect_resize_height\":\"60\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_2x1_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"120\",\"rex_effect_crop_height\":\"60\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_2x1_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_2x1_320';

-- Type: small_2x1_max_320 (120x60) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"120\",\"rex_effect_resize_height\":\"60\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_2x1_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"120\",\"rex_effect_crop_height\":\"60\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_2x1_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_2x1_max_320';

-- Type: small_2x1_576 (180x90) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"180\",\"rex_effect_resize_height\":\"90\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_2x1_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"180\",\"rex_effect_crop_height\":\"90\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_2x1_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_2x1_576';

-- Type: small_2x1_max_576 (180x90) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"180\",\"rex_effect_resize_height\":\"90\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_2x1_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"180\",\"rex_effect_crop_height\":\"90\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_2x1_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_2x1_max_576';

-- Type: small_2x1_768 (240x120) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"240\",\"rex_effect_resize_height\":\"120\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_2x1_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"240\",\"rex_effect_crop_height\":\"120\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_2x1_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_2x1_768';

-- Type: small_2x1_max_768 (240x120) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"240\",\"rex_effect_resize_height\":\"120\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_2x1_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"240\",\"rex_effect_crop_height\":\"120\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_2x1_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_2x1_max_768';

-- Type: half_2x1_320 (140x70) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"140\",\"rex_effect_resize_height\":\"70\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"140\",\"rex_effect_crop_height\":\"70\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_320';

-- Type: half_2x1_max_320 (140x70) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"140\",\"rex_effect_resize_height\":\"70\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"140\",\"rex_effect_crop_height\":\"70\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_max_320';

-- Type: half_2x1_576 (260x130) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"260\",\"rex_effect_resize_height\":\"130\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"260\",\"rex_effect_crop_height\":\"130\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_576';

-- Type: half_2x1_max_576 (260x130) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"260\",\"rex_effect_resize_height\":\"130\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"260\",\"rex_effect_crop_height\":\"130\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_max_576';

-- Type: half_2x1_768 (360x180) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"360\",\"rex_effect_resize_height\":\"180\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"360\",\"rex_effect_crop_height\":\"180\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_768';

-- Type: half_2x1_max_768 (360x180) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"360\",\"rex_effect_resize_height\":\"180\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"360\",\"rex_effect_crop_height\":\"180\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_max_768';

-- Type: half_2x1_992 (480x240) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"480\",\"rex_effect_resize_height\":\"240\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"480\",\"rex_effect_crop_height\":\"240\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_992';

-- Type: half_2x1_max_992 (480x240) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"480\",\"rex_effect_resize_height\":\"240\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"480\",\"rex_effect_crop_height\":\"240\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_max_992';

-- Type: half_2x1_1200 (570x285) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"570\",\"rex_effect_resize_height\":\"285\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"570\",\"rex_effect_crop_height\":\"285\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_1200';

-- Type: half_2x1_max_1200 (570x285) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"570\",\"rex_effect_resize_height\":\"285\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"570\",\"rex_effect_crop_height\":\"285\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_max_1200';

-- Type: half_2x1_1400 (670x335) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"670\",\"rex_effect_resize_height\":\"335\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"670\",\"rex_effect_crop_height\":\"335\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_1400';

-- Type: half_2x1_max_1400 (670x335) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"670\",\"rex_effect_resize_height\":\"335\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"670\",\"rex_effect_crop_height\":\"335\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_2x1_max_1400';

-- Type: full_2x1_320 (280x140) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"280\",\"rex_effect_resize_height\":\"140\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"280\",\"rex_effect_crop_height\":\"140\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_320';

-- Type: full_2x1_max_320 (280x140) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"280\",\"rex_effect_resize_height\":\"140\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"280\",\"rex_effect_crop_height\":\"140\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_max_320';

-- Type: full_2x1_576 (520x260) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"520\",\"rex_effect_resize_height\":\"260\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"520\",\"rex_effect_crop_height\":\"260\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_576';

-- Type: full_2x1_max_576 (520x260) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"520\",\"rex_effect_resize_height\":\"260\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"520\",\"rex_effect_crop_height\":\"260\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_max_576';

-- Type: full_2x1_768 (720x360) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"720\",\"rex_effect_resize_height\":\"360\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"720\",\"rex_effect_crop_height\":\"360\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_768';

-- Type: full_2x1_max_768 (720x360) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"720\",\"rex_effect_resize_height\":\"360\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"720\",\"rex_effect_crop_height\":\"360\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_max_768';

-- Type: full_2x1_992 (960x480) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"960\",\"rex_effect_resize_height\":\"480\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"960\",\"rex_effect_crop_height\":\"480\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_992';

-- Type: full_2x1_max_992 (960x480) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"960\",\"rex_effect_resize_height\":\"480\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"960\",\"rex_effect_crop_height\":\"480\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_max_992';

-- Type: full_2x1_1200 (1140x570) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1140\",\"rex_effect_resize_height\":\"570\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1140\",\"rex_effect_crop_height\":\"570\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_1200';

-- Type: full_2x1_max_1200 (1140x570) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1140\",\"rex_effect_resize_height\":\"570\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1140\",\"rex_effect_crop_height\":\"570\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_max_1200';

-- Type: full_2x1_1400 (1320x660) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1320\",\"rex_effect_resize_height\":\"660\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1320\",\"rex_effect_crop_height\":\"660\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_1400';

-- Type: full_2x1_max_1400 (1320x660) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1320\",\"rex_effect_resize_height\":\"660\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1320\",\"rex_effect_crop_height\":\"660\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_2x1_max_1400';

-- Type: hero_2x1_768 (768x384) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"768\",\"rex_effect_resize_height\":\"384\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"768\",\"rex_effect_crop_height\":\"384\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_768';

-- Type: hero_2x1_max_768 (768x384) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"768\",\"rex_effect_resize_height\":\"384\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"768\",\"rex_effect_crop_height\":\"384\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_max_768';

-- Type: hero_2x1_992 (992x496) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"992\",\"rex_effect_resize_height\":\"496\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"992\",\"rex_effect_crop_height\":\"496\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_992';

-- Type: hero_2x1_max_992 (992x496) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"992\",\"rex_effect_resize_height\":\"496\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"992\",\"rex_effect_crop_height\":\"496\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_max_992';

-- Type: hero_2x1_1200 (1200x600) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1200\",\"rex_effect_resize_height\":\"600\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1200\",\"rex_effect_crop_height\":\"600\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_1200';

-- Type: hero_2x1_max_1200 (1200x600) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1200\",\"rex_effect_resize_height\":\"600\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1200\",\"rex_effect_crop_height\":\"600\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_max_1200';

-- Type: hero_2x1_1400 (1400x700) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1400\",\"rex_effect_resize_height\":\"700\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1400\",\"rex_effect_crop_height\":\"700\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_1400';

-- Type: hero_2x1_max_1400 (1400x700) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1400\",\"rex_effect_resize_height\":\"700\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1400\",\"rex_effect_crop_height\":\"700\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_max_1400';

-- Type: hero_2x1_1920 (1920x960) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1920\",\"rex_effect_resize_height\":\"960\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1920\",\"rex_effect_crop_height\":\"960\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_1920';

-- Type: hero_2x1_max_1920 (1920x960) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1920\",\"rex_effect_resize_height\":\"960\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_max_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1920\",\"rex_effect_crop_height\":\"960\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_max_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_2x1_max_1920';

-- Type: small_16x9_320 (120x68) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"120\",\"rex_effect_resize_height\":\"68\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_16x9_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"120\",\"rex_effect_crop_height\":\"68\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_16x9_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_16x9_320';

-- Type: small_16x9_max_320 (120x68) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"120\",\"rex_effect_resize_height\":\"68\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_16x9_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"120\",\"rex_effect_crop_height\":\"68\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_16x9_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_16x9_max_320';

-- Type: small_16x9_576 (180x101) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"180\",\"rex_effect_resize_height\":\"101\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_16x9_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"180\",\"rex_effect_crop_height\":\"101\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_16x9_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_16x9_576';

-- Type: small_16x9_max_576 (180x101) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"180\",\"rex_effect_resize_height\":\"101\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_16x9_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"180\",\"rex_effect_crop_height\":\"101\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_16x9_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_16x9_max_576';

-- Type: small_16x9_768 (240x135) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"240\",\"rex_effect_resize_height\":\"135\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_16x9_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"240\",\"rex_effect_crop_height\":\"135\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_16x9_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_16x9_768';

-- Type: small_16x9_max_768 (240x135) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"240\",\"rex_effect_resize_height\":\"135\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_16x9_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"240\",\"rex_effect_crop_height\":\"135\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_16x9_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_16x9_max_768';

-- Type: half_16x9_320 (140x79) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"140\",\"rex_effect_resize_height\":\"79\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"140\",\"rex_effect_crop_height\":\"79\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_320';

-- Type: half_16x9_max_320 (140x79) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"140\",\"rex_effect_resize_height\":\"79\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"140\",\"rex_effect_crop_height\":\"79\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_max_320';

-- Type: half_16x9_576 (260x146) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"260\",\"rex_effect_resize_height\":\"146\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"260\",\"rex_effect_crop_height\":\"146\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_576';

-- Type: half_16x9_max_576 (260x146) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"260\",\"rex_effect_resize_height\":\"146\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"260\",\"rex_effect_crop_height\":\"146\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_max_576';

-- Type: half_16x9_768 (360x203) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"360\",\"rex_effect_resize_height\":\"203\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"360\",\"rex_effect_crop_height\":\"203\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_768';

-- Type: half_16x9_max_768 (360x203) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"360\",\"rex_effect_resize_height\":\"203\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"360\",\"rex_effect_crop_height\":\"203\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_max_768';

-- Type: half_16x9_992 (480x270) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"480\",\"rex_effect_resize_height\":\"270\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"480\",\"rex_effect_crop_height\":\"270\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_992';

-- Type: half_16x9_max_992 (480x270) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"480\",\"rex_effect_resize_height\":\"270\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"480\",\"rex_effect_crop_height\":\"270\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_max_992';

-- Type: half_16x9_1200 (570x321) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"570\",\"rex_effect_resize_height\":\"321\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"570\",\"rex_effect_crop_height\":\"321\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_1200';

-- Type: half_16x9_max_1200 (570x321) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"570\",\"rex_effect_resize_height\":\"321\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"570\",\"rex_effect_crop_height\":\"321\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_max_1200';

-- Type: half_16x9_1400 (670x377) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"670\",\"rex_effect_resize_height\":\"377\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"670\",\"rex_effect_crop_height\":\"377\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_1400';

-- Type: half_16x9_max_1400 (670x377) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"670\",\"rex_effect_resize_height\":\"377\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"670\",\"rex_effect_crop_height\":\"377\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_16x9_max_1400';

-- Type: full_16x9_320 (280x158) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"280\",\"rex_effect_resize_height\":\"158\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"280\",\"rex_effect_crop_height\":\"158\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_320';

-- Type: full_16x9_max_320 (280x158) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"280\",\"rex_effect_resize_height\":\"158\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"280\",\"rex_effect_crop_height\":\"158\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_max_320';

-- Type: full_16x9_576 (520x293) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"520\",\"rex_effect_resize_height\":\"293\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"520\",\"rex_effect_crop_height\":\"293\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_576';

-- Type: full_16x9_max_576 (520x293) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"520\",\"rex_effect_resize_height\":\"293\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"520\",\"rex_effect_crop_height\":\"293\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_max_576';

-- Type: full_16x9_768 (720x405) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"720\",\"rex_effect_resize_height\":\"405\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"720\",\"rex_effect_crop_height\":\"405\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_768';

-- Type: full_16x9_max_768 (720x405) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"720\",\"rex_effect_resize_height\":\"405\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"720\",\"rex_effect_crop_height\":\"405\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_max_768';

-- Type: full_16x9_992 (960x540) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"960\",\"rex_effect_resize_height\":\"540\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"960\",\"rex_effect_crop_height\":\"540\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_992';

-- Type: full_16x9_max_992 (960x540) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"960\",\"rex_effect_resize_height\":\"540\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"960\",\"rex_effect_crop_height\":\"540\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_max_992';

-- Type: full_16x9_1200 (1140x641) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1140\",\"rex_effect_resize_height\":\"641\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1140\",\"rex_effect_crop_height\":\"641\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_1200';

-- Type: full_16x9_max_1200 (1140x641) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1140\",\"rex_effect_resize_height\":\"641\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1140\",\"rex_effect_crop_height\":\"641\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_max_1200';

-- Type: full_16x9_1400 (1320x743) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1320\",\"rex_effect_resize_height\":\"743\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1320\",\"rex_effect_crop_height\":\"743\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_1400';

-- Type: full_16x9_max_1400 (1320x743) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1320\",\"rex_effect_resize_height\":\"743\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1320\",\"rex_effect_crop_height\":\"743\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_16x9_max_1400';

-- Type: hero_16x9_768 (768x432) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"768\",\"rex_effect_resize_height\":\"432\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"768\",\"rex_effect_crop_height\":\"432\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_768';

-- Type: hero_16x9_max_768 (768x432) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"768\",\"rex_effect_resize_height\":\"432\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"768\",\"rex_effect_crop_height\":\"432\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_max_768';

-- Type: hero_16x9_992 (992x558) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"992\",\"rex_effect_resize_height\":\"558\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"992\",\"rex_effect_crop_height\":\"558\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_992';

-- Type: hero_16x9_max_992 (992x558) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"992\",\"rex_effect_resize_height\":\"558\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"992\",\"rex_effect_crop_height\":\"558\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_max_992';

-- Type: hero_16x9_1200 (1200x675) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1200\",\"rex_effect_resize_height\":\"675\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1200\",\"rex_effect_crop_height\":\"675\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_1200';

-- Type: hero_16x9_max_1200 (1200x675) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1200\",\"rex_effect_resize_height\":\"675\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1200\",\"rex_effect_crop_height\":\"675\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_max_1200';

-- Type: hero_16x9_1400 (1400x788) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1400\",\"rex_effect_resize_height\":\"788\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1400\",\"rex_effect_crop_height\":\"788\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_1400';

-- Type: hero_16x9_max_1400 (1400x788) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1400\",\"rex_effect_resize_height\":\"788\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1400\",\"rex_effect_crop_height\":\"788\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_max_1400';

-- Type: hero_16x9_1920 (1920x1080) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1920\",\"rex_effect_resize_height\":\"1080\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1920\",\"rex_effect_crop_height\":\"1080\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_1920';

-- Type: hero_16x9_max_1920 (1920x1080) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1920\",\"rex_effect_resize_height\":\"1080\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_max_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1920\",\"rex_effect_crop_height\":\"1080\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_max_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_16x9_max_1920';

-- Type: small_21x9_320 (120x51) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"120\",\"rex_effect_resize_height\":\"51\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_21x9_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"120\",\"rex_effect_crop_height\":\"51\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_21x9_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_21x9_320';

-- Type: small_21x9_max_320 (120x51) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"120\",\"rex_effect_resize_height\":\"51\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_21x9_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"120\",\"rex_effect_crop_height\":\"51\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_21x9_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_21x9_max_320';

-- Type: small_21x9_576 (180x77) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"180\",\"rex_effect_resize_height\":\"77\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_21x9_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"180\",\"rex_effect_crop_height\":\"77\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_21x9_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_21x9_576';

-- Type: small_21x9_max_576 (180x77) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"180\",\"rex_effect_resize_height\":\"77\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_21x9_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"180\",\"rex_effect_crop_height\":\"77\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_21x9_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_21x9_max_576';

-- Type: small_21x9_768 (240x103) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"240\",\"rex_effect_resize_height\":\"103\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_21x9_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"240\",\"rex_effect_crop_height\":\"103\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_21x9_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_21x9_768';

-- Type: small_21x9_max_768 (240x103) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"240\",\"rex_effect_resize_height\":\"103\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_21x9_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"240\",\"rex_effect_crop_height\":\"103\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_21x9_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'small_21x9_max_768';

-- Type: half_21x9_320 (140x60) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"140\",\"rex_effect_resize_height\":\"60\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"140\",\"rex_effect_crop_height\":\"60\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_320';

-- Type: half_21x9_max_320 (140x60) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"140\",\"rex_effect_resize_height\":\"60\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"140\",\"rex_effect_crop_height\":\"60\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_max_320';

-- Type: half_21x9_576 (260x111) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"260\",\"rex_effect_resize_height\":\"111\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"260\",\"rex_effect_crop_height\":\"111\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_576';

-- Type: half_21x9_max_576 (260x111) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"260\",\"rex_effect_resize_height\":\"111\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"260\",\"rex_effect_crop_height\":\"111\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_max_576';

-- Type: half_21x9_768 (360x154) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"360\",\"rex_effect_resize_height\":\"154\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"360\",\"rex_effect_crop_height\":\"154\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_768';

-- Type: half_21x9_max_768 (360x154) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"360\",\"rex_effect_resize_height\":\"154\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"360\",\"rex_effect_crop_height\":\"154\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_max_768';

-- Type: half_21x9_992 (480x206) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"480\",\"rex_effect_resize_height\":\"206\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"480\",\"rex_effect_crop_height\":\"206\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_992';

-- Type: half_21x9_max_992 (480x206) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"480\",\"rex_effect_resize_height\":\"206\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"480\",\"rex_effect_crop_height\":\"206\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_max_992';

-- Type: half_21x9_1200 (570x244) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"570\",\"rex_effect_resize_height\":\"244\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"570\",\"rex_effect_crop_height\":\"244\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_1200';

-- Type: half_21x9_max_1200 (570x244) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"570\",\"rex_effect_resize_height\":\"244\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"570\",\"rex_effect_crop_height\":\"244\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_max_1200';

-- Type: half_21x9_1400 (670x287) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"670\",\"rex_effect_resize_height\":\"287\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"670\",\"rex_effect_crop_height\":\"287\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_1400';

-- Type: half_21x9_max_1400 (670x287) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"670\",\"rex_effect_resize_height\":\"287\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"670\",\"rex_effect_crop_height\":\"287\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'half_21x9_max_1400';

-- Type: full_21x9_320 (280x120) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"280\",\"rex_effect_resize_height\":\"120\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"280\",\"rex_effect_crop_height\":\"120\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_320';

-- Type: full_21x9_max_320 (280x120) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"280\",\"rex_effect_resize_height\":\"120\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"280\",\"rex_effect_crop_height\":\"120\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_max_320';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_max_320';

-- Type: full_21x9_576 (520x223) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"520\",\"rex_effect_resize_height\":\"223\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"520\",\"rex_effect_crop_height\":\"223\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_576';

-- Type: full_21x9_max_576 (520x223) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"520\",\"rex_effect_resize_height\":\"223\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"520\",\"rex_effect_crop_height\":\"223\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_max_576';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_max_576';

-- Type: full_21x9_768 (720x309) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"720\",\"rex_effect_resize_height\":\"309\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"720\",\"rex_effect_crop_height\":\"309\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_768';

-- Type: full_21x9_max_768 (720x309) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"720\",\"rex_effect_resize_height\":\"309\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"720\",\"rex_effect_crop_height\":\"309\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_max_768';

-- Type: full_21x9_992 (960x411) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"960\",\"rex_effect_resize_height\":\"411\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"960\",\"rex_effect_crop_height\":\"411\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_992';

-- Type: full_21x9_max_992 (960x411) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"960\",\"rex_effect_resize_height\":\"411\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"960\",\"rex_effect_crop_height\":\"411\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_max_992';

-- Type: full_21x9_1200 (1140x489) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1140\",\"rex_effect_resize_height\":\"489\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1140\",\"rex_effect_crop_height\":\"489\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_1200';

-- Type: full_21x9_max_1200 (1140x489) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1140\",\"rex_effect_resize_height\":\"489\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1140\",\"rex_effect_crop_height\":\"489\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_max_1200';

-- Type: full_21x9_1400 (1320x566) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1320\",\"rex_effect_resize_height\":\"566\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1320\",\"rex_effect_crop_height\":\"566\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_1400';

-- Type: full_21x9_max_1400 (1320x566) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1320\",\"rex_effect_resize_height\":\"566\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1320\",\"rex_effect_crop_height\":\"566\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'full_21x9_max_1400';

-- Type: hero_21x9_768 (768x329) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"768\",\"rex_effect_resize_height\":\"329\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"768\",\"rex_effect_crop_height\":\"329\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_768';

-- Type: hero_21x9_max_768 (768x329) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"768\",\"rex_effect_resize_height\":\"329\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"768\",\"rex_effect_crop_height\":\"329\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_max_768';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_max_768';

-- Type: hero_21x9_992 (992x425) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"992\",\"rex_effect_resize_height\":\"425\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"992\",\"rex_effect_crop_height\":\"425\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_992';

-- Type: hero_21x9_max_992 (992x425) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"992\",\"rex_effect_resize_height\":\"425\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"992\",\"rex_effect_crop_height\":\"425\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_max_992';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_max_992';

-- Type: hero_21x9_1200 (1200x514) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1200\",\"rex_effect_resize_height\":\"514\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1200\",\"rex_effect_crop_height\":\"514\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_1200';

-- Type: hero_21x9_max_1200 (1200x514) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1200\",\"rex_effect_resize_height\":\"514\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1200\",\"rex_effect_crop_height\":\"514\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_max_1200';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_max_1200';

-- Type: hero_21x9_1400 (1400x600) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1400\",\"rex_effect_resize_height\":\"600\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1400\",\"rex_effect_crop_height\":\"600\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_1400';

-- Type: hero_21x9_max_1400 (1400x600) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1400\",\"rex_effect_resize_height\":\"600\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1400\",\"rex_effect_crop_height\":\"600\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_max_1400';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_max_1400';

-- Type: hero_21x9_1920 (1920x823) - MODUS: minimum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1920\",\"rex_effect_resize_height\":\"823\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1920\",\"rex_effect_crop_height\":\"823\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_1920';

-- Type: hero_21x9_max_1920 (1920x823) - MODUS: maximum
INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'resize',
    '{\"rex_effect_resize\":{\"rex_effect_resize_width\":\"1920\",\"rex_effect_resize_height\":\"823\",\"rex_effect_resize_style\":\"maximum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"}}',
    1,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_max_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'crop',
    '{\"rex_effect_crop\":{\"rex_effect_crop_width\":\"1920\",\"rex_effect_crop_height\":\"823\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"}}',
    2,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_max_1920';

INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)
SELECT 
    type.id,
    'image_format',
    '{\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"}}',
    3,
    '2025-08-09 00:00:00',
    'admin',
    '2025-08-09 00:00:00',
    'admin'
FROM rex_media_manager_type type
WHERE type.name = 'hero_21x9_max_1920';

-- AUFRÄUMEN: Temporäre Tabelle löschen
DROP TABLE IF EXISTS temp_media_types;

-- ================================================================================
-- VALIDIERUNGS-QUERIES FÜR ERWEITERTE MODUS-UNTERSCHEIDUNG
-- ================================================================================

-- Prüfung aller Types mit Modus-Aufschlüsselung:
-- SELECT 
--     CASE 
--         WHEN name LIKE '%_max_%' OR name LIKE '%_max' THEN 'maximum'
--         ELSE 'minimum'
--     END as modus,
--     CASE 
--         WHEN name LIKE 'small_%' THEN 'small'
--         WHEN name LIKE 'half_%' THEN 'half' 
--         WHEN name LIKE 'full_%' THEN 'full'
--         ELSE 'special'
--     END as serie,
--     COUNT(*) as count
-- FROM rex_media_manager_type 
-- WHERE name REGEXP '^(small|half|full)'
-- GROUP BY modus, serie
-- ORDER BY serie, modus;

-- Beispiel-Types prüfen:
-- SELECT name, description FROM rex_media_manager_type 
-- WHERE name IN ('half_576', 'half_max_576', 'half_4x3_1200', 'half_4x3_max_1200')
-- ORDER BY name;

-- WebP-Effekte prüfen:
-- SELECT COUNT(*) as webp_effects_count 
-- FROM rex_media_manager_type_effect 
-- WHERE effect = 'image_format' 
-- AND parameters LIKE '%webp%';

-- Beispiel Type mit allen Effekten:
-- SELECT t.name, e.effect, e.priority, e.parameters 
-- FROM rex_media_manager_type t 
-- JOIN rex_media_manager_type_effect e ON t.id = e.type_id 
-- WHERE t.name = 'half_4x3_1200' 
-- ORDER BY e.priority;

-- ================================================================================
-- ERWEITERTE GENERIERUNG MIT WEBP-KONVERTIERUNG ERFOLGREICH ABGESCHLOSSEN!
-- ================================================================================
-- STATISTIK MIT MODUS-UNTERSCHEIDUNG UND WEBP
-- ================================================================================
-- Spezielle Component Types: 0 (Custom Types)
-- Standard Types (minimum): 180
-- Standard Types (maximum): 180
-- GESAMT Media Manager Types: 360
-- Effekte generiert: 1040 (inkl. WebP-Konvertierung)
-- Generierung abgeschlossen: 2025-08-13 07:38:31
-- 
-- NAMENSKONVENTION:
-- ✅ Minimum (Standard): half_576, half_4x3_1200
-- ✅ Maximum: half_max_576, half_4x3_max_1200
-- ✅ Alle Serien: small, half, full
-- ✅ Alle Ratios: 1x1, 3x2, 4x3, 5x2, 4x1, 2x1, 16x9, 21x9
-- ✅ Alle Breakpoints: Je nach Serie
-- 
-- EFFEKT-REIHENFOLGE:
-- ✅ Priority 1: Resize (mit korrektem Modus)
-- ✅ Priority 2: Crop (nur bei Ratio-Types) oder WebP (bei Standard-Types)
-- ✅ Priority 3: WebP-Konvertierung (bei Ratio-Types)
-- 
-- WEBP-VORTEILE:
-- ✅ 25-35% kleinere Dateien als JPEG
-- ✅ Bessere Ladezeiten
-- ✅ Mobile-optimiert
-- ✅ Moderne Browser-Unterstützung
-- 
-- MODUS-UNTERSCHIEDE:
-- ✅ Minimum: Bild passt in Rahmen (behält Proportionen)
-- ✅ Maximum: Bild füllt Rahmen (behält Proportionen, kann überstehen)
-- ✅ Ratio-Types: Beide Modi + Crop für exakte Dimensionen
