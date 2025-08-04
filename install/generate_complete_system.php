<?php
// VOLLSTÄNDIGER GENERATOR FÜR RESPONSIVE MEDIA MANAGER SYSTEM
// Erstellt ZUERST alle Types, dann alle Effekte für project/boot.php kompatibles System

$series = [
    // Standard ohne Ratio
    'small' => [
        'breakpoints' => [320, 576, 768],
        'baseDimensions' => [120, 180, 240]
    ],
    'half' => [
        'breakpoints' => [320, 576, 768, 992, 1200, 1400],
        'baseDimensions' => [140, 260, 360, 480, 570, 670]
    ],
    'full' => [
        'breakpoints' => [320, 576, 768, 992, 1200, 1400],
        'baseDimensions' => [280, 520, 720, 960, 1140, 1320]
    ]
];

$ratios = [
    '1x1' => [1, 1],
    '4x3' => [4, 3],
    '3x2' => [3, 2],
    '5x4' => [5, 4],
    '2x1' => [2, 1],
    '16x9' => [16, 9],
    '21x9' => [21, 9]
];

$jsonTemplate = '{\"rex_effect_rounded_corners\":{\"rex_effect_rounded_corners_topleft\":\"\",\"rex_effect_rounded_corners_topright\":\"\",\"rex_effect_rounded_corners_bottomleft\":\"\",\"rex_effect_rounded_corners_bottomright\":\"\"},\"rex_effect_workspace\":{\"rex_effect_workspace_set_transparent\":\"colored\",\"rex_effect_workspace_width\":\"\",\"rex_effect_workspace_height\":\"\",\"rex_effect_workspace_hpos\":\"left\",\"rex_effect_workspace_vpos\":\"top\",\"rex_effect_workspace_padding_x\":\"0\",\"rex_effect_workspace_padding_y\":\"0\",\"rex_effect_workspace_bg_r\":\"\",\"rex_effect_workspace_bg_g\":\"\",\"rex_effect_workspace_bg_b\":\"\",\"rex_effect_workspace_bgimage\":\"\"},\"rex_effect_crop\":{\"rex_effect_crop_width\":\"CROP_WIDTH\",\"rex_effect_crop_height\":\"CROP_HEIGHT\",\"rex_effect_crop_offset_width\":\"\",\"rex_effect_crop_offset_height\":\"\",\"rex_effect_crop_hpos\":\"center\",\"rex_effect_crop_vpos\":\"middle\"},\"rex_effect_insert_image\":{\"rex_effect_insert_image_brandimage\":\"\",\"rex_effect_insert_image_hpos\":\"left\",\"rex_effect_insert_image_vpos\":\"top\",\"rex_effect_insert_image_padding_x\":\"-10\",\"rex_effect_insert_image_padding_y\":\"-10\"},\"rex_effect_rotate\":{\"rex_effect_rotate_rotate\":\"0\"},\"rex_effect_filter_colorize\":{\"rex_effect_filter_colorize_filter_r\":\"\",\"rex_effect_filter_colorize_filter_g\":\"\",\"rex_effect_filter_colorize_filter_b\":\"\"},\"rex_effect_image_properties\":{\"rex_effect_image_properties_jpg_quality\":\"\",\"rex_effect_image_properties_png_compression\":\"\",\"rex_effect_image_properties_webp_quality\":\"\",\"rex_effect_image_properties_avif_quality\":\"\",\"rex_effect_image_properties_avif_speed\":\"\",\"rex_effect_image_properties_interlace\":null},\"rex_effect_filter_brightness\":{\"rex_effect_filter_brightness_brightness\":\"\"},\"rex_effect_flip\":{\"rex_effect_flip_flip\":\"X\"},\"rex_effect_image_format\":{\"rex_effect_image_format_convert_to\":\"webp\"},\"rex_effect_filter_contrast\":{\"rex_effect_filter_contrast_contrast\":\"\"},\"rex_effect_filter_sharpen\":{\"rex_effect_filter_sharpen_amount\":\"80\",\"rex_effect_filter_sharpen_radius\":\"0.5\",\"rex_effect_filter_sharpen_threshold\":\"3\"},\"rex_effect_resize\":{\"rex_effect_resize_width\":\"RESIZE_WIDTH\",\"rex_effect_resize_height\":\"RESIZE_HEIGHT\",\"rex_effect_resize_style\":\"minimum\",\"rex_effect_resize_allow_enlarge\":\"enlarge\"},\"rex_effect_filter_blur\":{\"rex_effect_filter_blur_repeats\":\"10\",\"rex_effect_filter_blur_type\":\"gaussian\",\"rex_effect_filter_blur_smoothit\":\"\"},\"rex_effect_mirror\":{\"rex_effect_mirror_height\":\"\",\"rex_effect_mirror_opacity\":\"100\",\"rex_effect_mirror_set_transparent\":\"colored\",\"rex_effect_mirror_bg_r\":\"\",\"rex_effect_mirror_bg_g\":\"\",\"rex_effect_mirror_bg_b\":\"\"},\"rex_effect_header\":{\"rex_effect_header_download\":\"open_media\",\"rex_effect_header_cache\":\"no_cache\",\"rex_effect_header_filename\":\"filename\",\"rex_effect_header_index\":\"index\"},\"rex_effect_convert2img\":{\"rex_effect_convert2img_convert_to\":\"jpg\",\"rex_effect_convert2img_density\":\"150\",\"rex_effect_convert2img_color\":\"\"},\"rex_effect_mediapath\":{\"rex_effect_mediapath_mediapath\":\"\"}}';

$output = "-- ================================================================================\n";
$output .= "-- VOLLSTÄNDIGES RESPONSIVE MEDIA MANAGER SYSTEM - TYPES + EFFECTS\n";
$output .= "-- Generiert für project/boot.php kompatibles System\n";
$output .= "-- WICHTIG: Erst werden alle Types erstellt, dann alle Effekte!\n";
$output .= "-- Datum: " . date('Y-m-d H:i:s') . "\n";
$output .= "-- ================================================================================\n\n";

$typeCount = 0;
$effectCount = 0;
$allTypeNames = []; // Sammle alle Type-Namen für später

// ================================================================================
// PHASE 1: ALLE MEDIA MANAGER TYPES ERSTELLEN
// ================================================================================

$output .= "-- ================================================================================\n";
$output .= "-- PHASE 1: ALLE MEDIA MANAGER TYPES ERSTELLEN\n";
$output .= "-- ================================================================================\n\n";

$output .= "INSERT INTO `rex_media_manager_type` (`name`, `description`, `status`, `createdate`, `createuser`, `updatedate`, `updateuser`) VALUES\n";

$typeEntries = [];

// Standard ohne Ratio
foreach ($series as $sizeName => $sizeConfig) {
    foreach ($sizeConfig['breakpoints'] as $idx => $breakpoint) {
        $width = $sizeConfig['baseDimensions'][$idx];
        $height = $width; // Standard quadratisch für base types
        
        $typeName = $sizeName . '_' . $breakpoint;
        $allTypeNames[] = $typeName;
        $typeCount++;
        
        $typeEntries[] = "('{$typeName}', '{$sizeName} für Breakpoint {$breakpoint}px ({$width}x{$height})', 0, '2025-08-04 00:00:00', 'admin', '2025-08-04 00:00:00', 'admin')";
    }
}

// Ratio Varianten
foreach ($ratios as $ratioName => $ratioValues) {
    foreach ($series as $sizeName => $sizeConfig) {
        foreach ($sizeConfig['breakpoints'] as $idx => $breakpoint) {
            $baseWidth = $sizeConfig['baseDimensions'][$idx];
            
            // Berechne Ratio-Dimensionen
            $width = $baseWidth;
            $height = round($baseWidth * $ratioValues[1] / $ratioValues[0]);
            
            $typeName = $sizeName . '_' . $ratioName . '_' . $breakpoint;
            $allTypeNames[] = $typeName;
            $typeCount++;
            
            $typeEntries[] = "('{$typeName}', '{$sizeName} {$ratioName} für Breakpoint {$breakpoint}px ({$width}x{$height})', 0, '2025-08-04 00:00:00', 'admin', '2025-08-04 00:00:00', 'admin')";
        }
    }
}

$output .= implode(",\n", $typeEntries);
$output .= ";\n\n";

// ================================================================================
// PHASE 2: ALLE EFFEKTE ERSTELLEN
// ================================================================================

$output .= "-- ================================================================================\n";
$output .= "-- PHASE 2: ALLE EFFEKTE FÜR DIE ERSTELLTEN TYPES\n";
$output .= "-- ================================================================================\n\n";

// Standard ohne Ratio - Effekte
foreach ($series as $sizeName => $sizeConfig) {
    $output .= "-- ================================================================================\n";
    $output .= "-- " . strtoupper($sizeName) . " SERIE - STANDARD (OHNE RATIO) - EFFEKTE\n";
    $output .= "-- ================================================================================\n\n";
    
    foreach ($sizeConfig['breakpoints'] as $idx => $breakpoint) {
        $width = $sizeConfig['baseDimensions'][$idx];
        $height = $width; // Standard quadratisch für base types
        
        $typeName = $sizeName . '_' . $breakpoint;
        
        $output .= "-- Type: {$typeName} ({$width}x{$height})\n";
        
        // Resize Effect
        $resizeJson = str_replace(['RESIZE_WIDTH', 'RESIZE_HEIGHT', 'CROP_WIDTH', 'CROP_HEIGHT'], [$width, $height, '', ''], $jsonTemplate);
        $output .= "INSERT INTO `rex_media_manager_type_effect` (`type_id`, `effect`, `parameters`, `priority`, `createdate`, `createuser`, `updatedate`, `updateuser`) VALUES\n";
        $output .= "((SELECT id FROM rex_media_manager_type WHERE name = '{$typeName}'), 'resize', '{$resizeJson}', 1, '2025-08-04 00:00:00', 'admin', '2025-08-04 00:00:00', 'admin');\n\n";
        $effectCount++;
        
        // Crop Effect
        $cropJson = str_replace(['RESIZE_WIDTH', 'RESIZE_HEIGHT', 'CROP_WIDTH', 'CROP_HEIGHT'], ['', '', $width, $height], $jsonTemplate);
        $cropJson = str_replace('"rex_effect_resize_style":"minimum"', '"rex_effect_resize_style":"maximum"', $cropJson);
        $output .= "INSERT INTO `rex_media_manager_type_effect` (`type_id`, `effect`, `parameters`, `priority`, `createdate`, `createuser`, `updatedate`, `updateuser`) VALUES\n";
        $output .= "((SELECT id FROM rex_media_manager_type WHERE name = '{$typeName}'), 'crop', '{$cropJson}', 2, '2025-08-04 00:00:00', 'admin', '2025-08-04 00:00:00', 'admin');\n\n";
        $effectCount++;
    }
}

// Ratio Varianten - Effekte
foreach ($ratios as $ratioName => $ratioValues) {
    $output .= "-- ================================================================================\n";
    $output .= "-- " . strtoupper($ratioName) . " RATIO VARIANTEN - EFFEKTE\n";
    $output .= "-- ================================================================================\n\n";
    
    foreach ($series as $sizeName => $sizeConfig) {
        $output .= "-- {$sizeName} {$ratioName}\n";
        
        foreach ($sizeConfig['breakpoints'] as $idx => $breakpoint) {
            $baseWidth = $sizeConfig['baseDimensions'][$idx];
            
            // Berechne Ratio-Dimensionen
            $width = $baseWidth;
            $height = round($baseWidth * $ratioValues[1] / $ratioValues[0]);
            
            $typeName = $sizeName . '_' . $ratioName . '_' . $breakpoint;
            
            $output .= "-- Type: {$typeName} ({$width}x{$height})\n";
            
            // Resize Effect
            $resizeJson = str_replace(['RESIZE_WIDTH', 'RESIZE_HEIGHT', 'CROP_WIDTH', 'CROP_HEIGHT'], [$width, $height, '', ''], $jsonTemplate);
            $output .= "INSERT INTO `rex_media_manager_type_effect` (`type_id`, `effect`, `parameters`, `priority`, `createdate`, `createuser`, `updatedate`, `updateuser`) VALUES\n";
            $output .= "((SELECT id FROM rex_media_manager_type WHERE name = '{$typeName}'), 'resize', '{$resizeJson}', 1, '2025-08-04 00:00:00', 'admin', '2025-08-04 00:00:00', 'admin');\n\n";
            $effectCount++;
            
            // Crop Effect
            $cropJson = str_replace(['RESIZE_WIDTH', 'RESIZE_HEIGHT', 'CROP_WIDTH', 'CROP_HEIGHT'], ['', '', $width, $height], $jsonTemplate);
            $cropJson = str_replace('"rex_effect_resize_style":"minimum"', '"rex_effect_resize_style":"maximum"', $cropJson);
            $output .= "INSERT INTO `rex_media_manager_type_effect` (`type_id`, `effect`, `parameters`, `priority`, `createdate`, `createuser`, `updatedate`, `updateuser`) VALUES\n";
            $output .= "((SELECT id FROM rex_media_manager_type WHERE name = '{$typeName}'), 'crop', '{$cropJson}', 2, '2025-08-04 00:00:00', 'admin', '2025-08-04 00:00:00', 'admin');\n\n";
            $effectCount++;
        }
        $output .= "\n";
    }
}

// ================================================================================
// VALIDIERUNGS-QUERIES
// ================================================================================

$output .= "-- ================================================================================\n";
$output .= "-- VALIDIERUNGS-QUERIES FÜR PROJECT/BOOT.PHP KOMPATIBILITÄT\n";
$output .= "-- ================================================================================\n\n";

$output .= "-- Prüfung aller Types:\n";
$output .= "-- SELECT COUNT(*) as total_types FROM rex_media_manager_type WHERE name REGEXP '^(small|half|full)(_[0-9]+|_[0-9x]+_[0-9]+)\$';\n\n";

$output .= "-- Prüfung nach Serie:\n";
$output .= "-- SELECT \n";
$output .= "--     CASE \n";
$output .= "--         WHEN name LIKE 'small_%' THEN 'small'\n";
$output .= "--         WHEN name LIKE 'half_%' THEN 'half' \n";
$output .= "--         WHEN name LIKE 'full_%' THEN 'full'\n";
$output .= "--     END as serie,\n";
$output .= "--     COUNT(*) as count\n";
$output .= "-- FROM rex_media_manager_type \n";
$output .= "-- WHERE name REGEXP '^(small|half|full)(_[0-9]+|_[0-9x]+_[0-9]+)\$'\n";
$output .= "-- GROUP BY serie;\n\n";

$output .= "-- Prüfung der Effekte:\n";
$output .= "-- SELECT t.name, COUNT(e.id) as effect_count \n";
$output .= "-- FROM rex_media_manager_type t \n";
$output .= "-- LEFT JOIN rex_media_manager_type_effect e ON t.id = e.type_id \n";
$output .= "-- WHERE t.name REGEXP '^(small|half|full)(_[0-9]+|_[0-9x]+_[0-9]+)\$'\n";
$output .= "-- GROUP BY t.id\n";
$output .= "-- HAVING effect_count != 2\n";
$output .= "-- ORDER BY t.name;\n\n";

$output .= "-- ================================================================================\n";
$output .= "-- STATISTIK\n";
$output .= "-- ================================================================================\n";
$output .= "-- Media Manager Types: {$typeCount}\n";
$output .= "-- Effekte generiert: {$effectCount}\n";
$output .= "-- Effekte pro Type: 2 (resize + crop)\n";
$output .= "-- Generierung abgeschlossen: " . date('Y-m-d H:i:s') . "\n";
$output .= "-- \n";
$output .= "-- IMPORT-REIHENFOLGE:\n";
$output .= "-- 1. Alle Media Manager Types werden erstellt\n";
$output .= "-- 2. Alle Effekte werden den Types zugeordnet\n";
$output .= "-- 3. System ist bereit für project/boot.php\n";

echo "VOLLSTÄNDIGER RESPONSIVE MEDIA MANAGER GENERATOR\n";
echo "=================================================\n\n";
echo "🔄 Generiere komplettes System (Types + Effekte)...\n\n";
echo "📊 STATISTIK:\n";
echo "- Media Manager Types: {$typeCount}\n";
echo "- Effekte generiert: {$effectCount}\n";
echo "- Effekte pro Type: 2 (resize + crop)\n\n";
echo "✅ SQL-Output generiert!\n";
echo "💾 Schreibe in Datei...\n\n";

// Schreibe in SQL-Datei
$filename = 'responsive_complete_system.sql';
file_put_contents($filename, $output);

echo "🎯 ERFOLGREICH GENERIERT:\n";
echo "   Datei: {$filename}\n";
echo "   Größe: " . number_format(filesize($filename)) . " Bytes\n\n";
echo "🚀 IMPORT-REIHENFOLGE:\n";
echo "   1. ✅ Types werden zuerst erstellt\n";
echo "   2. ✅ Effekte werden dann zugeordnet\n";
echo "   3. ✅ Keine 'type_id cannot be null' Fehler!\n\n";
echo "🎯 Bereit für REDAXO Import!\n";
?>
