<?php
/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 */

use FriendsOfRedaxo\MFragment\Core\MFragmentProcessor;
use FriendsOfRedaxo\MFragment\Helper\MFragmentHelper;
use FriendsOfRedaxo\MFragment\Helper\MFragmentMediaHelper;

$media = $this->getVar('media');
$alt = $this->getVar('alt', '');
$caption = $this->getVar('caption', []);
$config = $this->getVar('config', []);
$style = $this->getVar('style', '');

if (!$media instanceof rex_media) {
    return '';
}

// Default configurations
$figureConfig = $config['figure'] ?? ['attributes' => ['class' => ['default' => 'figure']]];
$mediaConfig = $config['media'] ?? [];
$defaultClasses = [
    'default' => 'figure-caption',
    'padding' => 'px-3 py-2',
    'display' => 'd-flex',
    'flex' => 'flex-column',
    'gap' => 'gap-1',
];
$captionConfig = $config['caption'] ?? [];
$captionConfig['attributes']['class'] = (!empty($config['caption']['attributes']['class'])) ? array_merge(
    $defaultClasses,
    $config['caption']['attributes']['class'],
) : $defaultClasses;

$imgWrapper = $config['imgWrapper'] ?? [];

// Generate unique IDs for accessibility
$figureId = 'figure-' . uniqid();
$imageId = 'image-' . uniqid();
$captionId = 'caption-' . uniqid();
$titleId = 'title-' . uniqid();

// Add ARIA attributes
$figureConfig['attributes'] = array_merge($figureConfig['attributes'] ?? [], [
    'role' => 'group',
    'aria-labelledby' => $titleId
]);

// Check if background image style is requested
if ($style === 'fill') {
    $figureConfig['attributes']['class'][] = 'img-cover';
}

// Process media
$managedMedia = MFragmentMediaHelper::getManagedMediaImage($media, $mediaConfig['mediaManagerType'] ?? 'default');
$managedMediaAttributes = $managedMedia['attributes'] ?? [];
unset($managedMedia['attributes']);

$imgAttributes = array_merge($mediaConfig['attributes'] ?? [], $managedMediaAttributes, $managedMedia, [
    'id' => $imageId,
    'data-bg' => ($style === 'fill') ? 'true' : 'false'
]);

// Bei Lightbox oder Link: Bild als dekorativ markieren
if (!empty($config['lightbox']) || !empty($config['link'])) {
    $imgAttributes['alt'] = ''; // Dekoratives Bild
    $imgAttributes['role'] = 'presentation';
} else {
    $imgAttributes['alt'] = $alt; // Alt-Text nur wenn Bild nicht in Link
}

// Add lazy loading if configured
if (!empty($mediaConfig['lazyLoading']) && $mediaConfig['lazyLoading'] === true && !rex::isBackend()) {
    $imgAttributes['class'][] = 'lazy';
    $imgAttributes['data-src'] = $imgAttributes['src'];
    $imgAttributes['src'] = 'data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ' .
        ($managedMediaAttributes['width'] ?? 800) . ' ' .
        ($managedMediaAttributes['height'] ?? 800) .
        '"%3E%3Crect width="100%" height="100%" fill="%23f0f0f0"/%3E%3C/svg%3E';
}

// Create image tag
$img = MFragmentHelper::createTag('img', null, ['attributes' => $imgAttributes]);
if (!empty($imgWrapper)) {
    $img = MFragmentHelper::createTag('div', $img, ['attributes' => $imgWrapper['attributes']]);
}

$figureContent = [$img];

// Process caption
if (!empty($caption)) {
    $captionContent = [];

    // Main caption content (title and description)
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

    // Meta wrapper for author and copyright
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
        $captionAttributes = array_merge($captionConfig['attributes'] ?? [], [
            'id' => $captionId,
            'aria-describedby' => $imageId
        ]);
        $figureContent[] = MFragmentHelper::createTag('figcaption', $captionContent, [
            'attributes' => $captionAttributes
        ]);
    }
}

// Create figure
$figure = MFragmentHelper::createTag('figure', $figureContent, [
    'attributes' => $figureConfig['attributes']
]);

// Process lightbox or link
if (!empty($config['lightbox'])) {
    $lightboxClass = $config['lightboxClass'] ?? 'lightbox';
    $imageTitle = $caption['title'] ?? $alt;
    $galleryId = $config['lightboxGallery'] ?? 'gallery-' . uniqid();

    $lightboxAttributes = [
        'attributes' => [
            'href' => $media->getUrl(),
            'class' => ['default' => $lightboxClass],
            'data-lightbox' => $galleryId, // Hier wird die Galerie-ID gesetzt
            'data-title' => $imageTitle,
            'aria-label' => $imageTitle ? "Bild «{$media->getTitle()}» in Großansicht öffnen" : 'Bild in Großansicht öffnen',
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
    $url = rex_getUrl($config['link']);
    $imageTitle = $caption['title'] ?? $alt;

    $figure = MFragmentHelper::createTag('a', $figure, [
        'attributes' => [
            'href' => $url,
            'aria-label' => $imageTitle ? "Zu «{$imageTitle}» navigieren" : 'Zum verlinkten Inhalt navigieren'
        ]
    ]);
}

$processor = new MFragmentProcessor();
echo $processor->process($figure);