<?php

/**
 * MFragment Responsive Media Helper Functions
 * 
 * Vollständiges responsives Bildersystem basierend auf dem complete SQL-Schema
 * Kompatibel zu Bootstrap 5 Breakpoints und optimiert für REDAXO Media Manager
 * 
 * Diese Datei ersetzt die Funktionalität aus der project/boot.php und macht
 * das mfragment Addon unabhängig von projektspezifischen Konfigurationen.
 */

// === CORE RESPONSIVE IMAGE FUNKTIONEN ===

/**
 * Optimierte Helper-Funktion: Prüft ob ein Media Manager Type existiert
 * Verwendet Request-lokalen Cache für beste Performance
 */
if (!function_exists('mediaManagerTypeExists')) {
    function mediaManagerTypeExists($typeName) {
        static $cache = null;
        
        // Cache laden beim ersten Aufruf pro Request
        if ($cache === null) {
            $sql = rex_sql::factory();
            $sql->setQuery('SELECT name FROM ' . rex::getTablePrefix() . 'media_manager_type');
            $cache = [];
            foreach ($sql as $row) {
                $cache[(string) $row->getValue('name')] = true;
            }
        }
        
        return isset($cache[$typeName]);
    }
}

/**
 * Optimierte Srcset-Generierung basierend auf dem vollständigen responsive Media Manager Types SQL-Schema
 * Unterstützt alle definierten Breakpoints und Ratio-Varianten (320-1400px)
 */
if (!function_exists('generateSrcset')) {
    function generateSrcset($mediaFile, $baseType = 'full') {
        if (!$mediaFile || !file_exists(rex_path::media($mediaFile))) {
            return '';
        }
        
        // Vollständige Bootstrap 5 Breakpoint-Konfiguration basierend auf SQL-Schema
        $responsiveBreakpoints = [
            // Standard responsive Varianten (ohne Ratio) - performance-optimiert
            'small' => [320, 576, 768], // Thumbnails und kleine Bilder
            'half' => [320, 576, 768, 992, 1200, 1400], // Mittlere Bilder, alle Breakpoints
            'full' => [320, 576, 768, 992, 1200, 1400], // Große Bilder, alle Breakpoints
            'hero' => [768, 992, 1200, 1400, 1920], // Hero-Bilder für Fullscreen-Bereiche
            
            // 1x1 Ratio Varianten - quadratische Bilder
            'small_1x1' => [320, 576, 768], // Kleine Quadrate (Icons, Avatare)
            'half_1x1' => [320, 576, 768, 992, 1200], // Mittlere Quadrate
            'full_1x1' => [320, 576, 768, 992, 1200], // Große Quadrate (performance-begrenzt)
            'hero_1x1' => [768, 992, 1200, 1400, 1920], // Hero Quadrate (Fullscreen)
            
            // 4x3 Ratio Varianten - klassisches Foto-Verhältnis
            'small_4x3' => [320, 576, 768], // Kleine 4:3 Bilder
            'half_4x3' => [320, 576, 768, 992, 1200], // Mittlere 4:3 Bilder
            'full_4x3' => [320, 576, 768, 992, 1200], // Große 4:3 Bilder (web-optimiert)
            'hero_4x3' => [768, 992, 1200, 1400, 1920], // Hero 4:3 (Fullscreen Standard)
            
            // 16x9 Ratio Varianten - Video-Format
            'half_16x9' => [576, 768, 992, 1200], // Mittlere 16:9 Videos
            'full_16x9' => [768, 992, 1200, 1400], // Große 16:9 Videos  
            'hero_16x9' => [768, 992, 1200, 1400, 1920], // Hero 16:9 (Fullscreen Video)
            
            // 21x9 Ratio Varianten - Cinematic Format
            'full_21x9' => [992, 1200, 1400], // Große 21:9 Cinematic
            'hero_21x9' => [992, 1200, 1400, 1920], // Hero 21:9 (Ultra-wide)
            
            // Direkte Ratio-Typen (ohne Size-Prefix) - nutzen half-Dimensionen
            '1x1' => [320, 576, 768, 992, 1200], // Standard quadratisch
            '4x3' => [320, 576, 768, 992, 1200], // Standard 4:3
            '16x9' => [576, 768, 992, 1200], // Standard 16:9
            '21x9' => [992, 1200, 1400], // Standard 21:9
            
            // Legacy Mapping für Rückwärtskompatibilität
            'content_full' => [320, 576, 768, 992, 1200, 1400],
            'content_half' => [320, 576, 768, 992, 1200],
            'content_small' => [320, 576, 768],
        ];
        
        $breakpoints = $responsiveBreakpoints[$baseType] ?? [576, 768, 992, 1200];
        $srcsetArray = [];
        
        foreach ($breakpoints as $breakpoint) {
            $responsiveType = $baseType . '_' . $breakpoint;
            
            // Prüfe ob responsive Typ existiert - mit optimiertem Cache
            if (mediaManagerTypeExists($responsiveType)) {
                $resizedUrl = rex_media_manager::getUrl($responsiveType, $mediaFile);
                
                // Ermittle die tatsächliche Bildbreite aus der SQL-Schema-Konfiguration
                $actualWidth = getActualImageWidth($responsiveType, $breakpoint, $baseType);
                $srcsetArray[] = $resizedUrl . ' ' . $actualWidth . 'w';
            }
        }
        
        return implode(', ', $srcsetArray);
    }
}

/**
 * Optimierte Hilfsfunktion: Ermittelt die tatsächliche Bildbreite basierend auf dem SQL-Schema
 * Vollständige Mapping-Tabelle aller definierten Media Manager Types
 */
if (!function_exists('getActualImageWidth')) {
    function getActualImageWidth($mediaManagerType, $breakpoint, $baseType = '') {
        // Vollständiges Mapping der tatsächlichen Bildbreiten aus dem SQL-Schema
        // Entspricht exakt den Werten aus responsive_complete_system.sql
        $actualWidths = [
            // ========== STANDARD RESPONSIVE VARIANTEN (ohne Ratio) ==========
            
            // Small Serie - Thumbnails und kleine Bilder
            'small_320' => 160,  // Small für Mobile Portrait
            'small_576' => 200,  // Small für Mobile Landscape  
            'small_768' => 250,  // Small für Tablet Portrait
            
            // Half Serie - Mittlere Bilder mit Container-optimierten Breiten
            'half_320' => 280,   // Half für Mobile Portrait
            'half_576' => 400,   // Half für Mobile Landscape
            'half_768' => 500,   // Half für Tablet Portrait
            'half_992' => 600,   // Half für Desktop Small
            'half_1200' => 700,  // Half für Desktop Standard
            'half_1400' => 800,  // Half für Large Desktop
            
            // Full Serie - Große Bilder entsprechend Bootstrap Container-Breiten
            'full_320' => 320,   // Full für Mobile Portrait
            'full_576' => 576,   // Full für Mobile Landscape
            'full_768' => 768,   // Full für Tablet Portrait
            'full_992' => 992,   // Full für Desktop Small
            'full_1200' => 1200, // Full für Desktop Standard
            'full_1400' => 1400, // Full für Large Desktop
            
            // Hero Serie - Fullscreen Bilder für große Bereiche
            'hero_768' => 768,   // Hero für Tablet Landscape
            'hero_992' => 992,   // Hero für Desktop Small
            'hero_1200' => 1200, // Hero für Desktop Standard
            'hero_1400' => 1400, // Hero für Large Desktop
            'hero_1920' => 1920, // Hero für Full HD
            
            // ========== 1x1 RATIO VARIANTEN (Quadratisch) ==========
            
            // Small 1x1 Serie - Kleine quadratische Bilder (Icons, Avatare)
            'small_1x1_320' => 120,  // 120x120 für Mobile
            'small_1x1_576' => 150,  // 150x150 für Mobile L
            'small_1x1_768' => 180,  // 180x180 für Tablet
            
            // Half 1x1 Serie - Mittlere quadratische Bilder
            'half_1x1_320' => 280,   // 280x280 für Mobile
            'half_1x1_576' => 400,   // 400x400 für Mobile L
            'half_1x1_768' => 500,   // 500x500 für Tablet
            'half_1x1_992' => 600,   // 600x600 für Desktop S
            'half_1x1_1200' => 700,  // 700x700 für Desktop
            
            // Full 1x1 Serie - Große quadratische Bilder (performance-begrenzt)
            'full_1x1_320' => 320,   // 320x320 für Mobile
            'full_1x1_576' => 576,   // 576x576 für Mobile L
            'full_1x1_768' => 768,   // 768x768 für Tablet
            'full_1x1_992' => 900,   // 900x900 für Desktop S (begrenzt)
            'full_1x1_1200' => 1000, // 1000x1000 für Desktop (begrenzt)
            
            // ========== 4x3 RATIO VARIANTEN (Klassisches Foto-Verhältnis) ==========
            
            // Small 4x3 Serie - Kleine 4:3 Bilder
            'small_4x3_320' => 160,  // 160x120 für Mobile
            'small_4x3_576' => 200,  // 200x150 für Mobile L
            'small_4x3_768' => 240,  // 240x180 für Tablet
            
            // Half 4x3 Serie - Mittlere 4:3 Bilder
            'half_4x3_320' => 280,   // 280x210 für Mobile
            'half_4x3_576' => 400,   // 400x300 für Mobile L
            'half_4x3_768' => 500,   // 500x375 für Tablet
            'half_4x3_992' => 600,   // 600x450 für Desktop S
            'half_4x3_1200' => 700,  // 700x525 für Desktop
            
            // Full 4x3 Serie - Große 4:3 Bilder (web-optimiert, max 1200px)
            'full_4x3_320' => 320,   // 320x240 für Mobile
            'full_4x3_576' => 576,   // 576x432 für Mobile L
            'full_4x3_768' => 768,   // 768x576 für Tablet
            'full_4x3_992' => 992,   // 992x744 für Desktop S
            'full_4x3_1200' => 1200, // 1200x900 für Desktop
            
            // ========== HERO RATIO VARIANTEN ==========
            
            // Hero 1x1 Serie - Quadratische Hero-Bilder
            'hero_1x1_768' => 768,   // 768x768 für Tablet Landscape
            'hero_1x1_992' => 992,   // 992x992 für Desktop Small
            'hero_1x1_1200' => 1200, // 1200x1200 für Desktop
            'hero_1x1_1400' => 1400, // 1400x1400 für Large Desktop
            'hero_1x1_1920' => 1920, // 1920x1920 für Full HD
            
            // Hero 4x3 Serie - Hero 4:3 Bilder  
            'hero_4x3_768' => 768,   // 768x576 für Tablet Landscape
            'hero_4x3_992' => 992,   // 992x744 für Desktop Small
            'hero_4x3_1200' => 1200, // 1200x900 für Desktop
            'hero_4x3_1400' => 1400, // 1400x1050 für Large Desktop
            'hero_4x3_1920' => 1920, // 1920x1440 für Full HD
            
            // Hero 16x9 Serie - Hero Video-Format
            'hero_16x9_768' => 768,  // 768x432 für Tablet Landscape
            'hero_16x9_992' => 992,  // 992x558 für Desktop Small
            'hero_16x9_1200' => 1200, // 1200x675 für Desktop
            'hero_16x9_1400' => 1400, // 1400x788 für Large Desktop
            'hero_16x9_1920' => 1920, // 1920x1080 für Full HD
            
            // Hero 21x9 Serie - Hero Cinematic
            'hero_21x9_992' => 992,   // 992x425 für Desktop Small
            'hero_21x9_1200' => 1200, // 1200x514 für Desktop
            'hero_21x9_1400' => 1400, // 1400x600 für Large Desktop
            'hero_21x9_1920' => 1920, // 1920x823 für Full HD
            
            // ========== ORIGINAL GRUNDTYPEN (Fallback) ==========
            'half' => 600,   // Original half Bildgröße
            'full' => 1200,  // Original full Bildgröße  
            'small' => 300,  // Original small Bildgröße
            'hero' => 1200,  // Hero Standard-Größe
            '1x1' => 600,    // 1x1 Ratio Quadratisch (600x600)
            '4x3' => 600,    // 4x3 Ratio Standard (600x450)
            '3x2' => 600,    // 3x2 Ratio Fotografie-Standard (600x400)
            '5x4' => 600,    // 5x4 Ratio Portrait-Mittel (600x480)
            '2x1' => 600,    // 2x1 Ratio Banner-Format (600x300)
            '16x9' => 600,   // 16x9 Ratio Widescreen (600x338)
            '21x9' => 600,   // 21x9 Ratio Ultra-Wide (600x257)
        ];
        
        // Fallback-Logik wenn exakter Type nicht gefunden wird
        if (isset($actualWidths[$mediaManagerType])) {
            return $actualWidths[$mediaManagerType];
        }
        
        // Intelligenter Fallback basierend auf Breakpoint und BaseType
        if ($baseType && $breakpoint) {
            // Versuche Standard-Mapping basierte auf BaseType
            $fallbackKey = $baseType . '_' . $breakpoint;
            if (isset($actualWidths[$fallbackKey])) {
                return $actualWidths[$fallbackKey];
            }
        }
        
        // Letzter Fallback: Nutze Breakpoint-Wert direkt
        return (int) $breakpoint;
    }
}

/**
 * Erweiterte Sizes-Attribute Generierung basierend auf Bootstrap 5 Container-Logik
 */
if (!function_exists('generateSizesForType')) {
    function generateSizesForType($baseType) {
        // Optimierte sizes-Attribute basierend auf dem vollständigen SQL-Schema
        // Unterstützt alle definierten Media Manager Types mit korrekten Container-Berechnungen
        switch ($baseType) {
            // ========== STANDARD RESPONSIVE TYPEN (ohne Ratio) ==========
            
            case 'full':
            case 'content_full':
                // Full-Width Bilder - nutzen komplette Container-Breiten
                return '(max-width: 319px) 320px, (max-width: 575px) 576px, (max-width: 767px) 768px, (max-width: 991px) 992px, (max-width: 1199px) 1200px, 1400px';
                
            case 'half':
            case 'content_half':
                // Half-Width Bilder - Container-optimierte Breiten für mittlere Bilder
                return '(max-width: 319px) 280px, (max-width: 575px) 400px, (max-width: 767px) 500px, (max-width: 991px) 600px, (max-width: 1199px) 700px, (max-width: 1399px) 800px, 800px';
                
            case 'small':
            case 'content_small':
                // Small Bilder - Thumbnail-Größen
                return '(max-width: 319px) 160px, (max-width: 575px) 200px, (max-width: 767px) 250px, 250px';
                
            case 'hero':
                // Hero Bilder - Fullscreen-optimiert (startet bei 768px)
                return '(max-width: 767px) 768px, (max-width: 991px) 992px, (max-width: 1199px) 1200px, (max-width: 1399px) 1400px, 1920px';
                
            // ========== 1x1 RATIO TYPEN (Quadratisch) ==========
            
            case '1x1':
            case 'small_1x1':
                // Kleine quadratische Bilder (Icons, Avatare)
                return '(max-width: 319px) 120px, (max-width: 575px) 150px, (max-width: 767px) 180px, 180px';
                
            case 'half_1x1':
                // Mittlere quadratische Bilder
                return '(max-width: 319px) 280px, (max-width: 575px) 400px, (max-width: 767px) 500px, (max-width: 991px) 600px, (max-width: 1199px) 700px, 700px';
                
            case 'full_1x1':
                // Große quadratische Bilder (performance-begrenzt auf 1000px)
                return '(max-width: 319px) 320px, (max-width: 575px) 576px, (max-width: 767px) 768px, (max-width: 991px) 900px, (max-width: 1199px) 1000px, 1000px';
                
            case 'hero_1x1':
                // Hero quadratische Bilder (Fullscreen)
                return '(max-width: 767px) 768px, (max-width: 991px) 992px, (max-width: 1199px) 1200px, (max-width: 1399px) 1400px, 1920px';
                
            // ========== 4x3 RATIO TYPEN (Klassisches Foto-Verhältnis) ==========
            
            case '4x3':
            case 'small_4x3':
                // Kleine 4:3 Bilder
                return '(max-width: 319px) 160px, (max-width: 575px) 200px, (max-width: 767px) 240px, 240px';
                
            case 'half_4x3':
                // Mittlere 4:3 Bilder
                return '(max-width: 319px) 280px, (max-width: 575px) 400px, (max-width: 767px) 500px, (max-width: 991px) 600px, (max-width: 1199px) 700px, 700px';
                
            case 'full_4x3':
                // Große 4:3 Bilder (web-optimiert, max 1200px)
                return '(max-width: 319px) 320px, (max-width: 575px) 576px, (max-width: 767px) 768px, (max-width: 991px) 992px, (max-width: 1199px) 1200px, 1200px';
                
            case 'hero_4x3':
                // Hero 4:3 Bilder (Fullscreen Standard)
                return '(max-width: 767px) 768px, (max-width: 991px) 992px, (max-width: 1199px) 1200px, (max-width: 1399px) 1400px, 1920px';
                
            // ========== 16x9 RATIO TYPEN (Video-Format) ==========
            
            case 'hero_16x9':
                // Hero 16:9 Bilder (Fullscreen Video)
                return '(max-width: 767px) 768px, (max-width: 991px) 992px, (max-width: 1199px) 1200px, (max-width: 1399px) 1400px, 1920px';
                
            // ========== 21x9 RATIO TYPEN (Cinematic) ==========
            
            case 'hero_21x9':
                // Hero 21:9 Bilder (Ultra-wide)
                return '(max-width: 991px) 992px, (max-width: 1199px) 1200px, (max-width: 1399px) 1400px, 1920px';
                
            // ========== FALLBACK FÜR UNBEKANNTE TYPEN ==========
            default:
                // Intelligenter Fallback basierend auf Type-Namen
                if (strpos($baseType, 'hero') !== false) {
                    return '(max-width: 767px) 768px, (max-width: 991px) 992px, (max-width: 1199px) 1200px, (max-width: 1399px) 1400px, 1920px';
                } elseif (strpos($baseType, 'full') !== false) {
                    return '(max-width: 319px) 320px, (max-width: 575px) 576px, (max-width: 767px) 768px, (max-width: 991px) 992px, (max-width: 1199px) 1200px, 1400px';
                } elseif (strpos($baseType, 'half') !== false) {
                    return '(max-width: 319px) 280px, (max-width: 575px) 400px, (max-width: 767px) 500px, (max-width: 991px) 600px, (max-width: 1199px) 700px, 800px';
                } elseif (strpos($baseType, 'small') !== false) {
                    return '(max-width: 319px) 160px, (max-width: 575px) 200px, (max-width: 767px) 250px, 250px';
                }
                
                // Standard-Fallback für völlig unbekannte Typen
                return '(max-width: 575px) 100vw, (max-width: 991px) 50vw, 33vw';
        }
    }
}

/**
 * Generiert data-srcset für Lazy Loading Kompatibilität - Bootstrap 5 optimiert
 */
if (!function_exists('generateDataSrcset')) {
    function generateDataSrcset($mediaFile, $baseType = 'full') {
        return generateSrcset($mediaFile, $baseType);
    }
}

/**
 * Bootstrap 5 optimierte sizes-Attribute für verschiedene Container-Typen
 */
if (!function_exists('generateCustomSizes')) {
    function generateCustomSizes($containerType = 'container') {
        switch ($containerType) {
            case 'full':
            case 'container-fluid':
                return '100vw';
                
            case 'container':
                // Bootstrap 5 Container max-widths: 576px, 768px, 992px, 1200px, 1400px
                return '(max-width: 576px) 100vw, (max-width: 768px) 540px, (max-width: 992px) 720px, (max-width: 1200px) 960px, (max-width: 1400px) 1140px, 1320px';
                
            case 'col-12':
                return generateCustomSizes('container');
                
            case 'col-6':
                return '(max-width: 576px) 100vw, (max-width: 768px) 270px, (max-width: 992px) 360px, (max-width: 1200px) 480px, (max-width: 1400px) 570px, 660px';
                
            case 'col-4':
                return '(max-width: 576px) 100vw, (max-width: 768px) 180px, (max-width: 992px) 240px, (max-width: 1200px) 320px, (max-width: 1400px) 380px, 440px';
                
            case 'col-3':
                return '(max-width: 576px) 100vw, (max-width: 768px) 135px, (max-width: 992px) 180px, (max-width: 1200px) 240px, (max-width: 1400px) 285px, 330px';
                
            case 'col-8':
                return '(max-width: 576px) 100vw, (max-width: 768px) 360px, (max-width: 992px) 480px, (max-width: 1200px) 640px, (max-width: 1400px) 760px, 880px';
                
            case 'col-9':
                return '(max-width: 576px) 100vw, (max-width: 768px) 405px, (max-width: 992px) 540px, (max-width: 1200px) 720px, (max-width: 1400px) 855px, 990px';
                
            // Spezielle Container für große Bilder
            case 'hero':
                return '100vw';
                
            case 'card':
                return '(max-width: 576px) 100vw, (max-width: 768px) 320px, (max-width: 992px) 350px, (max-width: 1200px) 380px, 400px';
                
            default:
                return '100vw';
        }
    }
}

/**
 * Erweiterte intelligente Media Manager Typ-Auswahl basierend auf dem SQL-Schema
 * Optimiert für alle definierten Breakpoints und Ratio-Varianten
 */
if (!function_exists('getOptimalMediaType')) {
    function getOptimalMediaType($containerType = 'container', $imageSize = 'full', $aspectRatio = null) {
        // ========== ASPECT RATIO HANDLING ==========
        // Bestimme den Base-Type basierend auf gewünschter Größe und Aspect Ratio
        $baseType = '';
        
        if ($aspectRatio === '1x1') {
            // Quadratische Bilder - alle Serien verfügbar
            switch ($imageSize) {
                case 'small':
                    $baseType = 'small_1x1'; // Breakpoints: 320, 576, 768
                    break;
                case 'half':
                    $baseType = 'half_1x1';  // Breakpoints: 320, 576, 768, 992, 1200
                    break;
                case 'full':
                default:
                    $baseType = 'full_1x1';  // Breakpoints: 320, 576, 768, 992, 1200 (performance-begrenzt)
                    break;
            }
        } elseif ($aspectRatio === '4x3') {
            // 4:3 Verhältnis - klassische Fotos
            switch ($imageSize) {
                case 'small':
                    $baseType = 'small_4x3'; // Breakpoints: 320, 576, 768
                    break;
                case 'half':
                    $baseType = 'half_4x3';  // Breakpoints: 320, 576, 768, 992, 1200
                    break;
                case 'full':
                default:
                    $baseType = 'full_4x3';  // Breakpoints: 320, 576, 768, 992, 1200 (web-optimiert)
                    break;
            }
        } else {
            // Standard responsive ohne festes Verhältnis
            switch ($imageSize) {
                case 'small':
                    $baseType = 'small';     // Breakpoints: 320, 576, 768
                    break;
                case 'half':
                    $baseType = 'half';      // Breakpoints: 320, 576, 768, 992, 1200, 1400
                    break;
                case 'full':
                default:
                    $baseType = 'full';      // Breakpoints: 320, 576, 768, 992, 1200, 1400
                    break;
            }
        }
        
        // ========== CONTAINER-SPEZIFISCHE OPTIMIERUNGEN ==========
        // Intelligente Anpassung basierend auf Container-Größe
        switch ($containerType) {
            // Kleine Container - optimal mit small-Serie
            case 'col-2':
            case 'col-3':
            case 'col-4':
                if ($imageSize === 'full') {
                    $baseType = str_replace(['full_', 'full'], ['small_', 'small'], $baseType);
                } elseif ($imageSize === 'half') {
                    $baseType = str_replace(['half_', 'half'], ['small_', 'small'], $baseType);
                }
                break;
                
            // Mittlere Container - optimal mit half-Serie
            case 'col-5':
            case 'col-6':
            case 'col-7':
            case 'card':
            case 'modal':
                if ($imageSize === 'full') {
                    $baseType = str_replace(['full_', 'full'], ['half_', 'half'], $baseType);
                }
                break;
                
            // Große Container - full-Serie beibehalten
            case 'col-8':
            case 'col-9':
            case 'col-10':
            case 'col-11':
            case 'col-12':
            case 'container':
            case 'container-fluid':
            case 'hero':
                // Full-Serie optimal - keine Änderung
                break;
                
            // Spezielle Layout-Bereiche
            case 'sidebar':
                if ($imageSize === 'full') {
                    $baseType = str_replace(['full_', 'full'], ['half_', 'half'], $baseType);
                }
                break;
                
            case 'thumbnail':
            case 'gallery-thumb':
                // Immer kleine Bilder für Thumbnails
                $baseType = str_replace(['full_', 'half_', 'full', 'half'], ['small_', 'small_', 'small', 'small'], $baseType);
                break;
        }
        
        // ========== FALLBACK FÜR LEGACY TYPEN ==========
        // Mapping für alte Bezeichnungen
        $legacyMapping = [
            'content_full' => 'full',
            'content_half' => 'half', 
            'content_small' => 'small',
        ];
        
        if (isset($legacyMapping[$baseType])) {
            $baseType = $legacyMapping[$baseType];
        }
        
        return $baseType;
    }
}

/**
 * Convenience-Funktion: Generiert komplettes responsive Image-Array für Templates
 */
if (!function_exists('getResponsiveImageData')) {
    function getResponsiveImageData($mediaFile, $baseType = 'full', $containerType = 'container', $aspectRatio = null) {
        if (!$mediaFile) {
            return null;
        }
        
        // Optimalen Media Type basierend auf Container bestimmen
        $optimalType = getOptimalMediaType($containerType, $baseType, $aspectRatio);
        
        // Media Objekt laden
        if (is_string($mediaFile)) {
            $media = rex_media::get($mediaFile);
            $fileName = $mediaFile;
        } elseif ($mediaFile instanceof rex_media) {
            $media = $mediaFile;
            $fileName = $media->getFileName();
        } else {
            return null;
        }
        
        return [
            'src' => rex_media_manager::getUrl($optimalType . '_576', $fileName), // Fallback für ältere Browser
            'srcset' => generateSrcset($fileName, $optimalType),
            'sizes' => generateCustomSizes($containerType),
            'alt' => $media ? $media->getValue('med_description') ?: $media->getTitle() ?: '' : '',
            'title' => $media ? $media->getTitle() : '',
            'width' => $media ? $media->getWidth() : null,
            'height' => $media ? $media->getHeight() : null,
            'mediaType' => $optimalType,
            'containerType' => $containerType
        ];
    }
}

/**
 * Erweiterte Hilfsfunktion: Validiert verfügbare Media Manager Types für SQL-Schema
 * Prüft systematisch alle definierten responsive Varianten
 */
if (!function_exists('validateResponsiveMediaTypes')) {
    function validateResponsiveMediaTypes($baseType = null) {
        $results = [
            'available' => [],
            'missing' => [],
            'baseType' => $baseType
        ];
        
        // Alle definierten Serien aus SQL-Schema
        $mediaSeries = [
            // Standard responsive (ohne Ratio)
            'small' => [320, 576, 768],
            'half' => [320, 576, 768, 992, 1200, 1400],
            'full' => [320, 576, 768, 992, 1200, 1400],
            
            // 1x1 Ratio Varianten
            'small_1x1' => [320, 576, 768],
            'half_1x1' => [320, 576, 768, 992, 1200],
            'full_1x1' => [320, 576, 768, 992, 1200],
            
            // 4x3 Ratio Varianten
            'small_4x3' => [320, 576, 768],
            'half_4x3' => [320, 576, 768, 992, 1200],
            'full_4x3' => [320, 576, 768, 992, 1200],
        ];
        
        // Wenn spezifischer baseType angegeben, nur diesen prüfen
        if ($baseType && isset($mediaSeries[$baseType])) {
            $mediaSeries = [$baseType => $mediaSeries[$baseType]];
        }
        
        foreach ($mediaSeries as $seriesName => $breakpoints) {
            foreach ($breakpoints as $breakpoint) {
                $typeName = $seriesName . '_' . $breakpoint;
                
                // Prüfe ob Media Manager Type existiert - mit optimiertem Cache
                if (mediaManagerTypeExists($typeName)) {
                    $results['available'][] = $typeName;
                } else {
                    $results['missing'][] = $typeName;
                }
            }
        }
        
        return $results;
    }
}

/**
 * Debug-Hilfsfunktion für Figure-Komponente - erweitert für neue Media Manager Typen
 */
if (!function_exists('debugFigureConfig')) {
    function debugFigureConfig($media, $url, $config, $sections) {
        if (rex::isBackend() || rex_request('figure_debug', 'bool', false)) {
            echo "<div style='background: #f8f9fa; border: 1px solid #dee2e6; padding: 10px; margin: 10px 0; font-family: monospace; font-size: 12px;'>";
            echo "<strong>Figure Debug (Bootstrap 5 Media Types):</strong><br>";
            echo "Media: " . ($media instanceof rex_media ? $media->getFileName() . ' (ID: ' . $media->getId() . ')' : 'NULL') . "<br>";
            echo "URL: " . ($url ?: 'NULL') . "<br>";
            echo "MediaManagerType: " . ($config['media']['mediaManagerType'] ?? 'NULL') . "<br>";
            echo "LazyLoading: " . ($config['media']['lazyLoading'] ?? false ? 'YES' : 'NO') . "<br>";
            echo "AutoResponsive: " . ($config['media']['autoResponsive'] ?? false ? 'YES' : 'NO') . "<br>";
            
            // Teste verfügbare responsive Varianten
            if (!empty($config['media']['mediaManagerType'])) {
                $baseType = $config['media']['mediaManagerType'];
                $availableTypes = [];
                $breakpoints = [320, 576, 768, 992, 1200, 1400];
                
                foreach ($breakpoints as $bp) {
                    $responsiveType = $baseType . '_' . $bp;
                    
                    // Prüfe ob responsive Typ existiert - mit optimiertem Cache
                    if (mediaManagerTypeExists($responsiveType)) {
                        $availableTypes[] = $responsiveType;
                    }
                }
                
                echo "Verfügbare responsive Typen: " . implode(', ', $availableTypes) . "<br>";
                
                // Generiere Srcset zum Testen
                if ($media instanceof rex_media) {
                    $srcset = generateSrcset($media->getFileName(), $baseType);
                    echo "Generiertes Srcset: " . htmlspecialchars($srcset) . "<br>";
                    
                    $sizes = generateSizesForType($baseType);
                    echo "Generierte Sizes: " . htmlspecialchars($sizes) . "<br>";
                }
            }
            
            echo "Sections: " . htmlspecialchars(json_encode($sections)) . "<br>";
            echo "Config: " . htmlspecialchars(json_encode($config)) . "<br>";
            echo "</div>";
        }
    }
}

/**
 * Debug-Funktion: Zeigt alle verfügbaren responsive Media Types aus SQL-Schema
 * Hilfreich bei der Entwicklung und für Backend-Admins
 */
if (!function_exists('debugResponsiveMediaTypes')) {
    function debugResponsiveMediaTypes() {
        if (!rex::isBackend()) {
            return;
        }
        
        $validation = validateResponsiveMediaTypes();
        
        echo "<div style='background: #f8f9fa; border: 1px solid #dee2e6; padding: 15px; margin: 15px 0; font-family: monospace; font-size: 12px;'>";
        echo "<h4>Responsive Media Types Status (SQL-Schema)</h4>";
        
        echo "<strong style='color: green;'>Verfügbare Types (" . count($validation['available']) . "):</strong><br>";
        if (!empty($validation['available'])) {
            echo implode(', ', $validation['available']) . "<br><br>";
        }
        
        echo "<strong style='color: red;'>Fehlende Types (" . count($validation['missing']) . "):</strong><br>";
        if (!empty($validation['missing'])) {
            echo implode(', ', $validation['missing']) . "<br><br>";
            echo "<em>Führen Sie das SQL-Schema aus: responsive_complete_system.sql</em><br>";
        } else {
            echo "<em>Alle Media Types sind verfügbar! ✓</em><br>";
        }
        
        echo "</div>";
    }
}

// === LEGACY COMPATIBILITY FUNCTIONS ===

/**
 * Legacy Funktionen für Rückwärtskompatibilität
 * Diese Funktionen verwenden die neuen internen Funktionen
 */

function generateResponsiveSrcset($filename, $baseType = 'full') {
    return generateSrcset($filename, $baseType);
}

function generateResponsiveSizes($baseType = 'full') {
    return generateSizesForType($baseType);
}

function mediaTypeExists($typeName) {
    return mediaManagerTypeExists($typeName);
}

// === MEDIA TYPES CONFIGURATION ARRAYS ===

/**
 * Vollständige Media Types Konfiguration basierend auf dem SQL-Schema
 * Diese Arrays dienen als Referenz und für dynamische Type-Generierung
 */
$mediaTypesArray = [
    // ========== STANDARD RESPONSIVE VARIANTEN (ohne Ratio) ==========
    
    // Small Serie - Thumbnails und kleine Bilder
    'small_320' => ['width' => 160, 'height' => null],   // Small für Mobile Portrait
    'small_576' => ['width' => 200, 'height' => null],   // Small für Mobile Landscape  
    'small_768' => ['width' => 250, 'height' => null],   // Small für Tablet Portrait
    
    // Half Serie - Mittlere Bilder mit Container-optimierten Breiten
    'half_320' => ['width' => 280, 'height' => null],    // Half für Mobile Portrait
    'half_576' => ['width' => 400, 'height' => null],    // Half für Mobile Landscape
    'half_768' => ['width' => 500, 'height' => null],    // Half für Tablet Portrait
    'half_992' => ['width' => 600, 'height' => null],    // Half für Desktop Small
    'half_1200' => ['width' => 700, 'height' => null],   // Half für Desktop Standard
    'half_1400' => ['width' => 800, 'height' => null],   // Half für Large Desktop
    
    // Full Serie - Große Bilder entsprechend Bootstrap Container-Breiten
    'full_320' => ['width' => 320, 'height' => null],    // Full für Mobile Portrait
    'full_576' => ['width' => 576, 'height' => null],    // Full für Mobile Landscape
    'full_768' => ['width' => 768, 'height' => null],    // Full für Tablet Portrait
    'full_992' => ['width' => 992, 'height' => null],    // Full für Desktop Small
    'full_1200' => ['width' => 1200, 'height' => null],  // Full für Desktop Standard
    'full_1400' => ['width' => 1400, 'height' => null],  // Full für Large Desktop
    
    // ========== 1x1 RATIO VARIANTEN (Quadratisch) ==========
    
    // Small 1x1 Serie - Kleine quadratische Bilder (Icons, Avatare)
    'small_1x1_320' => ['width' => 120, 'height' => 120],   // 120x120 für Mobile
    'small_1x1_576' => ['width' => 150, 'height' => 150],   // 150x150 für Mobile L
    'small_1x1_768' => ['width' => 180, 'height' => 180],   // 180x180 für Tablet
    
    // Half 1x1 Serie - Mittlere quadratische Bilder
    'half_1x1_320' => ['width' => 280, 'height' => 280],    // 280x280 für Mobile
    'half_1x1_576' => ['width' => 400, 'height' => 400],    // 400x400 für Mobile L
    'half_1x1_768' => ['width' => 500, 'height' => 500],    // 500x500 für Tablet
    'half_1x1_992' => ['width' => 600, 'height' => 600],    // 600x600 für Desktop S
    'half_1x1_1200' => ['width' => 700, 'height' => 700],   // 700x700 für Desktop
    
    // Full 1x1 Serie - Große quadratische Bilder (performance-begrenzt)
    'full_1x1_320' => ['width' => 320, 'height' => 320],    // 320x320 für Mobile
    'full_1x1_576' => ['width' => 576, 'height' => 576],    // 576x576 für Mobile L
    'full_1x1_768' => ['width' => 768, 'height' => 768],    // 768x768 für Tablet
    'full_1x1_992' => ['width' => 900, 'height' => 900],    // 900x900 für Desktop S (begrenzt)
    'full_1x1_1200' => ['width' => 1000, 'height' => 1000], // 1000x1000 für Desktop (begrenzt)
    
    // ========== 4x3 RATIO VARIANTEN (Klassisches Foto-Verhältnis) ==========
    
    // Small 4x3 Serie - Kleine 4:3 Bilder
    'small_4x3_320' => ['width' => 160, 'height' => 120],   // 160x120 für Mobile
    'small_4x3_576' => ['width' => 200, 'height' => 150],   // 200x150 für Mobile L
    'small_4x3_768' => ['width' => 240, 'height' => 180],   // 240x180 für Tablet
    
    // Half 4x3 Serie - Mittlere 4:3 Bilder
    'half_4x3_320' => ['width' => 280, 'height' => 210],    // 280x210 für Mobile
    'half_4x3_576' => ['width' => 400, 'height' => 300],    // 400x300 für Mobile L
    'half_4x3_768' => ['width' => 500, 'height' => 375],    // 500x375 für Tablet
    'half_4x3_992' => ['width' => 600, 'height' => 450],    // 600x450 für Desktop S
    'half_4x3_1200' => ['width' => 700, 'height' => 525],   // 700x525 für Desktop
    
    // Full 4x3 Serie - Große 4:3 Bilder (web-optimiert, max 1200px)
    'full_4x3_320' => ['width' => 320, 'height' => 240],    // 320x240 für Mobile
    'full_4x3_576' => ['width' => 576, 'height' => 432],    // 576x432 für Mobile L
    'full_4x3_768' => ['width' => 768, 'height' => 576],    // 768x576 für Tablet
    'full_4x3_992' => ['width' => 992, 'height' => 744],    // 992x744 für Desktop S
    'full_4x3_1200' => ['width' => 1200, 'height' => 900],  // 1200x900 für Desktop
];

/**
 * Bootstrap 5 responsive Konfigurationen
 */
$responsiveConfigurations = [
    'breakpoints' => [
        'xs' => 0,     // Extra small devices
        'sm' => 576,   // Small devices  
        'md' => 768,   // Medium devices
        'lg' => 992,   // Large devices
        'xl' => 1200,  // Extra large devices
        'xxl' => 1400  // Extra extra large devices
    ],
    'containers' => [
        'sm' => 540,   // Small container max-width
        'md' => 720,   // Medium container max-width
        'lg' => 960,   // Large container max-width
        'xl' => 1140,  // Extra large container max-width
        'xxl' => 1320  // Extra extra large container max-width
    ]
];

/**
 * Aspect ratios für responsive Design
 */
$aspectRatios = [
    '1x1' => 1,      // Square
    '4x3' => 1.333,  // Traditional photo
    '3x2' => 1.5,    // Classic photo
    '16x9' => 1.778, // Widescreen
    '21x9' => 2.333, // Ultra-wide
    '2x1' => 2,      // Banner
    '5x4' => 1.25    // Portrait-medium
];
