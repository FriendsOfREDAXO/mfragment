<?php

namespace FriendsOfRedaxo\MFragment\Components\Default;

use rex_factory_trait;
use rex_media;
use rex_url;
use rex_media_manager;
use FriendsOfRedaxo\MFragment\Components\AbstractComponent;

/**
 * Erweiterte Figure-Komponente mit vollständiger Config-Unterstützung
 * Vollständig fragment-frei mit direkter HTML-Erzeugung
 * 
 * Responsive Images-Unterstützung:
 * - Nutzt standardmäßig project/boot.php Funktionen (generateSrcset, generateSizesForType)
 * - Hat eingebaute Fallback-Funktionalität ohne project/boot.php Abhängigkeit
 * - Kann mit forceBuiltinResponsive() komplett ohne externe Abhängigkeiten betrieben werden
 * 
 * Verwendung:
 * $figure = Figure::factory()
 *   ->setMedia('image.jpg')
 *   ->setMediaManagerType('half')
 *   ->enableAutoResponsive()          // Nutzt project/boot.php oder Fallback
 *   ->forceBuiltinResponsive(true);   // Optional: Nur eingebaute Funktionalität
 */
class Figure extends AbstractComponent
{
    use rex_factory_trait;

    /**
     * Inhalt-Sektionen
     */
    private array $sections = [
        'media' => null,
        'alt' => '',
        'caption' => null,
        'url' => null
    ];

    /**
     * Komplette Konfiguration der Komponente
     */
    private array $config = [
        'figure' => [],
        'media' => ['mediaManagerType' => 'default'],
        'caption' => [],
        'lightbox' => false,
        'link' => null,
        'style' => '',
        'imgWrapper' => null, // Wichtig: imgWrapper Config hinzugefügt
        'accessibility' => [
            'enableNoScriptFallback' => true,
            'role' => null, // null = automatisch, 'img', 'presentation', etc.
            'ariaLabel' => null,
            'ariaDescribedBy' => null,
            'ariaLabelledBy' => null,
            'focusable' => null // null = automatisch, true/false
        ]
    ];

    /**
     * Konstruktor
     */
    public function __construct()
    {
        // Direkte HTML-Erzeugung ohne Fragment-System
    }

    /**
     * Setzt das Media-Objekt
     * 
     * @param rex_media|string $media Ein rex_media Objekt, ein Dateiname oder eine URL
     * @return $this
     */
    public function setMedia(rex_media|string $media): self
    {
        // Wenn es sich um eine URL/externe Quelle handelt (mit http oder / beginnend)
        if (is_string($media) && (str_starts_with($media, 'http') || str_starts_with($media, '/'))) {
            $this->sections['url'] = $media;
            $this->sections['media'] = null;
        } else {
            // Ansonsten als rex_media behandeln
            if (!$media instanceof rex_media) {
                $media = rex_media::get($media);
            }
            
            // Prüfe ob Media-Objekt erfolgreich geladen wurde
            if ($media instanceof rex_media) {
                $this->sections['media'] = $media;
                $this->sections['url'] = null;
            } else {
                // Fallback: Wenn rex_media::get() fehlschlägt, als direkten Dateinamen behandeln
                $this->sections['url'] = '/media/' . $media;
                $this->sections['media'] = null;
            }
        }
        return $this;
    }

    /**
     * Setzt eine direkte Bild-URL
     *
     * @param string $url Die URL zum Bild
     * @return $this
     */
    public function setImageUrl(string $url): self
    {
        $this->sections['url'] = $url;
        $this->sections['media'] = null;
        return $this;
    }

    /**
     * Setzt den Alt-Text
     */
    public function setAlt(string $alt): self
    {
        $this->sections['alt'] = $alt;
        return $this;
    }

    /**
     * Setzt die Caption
     */
    public function setCaption(?array $caption): self
    {
        $this->sections['caption'] = $caption;
        return $this;
    }

    /**
     * Setzt den Media Manager Typ
     */
    public function setMediaManagerType(string $type): self
    {
        // Prüfe ob es eine SVG-Datei ist und überspringe Media Manager für SVGs
        if ($this->sections['media'] instanceof rex_media) {
            $isSvg = strtolower(pathinfo($this->sections['media']->getFileName(), PATHINFO_EXTENSION)) === 'svg';
            if ($isSvg) {
                // Für SVG-Dateien setzen wir keinen Media Manager Type
                return $this;
            }
        }
        
        $this->config['media']['mediaManagerType'] = $type;
        
        // Aktiviere automatisch Responsive Images für alle Media Manager Types (außer SVG)
        if ($this->sections['media'] instanceof rex_media) {
            $isSvg = strtolower(pathinfo($this->sections['media']->getFileName(), PATHINFO_EXTENSION)) === 'svg';
            if (!$isSvg) {
                $this->config['media']['autoResponsive'] = true;
                $this->config['media']['responsiveBaseType'] = $type;
                
                // Setze automatische Dimensionen für spezielle Ratio-Types
                $this->setAutoDimensionsForType($type);
            }
        } else {
            // Wenn noch kein Media gesetzt, aktiviere trotzdem Auto-Responsive
            $this->config['media']['autoResponsive'] = true;
            $this->config['media']['responsiveBaseType'] = $type;
            
            // Setze automatische Dimensionen für spezielle Ratio-Types  
            $this->setAutoDimensionsForType($type);
        }
        
        return $this;
    }
    
    /**
     * Setzt automatische Dimensionen basierend auf Media Manager Type - Bootstrap 5 optimiert
     */
    private function setAutoDimensionsForType(string $type): void
    {
        // Bootstrap 5 Media Manager Types mit flexiblen Dimensionen
        $dimensionMap = [
            // Standard responsive Typen (ohne Ratio) - Flexibles Verhältnis
            'small' => ['width' => 250, 'height' => null],         // Flexibles Verhältnis für kleine Bilder
            'half' => ['width' => 800, 'height' => null],          // Flexibles Verhältnis für mittlere Bilder
            'full' => ['width' => 1400, 'height' => null],         // Flexibles Verhältnis für große Bilder
            
            // 1x1 Ratio Typen (Quadratisch)
            'small_1x1' => ['width' => 180, 'height' => 180],      // Kleine Quadrate
            'half_1x1' => ['width' => 700, 'height' => 700],       // Mittlere Quadrate
            'full_1x1' => ['width' => 1000, 'height' => 1000],     // Große Quadrate
            '1x1' => ['width' => 700, 'height' => 700],            // Standard Quadrat
            
            // 4x3 Ratio Typen (Klassisch)
            'small_4x3' => ['width' => 240, 'height' => 180],      // Kleine 4:3
            'half_4x3' => ['width' => 700, 'height' => 525],       // Mittlere 4:3
            'full_4x3' => ['width' => 1200, 'height' => 900],      // Große 4:3
            '4x3' => ['width' => 700, 'height' => 525],            // Standard 4:3
            
            // Legacy Typen (Rückwärtskompatibilität) - Flexibles Verhältnis
            'content_full' => ['width' => 1400, 'height' => null], // Flexibles Verhältnis für Full-Width
            'content_half' => ['width' => 800, 'height' => null],  // Flexibles Verhältnis für Half-Width
            'content_small' => ['width' => 250, 'height' => null], // Flexibles Verhältnis für kleine Bilder
            
            // Weitere Ratio-Typen für spezielle Anwendungen
            '16x9' => ['width' => 1920, 'height' => 1080],         // 16:9 Widescreen
            '21x9' => ['width' => 1920, 'height' => 823],          // 21:9 Ultrawide
            '3x2' => ['width' => 900, 'height' => 600],            // 3:2 Foto-Standard
            '5x4' => ['width' => 900, 'height' => 720],            // 5:4 Klassisch
        ];
        
        if (isset($dimensionMap[$type])) {
            $dims = $dimensionMap[$type];
            $this->config['media']['width'] = $dims['width'];
            $this->config['media']['height'] = $dims['height'];
            $this->config['media']['autoDimensions'] = true;
        }
    }

    /**
     * Aktiviert automatische Responsive Images basierend auf Media Manager Typ
     */
    public function enableAutoResponsive(bool $enabled = true): self
    {
        $this->config['media']['autoResponsive'] = $enabled;
        return $this;
    }

    /**
     * Forciert die Nutzung der eingebauten responsive Images-Funktionalität
     * Ignoriert project/boot.php Funktionen komplett (für Portable Setups)
     */
    public function forceBuiltinResponsive(bool $enabled = true): self
    {
        $this->config['media']['forceBuiltinResponsive'] = $enabled;
        return $this;
    }

    /**
     * Setzt eine projektspezifische responsive Images-Konfiguration
     * Überschreibt die Standard-Konfiguration für diese Figure-Instanz
     */
    public function setResponsiveConfig(array $config): self
    {
        $this->config['media']['customResponsiveConfig'] = $config;
        return $this;
    }

    /**
     * Aktiviert Responsive Images mit Custom-Konfiguration
     */
    public function enableResponsiveImages(array $sizes = [320, 480, 768, 1024, 1400, 1920], string $sizesAttribute = 'container'): self
    {
        $this->config['media']['responsiveImages'] = [
            'enabled' => true,
            'sizes' => $sizes,
            'sizesAttribute' => $sizesAttribute
        ];
        return $this;
    }

    /**
     * Setzt spezifische Container-Größe für sizes-Attribut
     */
    public function setContainerSize(string $containerType): self
    {
        if (!isset($this->config['media']['responsiveImages'])) {
            $this->config['media']['responsiveImages'] = ['enabled' => true, 'sizes' => [320, 480, 768, 1024, 1400, 1920]];
        }
        $this->config['media']['responsiveImages']['sizesAttribute'] = $containerType;
        return $this;
    }

    /**
     * Setzt Custom Sizes Attribut
     */
    public function setCustomSizes(string $sizes): self
    {
        if (!isset($this->config['media']['responsiveImages'])) {
            $this->config['media']['responsiveImages'] = ['enabled' => true, 'sizes' => [320, 480, 768, 1024, 1400, 1920]];
        }
        $this->config['media']['responsiveImages']['customSizes'] = $sizes;
        return $this;
    }

    /**
     * Ermittelt die Standard-Dimensionen basierend auf Media Manager Type - Bootstrap 5 optimiert
     */
    private function getDefaultDimensionsForType(string $type): array
    {
        // Bootstrap 5 Standard-Dimensionen für verschiedene Media Manager Types
        $dimensionsMap = [
            // Standard responsive Typen (ohne Ratio) - Flexibles Verhältnis
            'small' => ['width' => 250, 'height' => null],         // Flexibles Verhältnis für kleine Bilder
            'half' => ['width' => 800, 'height' => null],          // Flexibles Verhältnis für mittlere Bilder
            'full' => ['width' => 1400, 'height' => null],         // Flexibles Verhältnis für große Bilder
            
            // 1x1 Ratio Typen (Quadratisch)
            'small_1x1' => ['width' => 180, 'height' => 180],      // Kleine Quadrate
            'half_1x1' => ['width' => 700, 'height' => 700],       // Mittlere Quadrate
            'full_1x1' => ['width' => 1000, 'height' => 1000],     // Große Quadrate
            '1x1' => ['width' => 700, 'height' => 700],            // Standard Quadrat
            
            // 4x3 Ratio Typen (Klassisch)
            'small_4x3' => ['width' => 240, 'height' => 180],      // Kleine 4:3
            'half_4x3' => ['width' => 700, 'height' => 525],       // Mittlere 4:3
            'full_4x3' => ['width' => 1200, 'height' => 900],      // Große 4:3
            '4x3' => ['width' => 700, 'height' => 525],            // Standard 4:3
            
            // Legacy Typen (Rückwärtskompatibilität) - Flexibles Verhältnis
            'content_full' => ['width' => 1400, 'height' => null], // Flexibles Verhältnis für Full-Width
            'content_half' => ['width' => 800, 'height' => null],  // Flexibles Verhältnis für Half-Width
            'content_small' => ['width' => 250, 'height' => null], // Flexibles Verhältnis für kleine Bilder
            
            // Weitere Ratio-Typen
            '16x9' => ['width' => 1920, 'height' => 1080],         // 16:9 Widescreen
            '21x9' => ['width' => 1920, 'height' => 823],          // 21:9 Ultrawide
            '3x2' => ['width' => 900, 'height' => 600],            // 3:2 Foto-Standard
            '5x4' => ['width' => 900, 'height' => 720],            // 5:4 Klassisch
        ];

        return $dimensionsMap[$type] ?? ['width' => 800, 'height' => null]; // Standard flexibles Verhältnis
    }

    /**
     * Setzt width und height Attribute für das img-Tag basierend auf Media Manager Type
     */
    public function setImageDimensions(int $width, int $height): self
    {
        $this->config['media']['width'] = $width;
        $this->config['media']['height'] = $height;
        return $this;
    }

    /**
     * Automatische Dimensionen basierend auf Media Manager Type
     */
    public function enableAutoDimensions(bool $enabled = true): self
    {
        $this->config['media']['autoDimensions'] = $enabled;
        return $this;
    }

    /**
     * Aktiviert/deaktiviert NoScript-Fallback für Lazy Loading
     */
    public function enableNoScriptFallback(bool $enabled = true): self
    {
        $this->config['accessibility']['enableNoScriptFallback'] = $enabled;
        return $this;
    }

    /**
     * Setzt ARIA-Attribute für Barrierefreiheit
     */
    public function setAriaLabel(string $label): self
    {
        $this->config['accessibility']['ariaLabel'] = $label;
        return $this;
    }

    /**
     * Setzt aria-describedby für Barrierefreiheit
     */
    public function setAriaDescribedBy(string $id): self
    {
        $this->config['accessibility']['ariaDescribedBy'] = $id;
        return $this;
    }

    /**
     * Setzt aria-labelledby für Barrierefreiheit
     */
    public function setAriaLabelledBy(string $id): self
    {
        $this->config['accessibility']['ariaLabelledBy'] = $id;
        return $this;
    }

    /**
     * Setzt die Rolle für Screenreader
     */
    public function setRole(string $role): self
    {
        $this->config['accessibility']['role'] = $role;
        return $this;
    }

    /**
     * Macht das Element fokussierbar oder nicht-fokussierbar
     */
    public function setFocusable(bool $focusable): self
    {
        $this->config['accessibility']['focusable'] = $focusable;
        return $this;
    }

    /**
     * Aktiviert/deaktiviert Lazy Loading
     */
    public function enableLazyLoading(bool $enabled = true): self
    {
        $this->config['media']['lazyLoading'] = $enabled;
        return $this;
    }

    /**
     * Alias für enableLazyLoading() für Kompatibilität
     */
    public function setLazyLoading(bool $enabled = true): self
    {
        return $this->enableLazyLoading($enabled);
    }

    /**
     * Aktiviert/deaktiviert Lightbox
     */
    public function enableLightbox(bool $enabled = true, ?string $lightboxClass = null, ?string $galleryId = null): self
    {
        $this->config['lightbox'] = $enabled;

        if ($lightboxClass) {
            $this->config['lightboxClass'] = $lightboxClass;
        }

        if ($galleryId) {
            $this->config['lightboxGallery'] = $galleryId;
        }

        return $this;
    }

    /**
     * Setzt einen Link
     */
    public function setLink($link): self
    {
        $this->config['link'] = $link;
        return $this;
    }

    /**
     * Setzt Link-Attribute (z.B. target, rel)
     */
    public function setLinkAttributes(array $attributes): self
    {
        $this->config['linkAttributes'] = $attributes;
        return $this;
    }

    /**
     * Setzt spezifische Config-Werte
     *
     * @param string $key Config-Schlüssel (z.B. 'imgWrapper', 'media', 'figure')
     * @param mixed $value Config-Wert
     * @return $this
     */
    public function setConfig(string $key, $value): self
    {
        $this->config[$key] = $value;
        return $this;
    }

    /**
     * Gibt den gesamten Config-Array zurück
     */
    public function getConfig(): array
    {
        return $this->config;
    }

    /**
     * Setzt Media-Attribute (inklusive class)
     */
    public function setMediaAttribute(string $name, $value): self
    {
        if (!isset($this->config['media'])) {
            $this->config['media'] = [];
        }
        if (!isset($this->config['media']['attributes'])) {
            $this->config['media']['attributes'] = [];
        }
        $this->config['media']['attributes'][$name] = $value;
        return $this;
    }

    /**
     * Fügt eine Media-Klasse hinzu
     */
    public function addMediaClass(string $class): self
    {
        if (!isset($this->config['media']['attributes']['class'])) {
            $this->config['media']['attributes']['class'] = [];
        }

        $existingClasses = $this->config['media']['attributes']['class'];
        if (is_string($existingClasses)) {
            $existingClasses = explode(' ', $existingClasses);
        }

        $existingClasses[] = $class;
        $this->config['media']['attributes']['class'] = implode(' ', array_unique($existingClasses));

        return $this;
    }

    /**
     * Setzt Figure-Klassen (überschreibt bestehende)
     */
    public function setFigureClass(string $classes): self
    {
        if (!isset($this->config['figure']['attributes'])) {
            $this->config['figure']['attributes'] = [];
        }
        $this->config['figure']['attributes']['class'] = explode(' ', $classes);
        return $this;
    }

    /**
     * Fügt eine Figure-Klasse hinzu
     */
    public function addFigureClass(string $class): self
    {
        if (!isset($this->config['figure']['attributes'])) {
            $this->config['figure']['attributes'] = [];
        }
        if (!isset($this->config['figure']['attributes']['class'])) {
            $this->config['figure']['attributes']['class'] = [];
        }

        $classes = $this->config['figure']['attributes']['class'];
        if (is_string($classes)) {
            $classes = explode(' ', $classes);
        }

        $classes[] = $class;
        $this->config['figure']['attributes']['class'] = $classes;

        return $this;
    }

    /**
     * Setzt Caption-Attribute
     */
    public function setCaptionAttribute(string $name, $value): self
    {
        if (!isset($this->config['caption']['attributes'])) {
            $this->config['caption']['attributes'] = [];
        }
        $this->config['caption']['attributes'][$name] = $value;
        return $this;
    }

    /**
     * Fügt eine Caption-Klasse hinzu
     */
    public function addCaptionClass(string $class): self
    {
        if (!isset($this->config['caption']['attributes'])) {
            $this->config['caption']['attributes'] = [];
        }
        if (!isset($this->config['caption']['attributes']['class'])) {
            $this->config['caption']['attributes']['class'] = [];
        }

        $classes = $this->config['caption']['attributes']['class'];
        if (is_string($classes)) {
            $classes = explode(' ', $classes);
        }

        $classes[] = $class;
        $this->config['caption']['attributes']['class'] = $classes;

        return $this;
    }

    /**
     * Konfiguriert als Cover-Bild (vollständig kompatibel mit bestehendem BG-System)
     */
    public function setCover(bool $stretch = false): self
    {
        $this->addFigureClass('img-cover');
        $this->addFigureClass('bg-cover');
        $this->addFigureClass('mb-0');

        if ($stretch) {
            $this->addFigureClass('h-100');
        }

        // Media-Klassen für BG-Cover (kompatibel mit bestehendem JS/CSS)
        $this->addMediaClass('img-fluid');
        $this->addMediaClass('invisible');
        $this->addMediaClass('opacity-0');
        $this->addMediaClass('w-100');

        if ($stretch) {
            $this->addMediaClass('h-100');
        }

        // Aktiviere Lazy Loading standardmäßig für BG-Cover
        $this->enableLazyLoading(true);

        return $this;
    }

    /**
     * Setzt image ratio (z.B. 4x3, 16x9, 21x9, 1x1, 5x2, etc.)
     * Flexibel für alle aktuellen und zukünftigen Ratio-Formate
     */
    public function setRatio(string $ratio = '16x9'): self
    {
        $this->addFigureClass('ratio');
        $this->addFigureClass('ratio-' . $ratio);
        return $this;
    }

    /**
     * Convenience-Methode: Optimiert automatisch für Container-Typ mit flexiblem Ratio
     * Intelligent media type selection based on Bootstrap container context
     * 
     * @param string $containerType Bootstrap container type (col-4, col-8, hero, etc.)
     * @param string|null $aspectRatio Optional aspect ratio (1x1, 4x3, 16x9, 21x9, 5x2, etc.)
     * @return $this
     */
    public function optimizeForContainer(string $containerType = 'container', ?string $aspectRatio = null): self
    {
        // Intelligente Media Type Auswahl basierend auf Container
        $optimalType = $this->determineOptimalMediaType($containerType);
        
        // Wenn Aspect Ratio angegeben, kombiniere sie mit dem Media Type
        if ($aspectRatio) {
            $optimalType .= '_' . $aspectRatio;
            
            // Setze auch die Bootstrap Ratio-Klassen
            $this->setRatio($aspectRatio);
        }

        $this->setMediaManagerType($optimalType);
        $this->setContainerSize($containerType);
        
        return $this;
    }

    /**
     * Bestimmt den optimalen Media Manager Type basierend auf Container-Kontext
     * Angepasst an die verfügbaren Media Manager Types im Projekt
     */
    private function determineOptimalMediaType(string $containerType): string
    {
        // Bootstrap Grid-System basierte Optimierung - mit neuen Bootstrap 5 Media Manager Types
        $typeMap = [
            // Small containers - nutzen small
            'col-1' => 'small',
            'col-2' => 'small', 
            'col-3' => 'small',
            'col-4' => 'small',
            
            // Medium containers - nutzen half
            'col-5' => 'half',
            'col-6' => 'half',
            'col-7' => 'half',
            'col-8' => 'half',
            
            // Large containers - nutzen full
            'col-9' => 'full',
            'col-10' => 'full',
            'col-11' => 'full',
            'col-12' => 'full',
            
            // Special containers
            'container' => 'half',
            'container-fluid' => 'full',
            'hero' => 'full',
            'banner' => 'full',
            'fullwidth' => 'full',
            
            // Thumbnail/Preview contexts
            'thumbnail' => 'small',
            'preview' => 'small',
            'card' => 'half'
        ];
        
        // Fallback auf 'half' wenn kein Match
        return $typeMap[$containerType] ?? 'half';
    }

    /**
     * Setzt Bildgröße basierend auf semantischen Größen
     * Flexibler Ersatz für die alten setSmall/setHalf/setFull Methoden
     */
    public function setSize(string $size, ?string $aspectRatio = null): self
    {
        $mediaType = $size;
        
        // Wenn Aspect Ratio angegeben, kombiniere sie
        if ($aspectRatio) {
            $mediaType .= '_' . $aspectRatio;
        }
        
        $this->setMediaManagerType($mediaType);
        return $this;
    }

    /**
     * Convenience-Methode: Konfiguriert als dekoratives Bild (nicht essentiell für Inhalt)
     */
    public function setDecorative(bool $decorative = true): self
    {
        if ($decorative) {
            $this->config['accessibility']['role'] = 'presentation';
            $this->config['accessibility']['focusable'] = false;
            // Für dekorative Bilder sollte alt="" gesetzt werden
            $this->setAlt('');
        } else {
            $this->config['accessibility']['role'] = null;
            $this->config['accessibility']['focusable'] = null;
        }
        return $this;
    }

    /**
     * Bootstrap 5 Convenience-Methoden für semantische Größen
     */
    
    /**
     * Kleine Bilder (small_320, small_576, small_768)
     */
    public function setSmall(): self
    {
        return $this->setMediaManagerType('small');
    }
    
    /**
     * Mittlere Bilder (half_320-1400px)
     */
    public function setHalf(): self
    {
        return $this->setMediaManagerType('half');
    }
    
    /**
     * Große Bilder (full_320-1400px)
     */
    public function setFull(): self
    {
        return $this->setMediaManagerType('full');
    }
    
    /**
     * Flexibel: Setzt beliebiges Ratio mit Größe
     * @param string $ratio Beliebiges Ratio (4x3, 16x9, 21x9, 5x2, 3x1, etc.)
     * @param string $size 'small', 'half', oder 'full'
     */
    public function setRatioSize(string $ratio, string $size = 'half'): self
    {
        return $this->setMediaManagerType($size . '_' . $ratio);
    }
    
    /**
     * Quadratische Bilder (1x1 Ratio)
     * @param string $size 'small', 'half', oder 'full'
     */
    public function setSquare(string $size = 'half'): self
    {
        return $this->setRatioSize('1x1', $size);
    }
    
    /**
     * 4:3 Format Bilder (klassisches Seitenverhältnis)
     * @param string $size 'small', 'half', oder 'full'
     */
    public function set4x3(string $size = 'half'): self
    {
        return $this->setRatioSize('4x3', $size);
    }

    /**
     * 1:1 Format Bilder (quadratisch) - Alias für setSquare()
     * @param string $size 'small', 'half', oder 'full'
     */
    public function set1x1(string $size = 'half'): self
    {
        return $this->setSquare($size);
    }

    /**
     * 16:9 Format Bilder (Widescreen)
     * @param string $size 'small', 'half', oder 'full'
     */
    public function set16x9(string $size = 'half'): self
    {
        return $this->setRatioSize('16x9', $size);
    }

    /**
     * 21:9 Format Bilder (Ultrawide)
     * @param string $size 'small', 'half', oder 'full'
     */
    public function set21x9(string $size = 'half'): self
    {
        return $this->setRatioSize('21x9', $size);
    }

    /**
     * @deprecated Use setRatioSize('4x3', $size) instead - more flexible for future ratios
     * Klassische 4:3 Bilder
     * @param string $size 'small', 'half', oder 'full'
     */
    public function setClassic(string $size = 'half'): self
    {
        return $this->set4x3($size);
    }

    /**
     * Convenience-Methode: Konfiguriert als Hero/Banner-Bild mit hoher Priorität
     */
    public function setHeroBanner(?string $ariaLabel = null): self
    {
        $this->setSize('full'); // Nutze die neue setSize() Methode mit full-size
        $this->enableLazyLoading(false); // Hero-Bilder sollten nicht lazy geladen werden
        $this->config['accessibility']['focusable'] = false;
        
        if ($ariaLabel) {
            $this->setAriaLabel($ariaLabel);
        }
        
        return $this;
    }

    /**
     * Gibt den Komponenten-Schlüssel zurück
     */
    protected function getComponentKey(): ?string
    {
        return 'figure';
    }

    /**
     * Hauptmethode für die Ausgabe - direkte HTML-Renderung
     */
    public function render(): string
    {
        // Keine Bildquelle vorhanden
        if (!$this->sections['media'] && !$this->sections['url']) {
            return '';
        }

        // Bild-URL und Responsive Images bestimmen
        $imageSrc = '';
        $srcset = '';
        $sizes = '';
        $isSvg = false;

        if ($this->sections['media'] instanceof rex_media) {
            $isSvg = strtolower(pathinfo($this->sections['media']->getFileName(), PATHINFO_EXTENSION)) === 'svg';
            
            if ($isSvg || !$this->config['media']['mediaManagerType']) {
                // SVG oder ohne Media Manager Type - direkte URL
                $imageSrc = rex_url::media($this->sections['media']->getFileName());
            } else {
                // Mit Media Manager Type
                $imageSrc = rex_media_manager::getUrl($this->config['media']['mediaManagerType'], $this->sections['media']->getFileName());
            }
            
            // Responsive Images Konfiguration
            $autoResponsive = $this->config['media']['autoResponsive'] ?? false;
            $responsiveBaseType = $this->config['media']['responsiveBaseType'] ?? null;
            
            // Auto-Responsive Images für unterstützte Base-Types
            if (!$isSvg && $autoResponsive && $responsiveBaseType) {
                $forceBuiltin = $this->config['media']['forceBuiltinResponsive'] ?? false;
                
                if (!$forceBuiltin) {
                    // Erst versuchen mit project/boot.php Funktionen (falls verfügbar)
                    if (function_exists('generateSrcset')) {
                        $srcset = generateSrcset($this->sections['media']->getFileName(), $responsiveBaseType);
                        if (function_exists('generateSizesForType')) {
                            $sizes = generateSizesForType($responsiveBaseType);
                        }
                        
                        // Fallback-Versuch mit Media Manager Type falls base type nicht funktioniert
                        if (empty($srcset) && function_exists('generateSrcset')) {
                            $srcset = generateSrcset($this->sections['media']->getFileName(), $this->config['media']['mediaManagerType']);
                            if (function_exists('generateSizesForType')) {
                                $sizes = generateSizesForType($this->config['media']['mediaManagerType']);
                            }
                        }
                        
                        // Alternative: Nutze die neue getResponsiveImageData Funktion falls verfügbar
                        if (empty($srcset) && function_exists('getResponsiveImageData')) {
                            $containerType = $this->config['media']['responsiveImages']['sizesAttribute'] ?? 'container';
                            $imageData = getResponsiveImageData($this->sections['media']->getFileName(), $responsiveBaseType, $containerType);
                            if ($imageData && !empty($imageData['srcset'])) {
                                $srcset = $imageData['srcset'];
                                $sizes = $imageData['sizes'];
                            }
                        }
                    }
                }
                
                // Fallback oder Forced: Eigene responsive Images-Generierung ohne project/boot.php
                if (empty($srcset) || $forceBuiltin) {
                    $responsiveData = $this->generateBuiltinResponsiveImages($this->sections['media']->getFileName(), $responsiveBaseType);
                    if (!empty($responsiveData['srcset'])) {
                        $srcset = $responsiveData['srcset'];
                        $sizes = $responsiveData['sizes'];
                    }
                }
            }
            
        } elseif ($this->sections['url']) {
            // Externe URL
            $imageSrc = $this->sections['url'];
        }

        if (!$imageSrc) {
            return '';
        }

        // Figure Attribute
        $figureClasses = $this->config['figure']['attributes']['class'] ?? ['figure'];
        if (is_array($figureClasses)) {
            $figureClasses = implode(' ', $figureClasses);
        }

        // Alt-Text zuerst holen
        $alt = $this->getAlt();

        // Barrierefreiheits-Attribute sammeln
        $accessibilityConfig = $this->config['accessibility'];
        $ariaAttributes = $this->buildAriaAttributes($accessibilityConfig, $alt);

        // BG-Cover Funktionalität prüfen
        $isBgCover = strpos($figureClasses, 'bg-cover') !== false || strpos($figureClasses, 'img-cover') !== false;
        
        // Media Attribute
        $mediaClasses = $this->config['media']['attributes']['class'] ?? 'img-fluid';
        if (is_array($mediaClasses)) {
            $mediaClasses = implode(' ', $mediaClasses);
        }

        // Lazy Loading
        $lazyLoading = $this->config['media']['lazyLoading'] ?? false;

        // Width und Height Attribute für img-Tag
        $imgWidth = $this->config['media']['width'] ?? null;
        $imgHeight = $this->config['media']['height'] ?? null;

        // Links
        $link = $this->config['link'] ?? null;
        $lightbox = $this->config['lightbox'] ?? false;

        $html = '';
        
        // Figure mit Barrierefreiheits-Attributen
        if ($isBgCover && $imageSrc) {
            // BG-Cover: Figure mit data-bg-cover="true" für JS-System
            $html .= '<figure class="' . htmlspecialchars($figureClasses) . '" data-bg-cover="true"' . $ariaAttributes['figure'] . '>';
        } else {
            $html .= '<figure class="' . htmlspecialchars($figureClasses) . '"' . $ariaAttributes['figure'] . '>';
        }

        // Link-Wrapper
        if ($link || $lightbox) {
            $linkUrl = $lightbox ? $imageSrc : $link;
            $linkClass = $this->config['lightboxClass'] ?? '';
            if ($lightbox && !empty($linkClass)) {
                $html .= '<a href="' . htmlspecialchars($linkUrl) . '" class="' . htmlspecialchars($linkClass) . '">';
            } else {
                $html .= '<a href="' . htmlspecialchars($linkUrl) . '">';
            }
        }

        // Image Tag mit vollständiger Barrierefreiheit
        if ($isBgCover && $imageSrc) {
            // BG-Cover: IMG mit Lazy Loading für automatisches BG-Setting via JS
            if ($lazyLoading && !empty($srcset)) {
                // Lazy Loading mit Srcset für BG-Cover
                $html .= '<img class="' . htmlspecialchars($mediaClasses) . ' lazy bg-cover-img" ';
                $html .= 'data-src="' . htmlspecialchars($imageSrc) . '" ';
                $html .= 'data-srcset="' . htmlspecialchars($srcset) . '" ';
                $html .= 'data-sizes="' . htmlspecialchars($sizes) . '" ';
                $html .= 'data-bg="true" ';
                $html .= 'src="data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' viewBox=\'0 0 1 1\'%3E%3C/svg%3E" ';
                if ($imgWidth) $html .= 'width="' . htmlspecialchars($imgWidth) . '" ';
                if ($imgHeight) $html .= 'height="' . htmlspecialchars($imgHeight) . '" ';
                $html .= 'alt="" aria-hidden="true" loading="lazy"' . $ariaAttributes['img'] . '>';
            } elseif ($lazyLoading) {
                // Lazy Loading ohne Srcset für BG-Cover
                $html .= '<img class="' . htmlspecialchars($mediaClasses) . ' lazy bg-cover-img" ';
                $html .= 'data-src="' . htmlspecialchars($imageSrc) . '" ';
                $html .= 'data-bg="true" ';
                $html .= 'src="data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' viewBox=\'0 0 1 1\'%3E%3C/svg%3E" ';
                if ($imgWidth) $html .= 'width="' . htmlspecialchars($imgWidth) . '" ';
                if ($imgHeight) $html .= 'height="' . htmlspecialchars($imgHeight) . '" ';
                $html .= 'alt="" aria-hidden="true" loading="lazy"' . $ariaAttributes['img'] . '>';
            } elseif (!empty($srcset)) {
                // Normal Loading mit Srcset für BG-Cover
                $html .= '<img class="' . htmlspecialchars($mediaClasses) . ' bg-cover-img" ';
                $html .= 'src="' . htmlspecialchars($imageSrc) . '" ';
                $html .= 'srcset="' . htmlspecialchars($srcset) . '" ';
                $html .= 'sizes="' . htmlspecialchars($sizes) . '" ';
                $html .= 'data-bg="true" ';
                if ($imgWidth) $html .= 'width="' . htmlspecialchars($imgWidth) . '" ';
                if ($imgHeight) $html .= 'height="' . htmlspecialchars($imgHeight) . '" ';
                $html .= 'alt="" aria-hidden="true"' . $ariaAttributes['img'] . '>';
            } else {
                // Normal Loading ohne Srcset für BG-Cover
                $html .= '<img class="' . htmlspecialchars($mediaClasses) . ' bg-cover-img" ';
                $html .= 'src="' . htmlspecialchars($imageSrc) . '" ';
                $html .= 'data-bg="true" ';
                if ($imgWidth) $html .= 'width="' . htmlspecialchars($imgWidth) . '" ';
                if ($imgHeight) $html .= 'height="' . htmlspecialchars($imgHeight) . '" ';
                $html .= 'alt="" aria-hidden="true"' . $ariaAttributes['img'] . '>';
            }
        } elseif ($lazyLoading && !empty($srcset)) {
            // Lazy Loading mit Srcset
            $html .= '<img class="' . htmlspecialchars($mediaClasses) . ' lazy" ';
            $html .= 'data-src="' . htmlspecialchars($imageSrc) . '" ';
            $html .= 'data-srcset="' . htmlspecialchars($srcset) . '" ';
            $html .= 'data-sizes="' . htmlspecialchars($sizes) . '" ';
            $html .= 'src="data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' viewBox=\'0 0 1 1\'%3E%3C/svg%3E" ';
            if ($imgWidth) $html .= 'width="' . htmlspecialchars($imgWidth) . '" ';
            if ($imgHeight) $html .= 'height="' . htmlspecialchars($imgHeight) . '" ';
            $html .= 'alt="' . htmlspecialchars($alt) . '" loading="lazy"' . $ariaAttributes['img'] . '>';
        } elseif ($lazyLoading) {
            // Lazy Loading ohne Srcset
            $html .= '<img class="' . htmlspecialchars($mediaClasses) . ' lazy" ';
            $html .= 'data-src="' . htmlspecialchars($imageSrc) . '" ';
            $html .= 'src="data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' viewBox=\'0 0 1 1\'%3E%3C/svg%3E" ';
            if ($imgWidth) $html .= 'width="' . htmlspecialchars($imgWidth) . '" ';
            if ($imgHeight) $html .= 'height="' . htmlspecialchars($imgHeight) . '" ';
            $html .= 'alt="' . htmlspecialchars($alt) . '" loading="lazy"' . $ariaAttributes['img'] . '>';
        } elseif (!empty($srcset)) {
            // Normal Loading mit Srcset
            $html .= '<img class="' . htmlspecialchars($mediaClasses) . '" ';
            $html .= 'src="' . htmlspecialchars($imageSrc) . '" ';
            $html .= 'srcset="' . htmlspecialchars($srcset) . '" ';
            $html .= 'sizes="' . htmlspecialchars($sizes) . '" ';
            if ($imgWidth) $html .= 'width="' . htmlspecialchars($imgWidth) . '" ';
            if ($imgHeight) $html .= 'height="' . htmlspecialchars($imgHeight) . '" ';
            $html .= 'alt="' . htmlspecialchars($alt) . '"' . $ariaAttributes['img'] . '>';
        } else {
            // Normal Loading ohne Srcset
            $html .= '<img class="' . htmlspecialchars($mediaClasses) . '" ';
            $html .= 'src="' . htmlspecialchars($imageSrc) . '" ';
            if ($imgWidth) $html .= 'width="' . htmlspecialchars($imgWidth) . '" ';
            if ($imgHeight) $html .= 'height="' . htmlspecialchars($imgHeight) . '" ';
            $html .= 'alt="' . htmlspecialchars($alt) . '"' . $ariaAttributes['img'] . '>';
        }

        // NoScript-Fallback für Lazy Loading
        if ($lazyLoading && $accessibilityConfig['enableNoScriptFallback']) {
            $html .= $this->generateNoScriptFallback($imageSrc, $srcset, $sizes, $alt, $mediaClasses, $imgWidth, $imgHeight, $ariaAttributes['img']);
        }

        // Link schließen
        if ($link || $lightbox) {
            $html .= '</a>';
        }

        // Caption
        if ($this->sections['caption']) {
            $captionClasses = $this->config['caption']['attributes']['class'] ?? ['figure-caption'];
            if (is_array($captionClasses)) {
                $captionClasses = implode(' ', $captionClasses);
            }
            
            $html .= '<figcaption class="' . htmlspecialchars($captionClasses) . '">';
            if (is_array($this->sections['caption'])) {
                $html .= implode(' ', $this->sections['caption']);
            } else {
                $html .= $this->sections['caption'];
            }
            $html .= '</figcaption>';
        }

        $html .= '</figure>';

        return $html;
    }

    /**
     * Abstrakte renderHtml() Methode - erforderlich vom AbstractComponent Interface
     * Delegiert an die render() Methode für einheitliche HTML-Ausgabe
     */
    protected function renderHtml(): string
    {
        return $this->render();
    }

    /**
     * Gibt den Inhalt für das Fragment zurück - erforderlich vom Interface
     * Für Rückwärtskompatibilität mit Fragment-System
     */
    protected function getContentForFragment()
    {
        $content = [];

        // Media oder URL
        if ($this->sections['media'] instanceof rex_media) {
            $content['media'] = $this->sections['media'];
        } elseif (!empty($this->sections['url'])) {
            $content['url'] = $this->sections['url'];
        }

        // Alt-Text
        $alt = $this->getAlt();
        if (!empty($alt)) {
            $content['alt'] = $alt;
        }

        // Caption
        if ($this->sections['caption']) {
            $content['caption'] = $this->sections['caption'];
        }

        // Style
        if (!empty($this->config['style'])) {
            $content['style'] = $this->config['style'];
        }

        // Für Backend: Direkte HTML-Ausgabe als Content
        $content['directHtml'] = $this->render();

        return $content;
    }

    /**
     * Gibt die Konfiguration für das Fragment zurück - erforderlich vom Interface
     */
    protected function getConfigForFragment(): array
    {
        // Kopiere die gesamte Config
        $config = $this->config;

        // Entferne style, da es zum Content gehört
        unset($config['style']);

        // Prüfe ob es eine SVG-Datei ist
        $isSvg = false;
        if ($this->sections['media'] instanceof rex_media) {
            $isSvg = strtolower(pathinfo($this->sections['media']->getFileName(), PATHINFO_EXTENSION)) === 'svg';
        }

        // Stelle sicher, dass alle Config-Bereiche existieren
        $defaultConfig = [
            'figure' => [
                'attributes' => ['class' => ['figure']]
            ],
            'media' => [
                'lazyLoading' => false
            ],
            'caption' => [
                'attributes' => ['class' => ['figure-caption']]
            ],
            'imgWrapper' => null,
            'lightbox' => false,
            'lightboxClass' => null,
            'lightboxGallery' => null,
            'link' => null
        ];

        // Merge Config mit Defaults
        foreach ($defaultConfig as $key => $default) {
            if (isset($config[$key])) {
                $config[$key] = array_merge_recursive($default, $config[$key]);
            } else {
                $config[$key] = $default;
            }
        }

        // Spezielle Behandlung für SVG-Dateien: Media Manager Type auf null setzen
        if ($isSvg && isset($config['media']['mediaManagerType'])) {
            $config['media']['mediaManagerType'] = null;
        }

        return $config;
    }

    /**
     * Gibt den Alt-Text zurück
     */
    public function getAlt(): string
    {
        // Wenn Alt-Text explizit gesetzt wurde, verwende ihn
        if (!empty($this->sections['alt'])) {
            return $this->sections['alt'];
        }
        
        // Fallback auf Media-Titel
        if ($this->sections['media'] instanceof rex_media) {
            $title = $this->sections['media']->getTitle();
            if (!empty($title)) {
                return $title;
            }
            // Wenn kein Titel, generiere aussagekräftigen Alt-Text
            return $this->generateMeaningfulAltText($this->sections['media']->getFileName());
        }
        
        // Fallback für URLs - versuche Alt-Text zu generieren
        if (!empty($this->sections['url'])) {
            return $this->generateAltTextFromUrl($this->sections['url']);
        }
        
        return 'Bild';
    }

    /**
     * Generiert aussagekräftigen Alt-Text aus Dateiname
     */
    private function generateMeaningfulAltText(string $filename): string
    {
        // Entferne Dateiendung
        $name = pathinfo($filename, PATHINFO_FILENAME);
        
        // Entferne häufige technische Präfixe/Suffixe
        $name = preg_replace('/^(shutterstock_|getty_|adobe_|stock_)/i', '', $name);
        $name = preg_replace('/_(web|final|compressed|optimized|resized|thumb|small|medium|large|xl|xxl)$/i', '', $name);
        $name = preg_replace('/\d{6,}/', '', $name); // Entferne lange Zahlenfolgen
        
        // Wenn nach Bereinigung leer oder zu kurz, verwende generischen Text
        if (empty($name) || strlen($name) < 3) {
            return 'Bild';
        }
        
        // Ersetze Unterstriche und Bindestriche durch Leerzeichen
        $name = str_replace(['_', '-'], ' ', $name);
        
        // Entferne überflüssige Leerzeichen
        $name = preg_replace('/\s+/', ' ', trim($name));
        
        // Kapitalisiere erste Buchstaben
        $name = ucwords(strtolower($name));
        
        // Spezielle Behandlung für häufige Begriffe
        $name = str_replace([
            'Img ', 'Image ', 'Pic ', 'Picture ', 'Photo ', 'Foto '
        ], '', $name);
        
        // Fallback wenn Name leer wird
        if (empty(trim($name))) {
            return 'Bild';
        }
        
        return trim($name);
    }

    /**
     * Generiert Alt-Text aus URL (ähnlich wie in MFragmentElements)
     */
    private function generateAltTextFromUrl(string $url): string
    {
        $filename = pathinfo($url, PATHINFO_FILENAME);
        
        // Verwende die gleiche Logik wie für Media-Dateien
        $altText = $this->generateMeaningfulAltText($filename . '.' . pathinfo($url, PATHINFO_EXTENSION));
        
        // Wenn immer noch generisch, versuche aus URL-Pfad zu extrahieren
        if ($altText === 'Bild') {
            $pathParts = explode('/', parse_url($url, PHP_URL_PATH));
            $pathParts = array_filter($pathParts);
            
            // Verwende vorletzten Teil des Pfads als Kontext
            if (count($pathParts) >= 2) {
                $context = end($pathParts);
                array_pop($pathParts);
                $category = end($pathParts);
                
                if (!empty($category) && $category !== 'images' && $category !== 'img') {
                    return ucfirst($category) . ' Bild';
                }
            }
        }
        
        return $altText;
    }

    /**
     * Gibt die Caption zurück
     */
    public function getCaption(): ?array
    {
        return $this->sections['caption'];
    }

    /**
     * Gibt die Bild-URL zurück
     */
    public function getImageUrl(): ?string
    {
        return $this->sections['url'];
    }

    /**
     * Magic method für direkte String-Ausgabe
     */
    public function __toString(): string
    {
        return $this->render();
    }

    /**
     * Prüft ob ein Media Manager Type existiert (mit statischem Caching)
     * Separate Methode für saubere Trennung der Concerns
     */
    private function hasMediaManagerType(string $typeName): bool
    {
        static $availableTypes = null;
        
        if ($availableTypes === null) {
            $availableTypes = [];
            $sql = \rex_sql::factory();
            $sql->setQuery('SELECT name FROM ' . \rex::getTable('media_manager_type'));
            foreach ($sql as $row) {
                $availableTypes[] = (string) $row->getValue('name');
            }
        }
        
        return in_array($typeName, $availableTypes);
    }

    /**
     * Eigene responsive Images-Generierung ohne Abhängigkeit zur project/boot.php
     * Bootstrap 5 optimiert für Standard Media Manager Typen
     */
    private function generateBuiltinResponsiveImages(string $mediaFile, string $baseType): array
    {
        if (!$mediaFile || !file_exists(\rex_path::media($mediaFile))) {
            return ['srcset' => '', 'sizes' => ''];
        }
        
        // Hole verfügbare responsive Breakpoints und Konfiguration
        $responsiveConfig = $this->getResponsiveConfig();
        $breakpoints = $responsiveConfig['breakpoints'][$baseType] ?? $responsiveConfig['defaultBreakpoints'];
        $actualWidths = $responsiveConfig['actualWidths'];
        
        $srcsetArray = [];
        
        foreach ($breakpoints as $breakpoint) {
            $responsiveType = $baseType . '_' . $breakpoint;
            
            // Prüfe ob Media Manager Type existiert (nutzt Caching-Methode)
            if ($this->hasMediaManagerType($responsiveType)) {
                $url = \rex_media_manager::getUrl($responsiveType, $mediaFile);
                
                // Ermittle die tatsächliche Bildbreite für diesen Media Manager Type
                $actualWidth = $actualWidths[$responsiveType] ?? $breakpoint;
                $srcsetArray[] = $url . ' ' . $actualWidth . 'w';
            }
        }
        
        $srcset = implode(', ', $srcsetArray);
        $sizes = $this->generateSizesForTypeBuiltin($baseType);
        
        return [
            'srcset' => $srcset,
            'sizes' => $sizes
        ];
    }

    /**
     * Holt die responsive Images-Konfiguration
     * Kann projektspezifisch überschrieben werden
     */
    private function getResponsiveConfig(): array
    {
        // Standard-Konfiguration
        $defaultConfig = [
            'defaultBreakpoints' => [576, 768, 992, 1200],
            'breakpoints' => [
                // Minimal-Set für grundlegende Responsive Images
                'small' => [576, 768],
                'half' => [576, 768, 992, 1200],
                'full' => [576, 768, 992, 1200, 1400],
            ],
            'actualWidths' => [
                // Standard-Bildbreiten (können überschrieben werden)
                'small_576' => 280,
                'small_768' => 350,
                
                'half_576' => 400,
                'half_768' => 500,
                'half_992' => 600,
                'half_1200' => 700,
                
                'full_576' => 576,
                'full_768' => 768,
                'full_992' => 992,
                'full_1200' => 1200,
                'full_1400' => 1400,
            ]
        ];

        // Projektspezifische Überschreibung aus MFragment-Konfiguration
        $projectConfig = [];
        if (\rex_addon::get('mfragment')->isAvailable()) {
            $projectConfig = \rex_addon::get('mfragment')->getConfig('responsive_images', []);
        }

        // Instanz-spezifische Konfiguration
        $instanceConfig = $this->config['media']['customResponsiveConfig'] ?? [];

        // Konfigurationen mergen: Standard < Projekt < Instanz
        return array_merge_recursive($defaultConfig, $projectConfig, $instanceConfig);
    }

    /**
     * Sizes-Attribute Generierung basierend auf Bootstrap 5 Container-Logik
     * Eigene Implementierung ohne project/boot.php Abhängigkeit
     */
    private function generateSizesForTypeBuiltin(string $baseType): string
    {
        // Hole die sizes-Konfiguration
        $sizesConfig = $this->getSizesConfig();
        
        return $sizesConfig[$baseType] ?? $sizesConfig['default'];
    }

    /**
     * Holt die sizes-Attribut-Konfiguration
     * Kann projektspezifisch überschrieben werden
     */
    private function getSizesConfig(): array
    {
        $defaultSizes = [
            'default' => '(max-width: 575px) 280px, (max-width: 767px) 400px, (max-width: 991px) 500px, (max-width: 1199px) 600px, 700px',
            
            // Standard responsive Typen
            'full' => '(max-width: 575px) 320px, (max-width: 767px) 576px, (max-width: 991px) 768px, (max-width: 1199px) 992px, (max-width: 1399px) 1200px, 1400px',
            'half' => '(max-width: 575px) 280px, (max-width: 767px) 400px, (max-width: 991px) 500px, (max-width: 1199px) 600px, (max-width: 1399px) 700px, 800px',
            'small' => '(max-width: 575px) 160px, (max-width: 767px) 200px, 250px',
            
            // Legacy Unterstützung
            'content_full' => '(max-width: 575px) 320px, (max-width: 767px) 576px, (max-width: 991px) 768px, (max-width: 1199px) 992px, (max-width: 1399px) 1200px, 1400px',
            'content_half' => '(max-width: 575px) 280px, (max-width: 767px) 400px, (max-width: 991px) 500px, (max-width: 1199px) 600px, (max-width: 1399px) 700px, 800px',
            'content_small' => '(max-width: 575px) 160px, (max-width: 767px) 200px, 250px',
        ];

        // Projektspezifische Überschreibung aus MFragment-Konfiguration
        $projectSizes = [];
        if (\rex_addon::get('mfragment')->isAvailable()) {
            $projectSizes = \rex_addon::get('mfragment')->getConfig('responsive_sizes', []);
        }

        // Instanz-spezifische Konfiguration
        $instanceSizes = [];
        if (isset($this->config['media']['customResponsiveConfig']['sizes'])) {
            $instanceSizes = $this->config['media']['customResponsiveConfig']['sizes'];
        }

        return array_merge($defaultSizes, $projectSizes, $instanceSizes);
    }

    /**
     * Baut ARIA-Attribute für Barrierefreiheit auf
     */
    private function buildAriaAttributes(array $accessibilityConfig, string $alt): array
    {
        $figureAttrs = [];
        $imgAttrs = [];

        // Role-Attribut
        if (!empty($accessibilityConfig['role'])) {
            $imgAttrs[] = 'role="' . htmlspecialchars($accessibilityConfig['role']) . '"';
        }

        // ARIA-Label
        if (!empty($accessibilityConfig['ariaLabel'])) {
            $imgAttrs[] = 'aria-label="' . htmlspecialchars($accessibilityConfig['ariaLabel']) . '"';
        }

        // ARIA-DescribedBy
        if (!empty($accessibilityConfig['ariaDescribedBy'])) {
            $imgAttrs[] = 'aria-describedby="' . htmlspecialchars($accessibilityConfig['ariaDescribedBy']) . '"';
        }

        // ARIA-LabelledBy
        if (!empty($accessibilityConfig['ariaLabelledBy'])) {
            $imgAttrs[] = 'aria-labelledby="' . htmlspecialchars($accessibilityConfig['ariaLabelledBy']) . '"';
        }

        // Focusable
        if (isset($accessibilityConfig['focusable'])) {
            $tabindex = $accessibilityConfig['focusable'] ? '0' : '-1';
            $imgAttrs[] = 'tabindex="' . $tabindex . '"';
        }

        return [
            'figure' => !empty($figureAttrs) ? ' ' . implode(' ', $figureAttrs) : '',
            'img' => !empty($imgAttrs) ? ' ' . implode(' ', $imgAttrs) : ''
        ];
    }

    /**
     * Generiert NoScript-Fallback für Lazy Loading
     */
    private function generateNoScriptFallback(string $imageSrc, string $srcset, string $sizes, string $alt, string $mediaClasses, ?int $imgWidth, ?int $imgHeight, string $ariaAttributes): string
    {
        $noscript = '<noscript>';
        
        if (!empty($srcset)) {
            // Fallback mit Srcset
            $noscript .= '<img class="' . htmlspecialchars($mediaClasses) . '" ';
            $noscript .= 'src="' . htmlspecialchars($imageSrc) . '" ';
            $noscript .= 'srcset="' . htmlspecialchars($srcset) . '" ';
            $noscript .= 'sizes="' . htmlspecialchars($sizes) . '" ';
            if ($imgWidth) $noscript .= 'width="' . htmlspecialchars($imgWidth) . '" ';
            if ($imgHeight) $noscript .= 'height="' . htmlspecialchars($imgHeight) . '" ';
            $noscript .= 'alt="' . htmlspecialchars($alt) . '"' . $ariaAttributes . '>';
        } else {
            // Einfacher Fallback
            $noscript .= '<img class="' . htmlspecialchars($mediaClasses) . '" ';
            $noscript .= 'src="' . htmlspecialchars($imageSrc) . '" ';
            if ($imgWidth) $noscript .= 'width="' . htmlspecialchars($imgWidth) . '" ';
            if ($imgHeight) $noscript .= 'height="' . htmlspecialchars($imgHeight) . '" ';
            $noscript .= 'alt="' . htmlspecialchars($alt) . '"' . $ariaAttributes . '>';
        }
        
        $noscript .= '</noscript>';
        
        return $noscript;
    }
}