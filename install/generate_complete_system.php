<?php
// ERWEITERTE SQL-GENERATION MIT MINIMUM/MAXIMUM MODUS-UNTERSCHEIDUNG
// Neue Namenskonvention: [series]_[ratio]_[modus]_[breakpoint]
// Beispiele:
// - half_576 (minimum, Standard)
// - half_max_576 (maximum)
// - half_4x3_1200 (minimum mit Ratio)
// - half_4x3_max_1200 (maximum mit Ratio)

$series = [
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
    ],
    'hero' => [
        'breakpoints' => [768, 992, 1200, 1400, 1920],
        'baseDimensions' => [768, 992, 1200, 1400, 1920]
    ]
];

$ratios = [
    '1x1' => [1, 1],         // Team Member, Module Config
    '3x2' => [3, 2],         // Team Member Overview
    '4x3' => [4, 3],         // NewsCard Card View, Standard
    '5x2' => [5, 2],         // NewsCard Detail, Highlights, FAQ, Slider 
    '4x1' => [4, 1],         // FAQ Alternative, Full Width
    '2x1' => [2, 1],         // Landscape
    '16x9' => [16, 9],       // Video Format
    '21x9' => [21, 9]        // Ultra Wide
];

// Modi für Resize-Verhalten
$modes = [
    'min' => [
        'suffix' => '',       // Kein Suffix für minimum (Standard)
        'style' => 'minimum', // Behält Seitenverhältnis, passt in Rahmen
        'description' => 'Minimum (behält Proportionen, passt in Rahmen)'
    ],
    'max' => [
        'suffix' => '_max',   // "_max" Suffix für maximum
        'style' => 'maximum', // Behält Seitenverhältnis, füllt Rahmen
        'description' => 'Maximum (behält Proportionen, füllt Rahmen)'
    ]
];

// Spezielle Media Manager Types können hier ergänzt werden
$specialTypes = [
    // Beispiel für Custom Types:
    // 'custom_thumb' => [
    //     'description' => 'Custom Thumbnail für spezielle Components',
    //     'width' => 300,
    //     'height' => 225,
    //     'ratio' => '4x3',
    //     'mode' => 'min'
    // ],
    // 'hero_background' => [
    //     'description' => 'Hero Background für Fullscreen-Bereiche',
    //     'width' => 1920,
    //     'height' => 1080,
    //     'ratio' => '16x9',
    //     'mode' => 'max'
    // ]
];

echo "ERWEITERTE RESPONSIVE MEDIA MANAGER GENERATOR\n";
echo "MIT MINIMUM/MAXIMUM MODUS-UNTERSCHEIDUNG UND WEBP\n";
echo "FÜR REDAXO FOR ADDON (GENERISCH)\n";
echo "=================================================\n\n";

$output = "-- ================================================================================\n";
$output .= "-- GENERISCHES RESPONSIVE MEDIA MANAGER SYSTEM FÜR REDAXO FOR ADDON\n";
$output .= "-- Neue Namenskonvention: [series]_[ratio]_[modus]_[breakpoint]\n";
$output .= "-- Minimum (Standard): half_576, half_4x3_1200\n";
$output .= "-- Maximum: half_max_576, half_4x3_max_1200\n";
$output .= "-- WebP-Konvertierung: Automatisch für alle Types\n";
$output .= "-- Datum: " . date('Y-m-d H:i:s') . "\n";
$output .= "-- ================================================================================\n\n";

$output .= "-- VORBEREITUNG: Temporäre Tabelle für sichere ID-Mapping\n";
$output .= "DROP TABLE IF EXISTS temp_media_types;\n";
$output .= "CREATE TEMPORARY TABLE temp_media_types (\n";
$output .= "    temp_id INT AUTO_INCREMENT PRIMARY KEY,\n";
$output .= "    type_name VARCHAR(191) UNIQUE,\n";
$output .= "    type_description TEXT,\n";
$output .= "    type_width INT,\n";
$output .= "    type_height INT NULL,\n";
$output .= "    resize_style VARCHAR(20),\n";
$output .= "    has_ratio BOOLEAN DEFAULT FALSE,\n";
$output .= "    mode_suffix VARCHAR(10)\n";
$output .= ");\n\n";

$typeCount = 0;
$effectCount = 0;
$allTypes = [];

// ================================================================================
// PHASE 1: ALLE MEDIA MANAGER TYPES SAMMELN
// ================================================================================

echo "🔄 Sammle Media Manager Types mit Modus-Varianten...\n";

$output .= "-- ================================================================================\n";
$output .= "-- PHASE 1: SAMMLE ALLE TYPES IN TEMPORÄRER TABELLE\n";
$output .= "-- ================================================================================\n\n";

// Spezielle Types zuerst (nur minimum)
foreach ($specialTypes as $typeName => $config) {
    $mode = $modes[$config['mode']];
    $allTypes[] = [
        'name' => $typeName,
        'description' => $config['description'] . " ({$config['width']}x{$config['height']}) - {$mode['description']}",
        'width' => $config['width'],
        'height' => $config['height'],
        'hasRatio' => true,
        'resizeStyle' => $mode['style'],
        'modeSuffix' => $mode['suffix']
    ];
    $typeCount++;
}

// Standard-Types OHNE Ratio - für BEIDE Modi (min + max)
foreach ($series as $sizeName => $sizeConfig) {
    foreach ($sizeConfig['breakpoints'] as $idx => $breakpoint) {
        $width = $sizeConfig['baseDimensions'][$idx];
        
        // Generiere für BEIDE Modi
        foreach ($modes as $modeKey => $modeConfig) {
            $typeName = $sizeName . $modeConfig['suffix'] . '_' . $breakpoint;
            
            $allTypes[] = [
                'name' => $typeName,
                'description' => "{$sizeName} für Breakpoint {$breakpoint}px (Breite {$width}px) - {$modeConfig['description']}",
                'width' => $width,
                'height' => null, // KEINE feste Höhe für Standard-Types!
                'hasRatio' => false,
                'resizeStyle' => $modeConfig['style'],
                'modeSuffix' => $modeConfig['suffix']
            ];
            $typeCount++;
        }
    }
}

// Ratio-Types MIT fester Höhe - für BEIDE Modi (min + max)
foreach ($ratios as $ratioName => $ratioValues) {
    foreach ($series as $sizeName => $sizeConfig) {
        foreach ($sizeConfig['breakpoints'] as $idx => $breakpoint) {
            $baseWidth = $sizeConfig['baseDimensions'][$idx];
            $width = $baseWidth;
            $height = round($baseWidth * $ratioValues[1] / $ratioValues[0]);
            
            // Generiere für BEIDE Modi
            foreach ($modes as $modeKey => $modeConfig) {
                $typeName = $sizeName . '_' . $ratioName . $modeConfig['suffix'] . '_' . $breakpoint;
                
                $allTypes[] = [
                    'name' => $typeName,
                    'description' => "{$sizeName} {$ratioName} für Breakpoint {$breakpoint}px ({$width}x{$height}) - {$modeConfig['description']}",
                    'width' => $width,
                    'height' => $height,
                    'hasRatio' => true,
                    'resizeStyle' => $modeConfig['style'],
                    'modeSuffix' => $modeConfig['suffix']
                ];
                $typeCount++;
            }
        }
    }
}

echo "Media Manager Types gesammelt: {$typeCount} (inkl. min/max Varianten)\n";

// Füge Types in temp Tabelle ein
foreach ($allTypes as $type) {
    $name = $type['name'];
    $desc = addslashes($type['description']);
    $width = $type['width'];
    $height = $type['height'];
    $resizeStyle = $type['resizeStyle'];
    $hasRatio = $type['hasRatio'] ? 'TRUE' : 'FALSE';
    $modeSuffix = $type['modeSuffix'];
    
    if ($height === null) {
        $output .= "INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('{$name}', '{$desc}', {$width}, NULL, '{$resizeStyle}', {$hasRatio}, '{$modeSuffix}');\n";
    } else {
        $output .= "INSERT IGNORE INTO temp_media_types (type_name, type_description, type_width, type_height, resize_style, has_ratio, mode_suffix) VALUES ('{$name}', '{$desc}', {$width}, {$height}, '{$resizeStyle}', {$hasRatio}, '{$modeSuffix}');\n";
    }
}

$output .= "\n-- PHASE 2: Sichere Erstellung der Media Manager Types\n";
$output .= "INSERT INTO rex_media_manager_type (name, description, status, createdate, createuser, updatedate, updateuser)\n";
$output .= "SELECT \n";
$output .= "    type_name,\n";
$output .= "    type_description,\n";
$output .= "    0,\n";
$output .= "    '2025-08-09 00:00:00',\n";
$output .= "    'admin',\n";
$output .= "    '2025-08-09 00:00:00',\n";
$output .= "    'admin'\n";
$output .= "FROM temp_media_types\n";
$output .= "ON DUPLICATE KEY UPDATE \n";
$output .= "    description = VALUES(description),\n";
$output .= "    updatedate = VALUES(updatedate);\n\n";

// ================================================================================
// PHASE 3: ERWEITERTE EFFEKT-ERSTELLUNG MIT MODUS-BERÜCKSICHTIGUNG
// ================================================================================

echo "🔄 Generiere Effekte mit Modus-Berücksichtigung...\n";

$output .= "-- ================================================================================\n";
$output .= "-- PHASE 3: ERWEITERTE EFFEKT-ERSTELLUNG MIT MODUS-BERÜCKSICHTIGUNG\n";
$output .= "-- Standard-Types: Resize mit minimum/maximum Style\n";
$output .= "-- Ratio-Types: Resize (mit Modus) + Crop für exakte Dimensionen\n";
$output .= "-- ================================================================================\n\n";

// Lösche existierende Effekte für Update-Fähigkeit
$typeNames = array_map(function($type) { return "'{$type['name']}'"; }, $allTypes);
$output .= "-- Lösche existierende Effekte für Update-Fähigkeit\n";
$output .= "DELETE effect FROM rex_media_manager_type_effect effect \n";
$output .= "INNER JOIN rex_media_manager_type type ON effect.type_id = type.id \n";
$output .= "WHERE type.name IN (\n";
$output .= "    " . implode(",\n    ", $typeNames) . "\n";
$output .= ");\n\n";

// Templates für verschiedene Resize-Modi
$resizeTemplates = [
    'minimum' => '{"rex_effect_resize":{"rex_effect_resize_width":"RESIZE_WIDTH","rex_effect_resize_height":"RESIZE_HEIGHT","rex_effect_resize_style":"minimum","rex_effect_resize_allow_enlarge":"enlarge"}}',
    'maximum' => '{"rex_effect_resize":{"rex_effect_resize_width":"RESIZE_WIDTH","rex_effect_resize_height":"RESIZE_HEIGHT","rex_effect_resize_style":"maximum","rex_effect_resize_allow_enlarge":"enlarge"}}'
];

// Standard Resize Template für Types ohne feste Höhe
$resizeOnlyTemplates = [
    'minimum' => '{"rex_effect_resize":{"rex_effect_resize_width":"RESIZE_WIDTH","rex_effect_resize_height":"","rex_effect_resize_style":"minimum","rex_effect_resize_allow_enlarge":"enlarge"}}',
    'maximum' => '{"rex_effect_resize":{"rex_effect_resize_width":"RESIZE_WIDTH","rex_effect_resize_height":"","rex_effect_resize_style":"maximum","rex_effect_resize_allow_enlarge":"enlarge"}}'
];

$cropTemplate = '{"rex_effect_crop":{"rex_effect_crop_width":"CROP_WIDTH","rex_effect_crop_height":"CROP_HEIGHT","rex_effect_crop_offset_width":"","rex_effect_crop_offset_height":"","rex_effect_crop_hpos":"center","rex_effect_crop_vpos":"middle"}}';

// WebP-Konvertierung Template
$webpTemplate = '{"rex_effect_image_format":{"rex_effect_image_format_convert_to":"webp"}}';

$cropTemplate = '{"rex_effect_crop":{"rex_effect_crop_width":"CROP_WIDTH","rex_effect_crop_height":"CROP_HEIGHT","rex_effect_crop_offset_width":"","rex_effect_crop_offset_height":"","rex_effect_crop_hpos":"center","rex_effect_crop_vpos":"middle"}}';

foreach ($allTypes as $type) {
    $name = $type['name'];
    $width = $type['width'];
    $height = $type['height'];
    $hasRatio = $type['hasRatio'];
    $resizeStyle = $type['resizeStyle'];
    $modeSuffix = $type['modeSuffix'];
    
    if ($hasRatio && $height) {
        // RATIO-TYPES: Resize (mit korrektem Modus) + Crop
        $output .= "-- Type: {$name} ({$width}x{$height}) - MODUS: {$resizeStyle}\n";
        
        // EFFEKT 1: Resize mit korrektem Modus
        $resizeJson = str_replace(
            ['RESIZE_WIDTH', 'RESIZE_HEIGHT'], 
            [$width, $height], 
            $resizeTemplates[$resizeStyle]
        );
        $resizeJson = addslashes($resizeJson);
        
        $output .= "INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)\n";
        $output .= "SELECT \n";
        $output .= "    type.id,\n";
        $output .= "    'resize',\n";
        $output .= "    '{$resizeJson}',\n";
        $output .= "    1,\n";
        $output .= "    '2025-08-09 00:00:00',\n";
        $output .= "    'admin',\n";
        $output .= "    '2025-08-09 00:00:00',\n";
        $output .= "    'admin'\n";
        $output .= "FROM rex_media_manager_type type\n";
        $output .= "WHERE type.name = '{$name}';\n\n";
        $effectCount++;
        
        // EFFEKT 2: Crop für exakte Dimensionen
        $cropJson = str_replace(
            ['CROP_WIDTH', 'CROP_HEIGHT'], 
            [$width, $height], 
            $cropTemplate
        );
        $cropJson = addslashes($cropJson);
        
        $output .= "INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)\n";
        $output .= "SELECT \n";
        $output .= "    type.id,\n";
        $output .= "    'crop',\n";
        $output .= "    '{$cropJson}',\n";
        $output .= "    2,\n";
        $output .= "    '2025-08-09 00:00:00',\n";
        $output .= "    'admin',\n";
        $output .= "    '2025-08-09 00:00:00',\n";
        $output .= "    'admin'\n";
        $output .= "FROM rex_media_manager_type type\n";
        $output .= "WHERE type.name = '{$name}';\n\n";
        $effectCount++;
        
        // EFFEKT 3: WebP-Konvertierung
        $webpJson = addslashes($webpTemplate);
        
        $output .= "INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)\n";
        $output .= "SELECT \n";
        $output .= "    type.id,\n";
        $output .= "    'image_format',\n";
        $output .= "    '{$webpJson}',\n";
        $output .= "    3,\n";
        $output .= "    '2025-08-09 00:00:00',\n";
        $output .= "    'admin',\n";
        $output .= "    '2025-08-09 00:00:00',\n";
        $output .= "    'admin'\n";
        $output .= "FROM rex_media_manager_type type\n";
        $output .= "WHERE type.name = '{$name}';\n\n";
        $effectCount++;
        
    } else {
        // STANDARD-TYPES: Nur Resize mit korrektem Modus
        $output .= "-- Type: {$name} (Breite {$width}px) - MODUS: {$resizeStyle}\n";
        
        $effectJson = str_replace('RESIZE_WIDTH', $width, $resizeOnlyTemplates[$resizeStyle]);
        $effectJson = addslashes($effectJson);
        
        $output .= "INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)\n";
        $output .= "SELECT \n";
        $output .= "    type.id,\n";
        $output .= "    'resize',\n";
        $output .= "    '{$effectJson}',\n";
        $output .= "    1,\n";
        $output .= "    '2025-08-09 00:00:00',\n";
        $output .= "    'admin',\n";
        $output .= "    '2025-08-09 00:00:00',\n";
        $output .= "    'admin'\n";
        $output .= "FROM rex_media_manager_type type\n";
        $output .= "WHERE type.name = '{$name}';\n\n";
        $effectCount++;
        
        // EFFEKT 2: WebP-Konvertierung (bei Standard-Types ohne Crop)
        $webpJson = addslashes($webpTemplate);
        
        $output .= "INSERT INTO rex_media_manager_type_effect (type_id, effect, parameters, priority, createdate, createuser, updatedate, updateuser)\n";
        $output .= "SELECT \n";
        $output .= "    type.id,\n";
        $output .= "    'image_format',\n";
        $output .= "    '{$webpJson}',\n";
        $output .= "    2,\n";
        $output .= "    '2025-08-09 00:00:00',\n";
        $output .= "    'admin',\n";
        $output .= "    '2025-08-09 00:00:00',\n";
        $output .= "    'admin'\n";
        $output .= "FROM rex_media_manager_type type\n";
        $output .= "WHERE type.name = '{$name}';\n\n";
        $effectCount++;
    }
}

$output .= "-- AUFRÄUMEN: Temporäre Tabelle löschen\n";
$output .= "DROP TABLE IF EXISTS temp_media_types;\n\n";

// ================================================================================
// VALIDIERUNGS-QUERIES UND STATISTIKEN
// ================================================================================

$output .= "-- ================================================================================\n";
$output .= "-- VALIDIERUNGS-QUERIES FÜR ERWEITERTE MODUS-UNTERSCHEIDUNG\n";
$output .= "-- ================================================================================\n\n";

$output .= "-- Prüfung aller Types mit Modus-Aufschlüsselung:\n";
$output .= "-- SELECT \n";
$output .= "--     CASE \n";
$output .= "--         WHEN name LIKE '%_max_%' OR name LIKE '%_max' THEN 'maximum'\n";
$output .= "--         ELSE 'minimum'\n";
$output .= "--     END as modus,\n";
$output .= "--     CASE \n";
$output .= "--         WHEN name LIKE 'small_%' THEN 'small'\n";
$output .= "--         WHEN name LIKE 'half_%' THEN 'half' \n";
$output .= "--         WHEN name LIKE 'full_%' THEN 'full'\n";
$output .= "--         ELSE 'special'\n";
$output .= "--     END as serie,\n";
$output .= "--     COUNT(*) as count\n";
$output .= "-- FROM rex_media_manager_type \n";
$output .= "-- WHERE name REGEXP '^(small|half|full)'\n";
$output .= "-- GROUP BY modus, serie\n";
$output .= "-- ORDER BY serie, modus;\n\n";

$output .= "-- Beispiel-Types prüfen:\n";
$output .= "-- SELECT name, description FROM rex_media_manager_type \n";
$output .= "-- WHERE name IN ('half_576', 'half_max_576', 'half_4x3_1200', 'half_4x3_max_1200')\n";
$output .= "-- ORDER BY name;\n\n";

$output .= "-- WebP-Effekte prüfen:\n";
$output .= "-- SELECT COUNT(*) as webp_effects_count \n";
$output .= "-- FROM rex_media_manager_type_effect \n";
$output .= "-- WHERE effect = 'image_format' \n";
$output .= "-- AND parameters LIKE '%webp%';\n\n";

$output .= "-- Beispiel Type mit allen Effekten:\n";
$output .= "-- SELECT t.name, e.effect, e.priority, e.parameters \n";
$output .= "-- FROM rex_media_manager_type t \n";
$output .= "-- JOIN rex_media_manager_type_effect e ON t.id = e.type_id \n";
$output .= "-- WHERE t.name = 'half_4x3_1200' \n";
$output .= "-- ORDER BY e.priority;\n\n";

$minCount = 0;
$maxCount = 0;
foreach ($allTypes as $type) {
    if (strpos($type['name'], '_max') !== false) {
        $maxCount++;
    } else {
        $minCount++;
    }
}

$output .= "-- ================================================================================\n";
$output .= "-- ERWEITERTE GENERIERUNG MIT WEBP-KONVERTIERUNG ERFOLGREICH ABGESCHLOSSEN!\n";
$output .= "-- ================================================================================\n";
$output .= "-- STATISTIK MIT MODUS-UNTERSCHEIDUNG UND WEBP\n";
$output .= "-- ================================================================================\n";
$output .= "-- Spezielle Component Types: " . count($specialTypes) . " (Custom Types)\n";
$output .= "-- Standard Types (minimum): {$minCount}\n";
$output .= "-- Standard Types (maximum): {$maxCount}\n";
$output .= "-- GESAMT Media Manager Types: {$typeCount}\n";
$output .= "-- Effekte generiert: {$effectCount} (inkl. WebP-Konvertierung)\n";
$output .= "-- Generierung abgeschlossen: " . date('Y-m-d H:i:s') . "\n";
$output .= "-- \n";
$output .= "-- NAMENSKONVENTION:\n";
$output .= "-- Minimum (Standard): half_576, half_4x3_1200\n";
$output .= "-- Maximum: half_max_576, half_4x3_max_1200\n";
$output .= "-- Alle Serien: small, half, full\n";
$output .= "-- Alle Ratios: 1x1, 3x2, 4x3, 5x2, 4x1, 2x1, 16x9, 21x9\n";
$output .= "-- Alle Breakpoints: Je nach Serie\n";
$output .= "-- \n";
$output .= "-- EFFEKT-REIHENFOLGE:\n";
$output .= "-- Priority 1: Resize (mit korrektem Modus)\n";
$output .= "-- Priority 2: Crop (nur bei Ratio-Types) oder WebP (bei Standard-Types)\n";
$output .= "-- Priority 3: WebP-Konvertierung (bei Ratio-Types)\n";
$output .= "-- \n";
$output .= "-- WEBP-VORTEILE:\n";
$output .= "-- 25-35% kleinere Dateien als JPEG\n";
$output .= "-- Bessere Ladezeiten\n";
$output .= "-- Mobile-optimiert\n";
$output .= "-- Moderne Browser-Unterstützung\n";
$output .= "-- \n";
$output .= "-- MODUS-UNTERSCHIEDE:\n";
$output .= "-- Minimum: Bild passt in Rahmen (behält Proportionen)\n";
$output .= "-- Maximum: Bild füllt Rahmen (behält Proportionen, kann überstehen)\n";
$output .= "-- Ratio-Types: Beide Modi + Crop für exakte Dimensionen\n";

echo "Effekte generiert: {$effectCount} (inkl. WebP)\n";
echo "📊 Minimum Types: {$minCount}\n";
echo "📊 Maximum Types: {$maxCount}\n";

// SQL-Datei schreiben
$filename = 'responsive_complete_system.sql';
file_put_contents($filename, $output);

echo "\n🎯 ERWEITERTE SQL-DATEI GENERIERT!\n";
echo "💾 Datei: {$filename}\n";
echo "💾 Größe: " . number_format(filesize($filename)) . " Bytes\n";

echo "\nNEUE FUNKTIONEN:\n";
echo "   1. Modus-Unterscheidung: minimum (Standard) vs maximum\n";
echo "   2. Namenskonvention: [series]_[ratio]_[modus]_[breakpoint]\n";
echo "   3. ✅ Beispiele: half_576 (min), half_max_576 (max)\n";
echo "   4. ✅ Ratio-Beispiele: half_4x3_1200 (min), half_4x3_max_1200 (max)\n";
echo "   5. ✅ WebP-Konvertierung für alle Types automatisch\n";
echo "   6. ✅ Sichere temporäre Tabellen\n";
echo "   7. ✅ Update-fähig mit ON DUPLICATE KEY\n\n";

echo "🎯 **WEBP-INTEGRATION:**\n";
echo "   - Standard-Types: Resize → WebP (Priority 1→2)\n";
echo "   - Ratio-Types: Resize → Crop → WebP (Priority 1→2→3)\n";
echo "   - Geschätzte Ersparnis: 25-35% kleinere Dateien\n";

echo "\n🎯 Bereit für REDAXO Import!\n";
?>
