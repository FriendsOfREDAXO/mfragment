<?php
# path: src/addons/mfragment/fragments/default/figure.php

/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 */

use FriendsOfRedaxo\MFragment\Core\RenderEngine;
use FriendsOfRedaxo\MFragment\Helper\MFragmentHelper;
use FriendsOfRedaxo\MFragment\Helper\MFragmentMediaHelper;

// Konsistente API: Content und Config getrennt
$content = $this->getVar('content', []);
$config = $this->getVar('config', []);

// Fallback für alte API - direkter Zugriff auf Variablen
if (empty($content) && empty($config)) {
    $media = $this->getVar('media');
    $url = $this->getVar('url');
    $alt = $this->getVar('alt', '');
    $caption = $this->getVar('caption');
    $config = $this->getVar('config', []);
} else {
    // Neue API - aus Content extrahieren
    $media = $content['media'] ?? null;
    $url = $content['url'] ?? null;
    $alt = $content['alt'] ?? '';
    $caption = $content['caption'] ?? null;
}

// DEBUG: Fragment-Variablen prüfen
if (function_exists('debugFigureConfig')) {
    debugFigureConfig($media, $url, $config, $content);
}

// ZUSÄTZLICHES DEBUG für Entwicklung
if (rex::isBackend() || rex_request('figure_debug', 'bool', false)) {
    echo "<div style='background: #e3f2fd; border: 1px solid #2196f3; padding: 10px; margin: 10px 0; font-family: monospace; font-size: 11px;'>";
    echo "<strong>🔧 Fragment Data Flow Debug:</strong><br>";
    echo "Content Array: " . (!empty($content) ? json_encode($content, JSON_PRETTY_PRINT) : 'EMPTY') . "<br>";
    echo "Config Array: " . (!empty($config) ? json_encode($config, JSON_PRETTY_PRINT) : 'EMPTY') . "<br>";
    echo "Final Media: " . ($media instanceof rex_media ? $media->getFileName() : 'NULL/INVALID') . "<br>";
    echo "Final URL: " . ($url ?: 'NULL') . "<br>";
    echo "Final Alt: " . ($alt ?: 'NULL') . "<br>";
    echo "</div>";
}

// Style aus Content extrahieren
$style = $content['style'] ?? '';

// Prüfen, ob weder Media noch URL vorhanden ist
if (!$media instanceof rex_media && empty($url)) {
    return '';
}

// Default-Konfiguration
$figureConfig = $config['figure'] ?? ['attributes' => ['class' => ['default' => 'figure']]];
$mediaConfig = $config['media'] ?? [];
$captionConfig = $config['caption'] ?? [];

// Standard-Klassen für Caption
$defaultCaptionClasses = [
    'default' => 'figure-caption',
    'padding' => 'px-3 py-2',
    'display' => 'd-flex',
    'flex' => 'flex-column',
    'gap' => 'gap-1',
];

// Caption-Klassen zusammenführen
if (!isset($captionConfig['attributes'])) {
    $captionConfig['attributes'] = [];
}
if (!isset($captionConfig['attributes']['class'])) {
    $captionConfig['attributes']['class'] = [];
}

$captionConfig['attributes']['class'] = array_merge(
    $defaultCaptionClasses,
    $captionConfig['attributes']['class']
);

// Unique IDs für Accessibility generieren
$figureId = 'figure-' . uniqid();
$imageId = 'image-' . uniqid();
$captionId = 'caption-' . uniqid();
$titleId = 'title-' . uniqid();

// ARIA-Attribute
$figureAttributes = array_merge($figureConfig['attributes'] ?? [], [
    'role' => 'group',
    'aria-labelledby' => $titleId,
    'id' => $figureId
]);

// Klassen sicherstellen
if (!isset($figureAttributes['class'])) {
    $figureAttributes['class'] = [];
} elseif (is_string($figureAttributes['class'])) {
    $figureAttributes['class'] = explode(' ', $figureAttributes['class']);
}

// Style-spezifische Klassen hinzufügen
if ($style === 'fill') {
    $figureAttributes['class'][] = 'img-cover';
}

// Media verarbeiten
if ($media instanceof rex_media) {
    $managedMedia = MFragmentMediaHelper::getManagedMediaImage($media, $mediaConfig['mediaManagerType'] ?? 'default');
    $managedMediaAttributes = isset($managedMedia['attributes']) && is_array($managedMedia['attributes'])
        ? $managedMedia['attributes']
        : [];
    unset($managedMedia['attributes']);

    // Media-Attribute zusammenführen
    $imgAttributes = array_merge(
        $mediaConfig['attributes'] ?? [],
        $managedMediaAttributes,
        is_array($managedMedia) ? $managedMedia : [],
        [
            'id' => $imageId,
            'data-bg' => ($style === 'fill') ? 'true' : 'false'
        ]
    );
} else {
    // URL verarbeiten
    $imgAttributes = array_merge(
        $mediaConfig['attributes'] ?? [],
        [
            'id' => $imageId,
            'data-bg' => ($style === 'fill') ? 'true' : 'false',
            'src' => $url
        ]
    );
}

// Klassen-Array sicherstellen
if (!isset($imgAttributes['class'])) {
    $imgAttributes['class'] = [];
} elseif (is_string($imgAttributes['class'])) {
    $imgAttributes['class'] = explode(' ', $imgAttributes['class']);
}

// Alt-Text basierend auf Lightbox/Link
if (!empty($config['lightbox']) || !empty($config['link'])) {
    $imgAttributes['alt'] = ''; // Dekoratives Bild
    $imgAttributes['role'] = 'presentation';
} else {
    $imgAttributes['alt'] = $alt; // Alt-Text nur wenn Bild nicht in Link
}

// Lazy Loading hinzufügen mit Fallback-Strategien
if (!empty($mediaConfig['lazyLoading']) && $mediaConfig['lazyLoading'] === true && !rex::isBackend()) {
    $imgAttributes['class'][] = 'lazy';
    $imgAttributes['data-src'] = $imgAttributes['src'];
    
    // Prüfe ob kritisches Bild (above-fold)
    $isCritical = isset($config['critical']) && $config['critical'] === true ||
                  in_array('above-fold', $figureAttributes['class'] ?? []) ||
                  in_array('critical', $figureAttributes['class'] ?? []);
    
    // img-cover Detection für data-bg Attribut
    $isImgCover = in_array('img-cover', $figureAttributes['class'] ?? []);
    
    // Ratio-Container Detection (z.B. ratio-1x1, ratio-16x9, etc.)
    $hasRatioClass = false;
    foreach ($figureAttributes['class'] as $class) {
        if (strpos($class, 'ratio-') === 0) {
            $hasRatioClass = true;
            break;
        }
    }
    
    // data-bg Attribut für JavaScript-Erkennung
    if ($isImgCover || $hasRatioClass) {
        $imgAttributes['data-bg'] = 'true';
        $figureAttributes['data-bg-fallback'] = 'true';
        
        // Spezielle Klasse für Ratio-Container mit Background
        if ($hasRatioClass) {
            $figureAttributes['class'][] = 'ratio-bg-container';
        }
    } else {
        $imgAttributes['data-bg'] = 'false';
    }
    
    // Loading-Optimierungen
    $imgAttributes['loading'] = $isCritical ? 'eager' : 'lazy';
    $imgAttributes['decoding'] = 'async';
    
    // Für ALLE Lazy Loading Bilder (auch kritische): KEIN sofortiges Background-Image
    // Noscript-Fallback reicht aus - JavaScript setzt Background bei Bedarf

    // Für normale Lazy Loading Bilder: Besserer Placeholder mit Fallback
    $width = 800;
    $height = 600;
    
    // Versuche echte Dimensionen zu bekommen
    if ($media instanceof rex_media) {
        $width = $media->getWidth() ?: 800;
        $height = $media->getHeight() ?: 600;
    }
    
    // Berechne Aspect Ratio für bessere Platzhalter
    $aspectRatio = $height > 0 ? round(($height / $width) * 100, 2) : 66.67;
    
    // Einfacher 1x1 Pixel transparenter Placeholder
    $imgAttributes['src'] = 'data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1 1"%3E%3Crect width="1" height="1" fill="%23f5f5f5" opacity="0.1"/%3E%3C/svg%3E';
    
    // Für img-cover und ratio-container: nur data-bg-url für JavaScript speichern
    if ($isImgCover || $hasRatioClass) {
        $imageUrl = $media instanceof rex_media 
            ? rex_media_manager::getUrl($mediaConfig['mediaManagerType'] ?? 'default', $media->getFileName()) 
            : $url;
        
        // NICHT sofort background-image setzen - das macht Lazy Loading sinnlos!
        // Stattdessen: nur data-bg-url für JavaScript speichern
        $figureAttributes['data-bg-url'] = $imageUrl;
        $figureAttributes['class'][] = 'lazy-bg-container'; // Markierung für JavaScript
        $figureAttributes['data-aspect-ratio'] = $aspectRatio;
        
        // CSS-Placeholder (ohne echtes Bild)
        $figureAttributes['style'] = 
            (isset($figureAttributes['style']) ? $figureAttributes['style'] . '; ' : '') .
            "background-size: cover; background-position: center;";
        
        // img-Element KOMPLETT verstecken für img-cover/ratio - nur für JavaScript benötigt
        // Element ist unsichtbar und nimmt keinen Platz ein, aber JavaScript kann es verarbeiten
        $imgAttributes['style'] = (isset($imgAttributes['style']) ? $imgAttributes['style'] . '; ' : '') . 
            'position: absolute !important; top: -9999px !important; left: -9999px !important; width: 1px !important; height: 1px !important; opacity: 0 !important; visibility: hidden !important; pointer-events: none !important;';
    }
    
    // Noscript Fallback generieren für alle Lazy-Loading Bilder (verbessert)
    if (isset($imgAttributes['data-src'])) {
        $noscriptImageUrl = $imgAttributes['data-src'];
        $noscriptAlt = $imgAttributes['alt'] ?? '';
        $noscriptClass = ($isImgCover || $hasRatioClass) ? 'style="width: 100%; height: 100%; object-fit: cover; opacity: 1 !important; visibility: visible !important; position: static !important;"' : 'style="width: 100%; height: auto; opacity: 1 !important; visibility: visible !important; position: static !important;"';
        
        $noscriptFallback = sprintf(
            '<noscript><img src="%s" alt="%s" %s loading="eager" decoding="async"></noscript>',
            htmlspecialchars($noscriptImageUrl),
            htmlspecialchars($noscriptAlt),
            $noscriptClass
        );
    }
} else if (!empty($mediaConfig['lazyLoading']) && $mediaConfig['lazyLoading'] === true && rex::isBackend()) {
    // Für Backend: Verwende die korrekte Media Manager URL statt der direkten Bildquelle
    $imageUrl = $media instanceof rex_media 
        ? rex_media_manager::getUrl($mediaConfig['mediaManagerType'] ?? 'default', $media->getFileName()) 
        : $url;
    $figureAttributes['style'] = 'background-image: url(' . $imageUrl . ');';
} else {
    // Wenn Lazy Loading deaktiviert ist, setze trotzdem data-bg Attribute für Konsistenz
    $isImgCover = in_array('img-cover', $figureAttributes['class'] ?? []);
    $hasRatioClass = false;
    foreach ($figureAttributes['class'] as $class) {
        if (strpos($class, 'ratio-') === 0) {
            $hasRatioClass = true;
            break;
        }
    }
    $imgAttributes['data-bg'] = ($isImgCover || $hasRatioClass) ? 'true' : 'false';
}

// Bild-Tag erstellen
$img = MFragmentHelper::createTag('img', null, ['attributes' => $imgAttributes]);

// Image-Wrapper wenn konfiguriert
if (!empty($config['imgWrapper'])) {
    $img = MFragmentHelper::createTag('div', $img, ['attributes' => $config['imgWrapper']['attributes'] ?? []]);
}

$figureContent = [$img];

// Noscript-Fallback hinzufügen falls vorhanden
if (isset($noscriptFallback)) {
    $figureContent[] = $noscriptFallback;
}

// Caption verarbeiten
if (!empty($caption)) {
    $captionContent = [];

    // Haupt-Caption-Inhalt (Titel und Beschreibung)
    if (!empty($caption['title']) || !empty($caption['description'])) {
        $inlineContent = [];

        if (!empty($caption['title'])) {
            $inlineContent[] = MFragmentHelper::createTag('strong', $caption['title'], [
                'attributes' => [
                    'class' => ['default' => 'title', 'font' => 'fw-bold'],
                    'id' => $titleId
                ]
            ]);
        }

        if (!empty($caption['description'])) {
            if (!empty($caption['title'])) {
                $inlineContent[] = MFragmentHelper::createTag('span', ' - ', [
                    'attributes' => ['class' => ['separator']]
                ]);
            }
            $inlineContent[] = MFragmentHelper::createTag('span', $caption['description'], [
                'attributes' => ['class' => ['default' => 'description']]
            ]);
        }

        $captionContent[] = MFragmentHelper::createTag('div', $inlineContent, [
            'attributes' => ['class' => [
                'default' => 'caption-text',
                'gap' => 'gap-2'
            ]]
        ]);
    }

    // Meta-Wrapper für Author und Copyright
    if (!empty($caption['author']) || !empty($caption['copyright'])) {
        $metaContent = [];

        if (!empty($caption['author'])) {
            $metaContent[] = MFragmentHelper::createTag('cite', $caption['author'], [
                'attributes' => ['class' => ['default' => 'author']]
            ]);
        }

        if (!empty($caption['copyright'])) {
            $metaContent[] = MFragmentHelper::createTag('small', "© {$caption['copyright']}", [
                'attributes' => ['class' => ['default' => 'copyright']]
            ]);
        }

        if (!empty($metaContent)) {
            $captionContent[] = MFragmentHelper::createTag('div', $metaContent, [
                'attributes' => ['class' => [
                    'default' => 'd-flex',
                    'justify' => 'justify-content-between',
                    'align' => 'align-items-center'
                ]]
            ]);
        }
    }

    if (!empty($captionContent)) {
        $captionAttributes = array_merge($captionConfig['attributes'], [
            'id' => $captionId,
            'aria-describedby' => $imageId
        ]);
        $figureContent[] = MFragmentHelper::createTag('figcaption', $captionContent, [
            'attributes' => $captionAttributes
        ]);
    }
}

// Figure erstellen
$figure = MFragmentHelper::createTag('figure', $figureContent, [
    'attributes' => $figureAttributes
]);

// Lightbox oder Link verarbeiten
if (!empty($config['lightbox'])) {
    $lightboxClass = $config['lightboxClass'] ?? 'lightbox';
    $imageTitle = $caption['title'] ?? $alt;
    $galleryId = $config['lightboxGallery'] ?? 'gallery-' . uniqid();
    $imageSrc = $media instanceof rex_media ? $media->getUrl() : $url;

    $lightboxAttributes = [
        'attributes' => [
            'href' => $imageSrc,
            'class' => ['default' => $lightboxClass],
            'data-lightbox' => $galleryId,
            'data-title' => $imageTitle,
            'aria-label' => $imageTitle ? "Bild «{$imageTitle}» in Großansicht öffnen" : 'Bild in Großansicht öffnen',
            'role' => 'button',
        ]
    ];

    if (isset($managedMediaAttributes['width'])) {
        $lightboxAttributes['attributes']['data-pswp-width'] = $managedMediaAttributes['width'];
    }
    if (isset($managedMediaAttributes['height'])) {
        $lightboxAttributes['attributes']['data-pswp-height'] = $managedMediaAttributes['height'];
    }

    $figure = MFragmentHelper::createTag('a', $figure, $lightboxAttributes);

} elseif (!empty($config['link'])) {
    $url = (is_numeric($config['link'])) ? rex_getUrl($config['link']) : $config['link'];
    $imageTitle = $caption['title'] ?? $alt;

    // Link-Attribute vorbereiten
    $linkAttributes = [
        'href' => $url,
        'aria-label' => $imageTitle ? "Zu «{$imageTitle}» navigieren" : 'Zum verlinkten Inhalt navigieren'
    ];
    
    // Zusätzliche Link-Attribute aus Config hinzufügen (z.B. target, rel)
    if (!empty($config['linkAttributes'])) {
        $linkAttributes = array_merge($linkAttributes, $config['linkAttributes']);
    }

    $figure = MFragmentHelper::createTag('a', $figure, [
        'attributes' => $linkAttributes
    ]);
}

// RenderEngine verwenden statt direkter Processor
echo RenderEngine::render($figure);