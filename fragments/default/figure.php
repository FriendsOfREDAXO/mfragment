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
if (!$media instanceof rex_media) {
    return '';
}

$figureConfig = $config['figure'] ?? ['attributes' => ['class' => ['default' => 'figure']]];
$mediaConfig = $config['media'] ?? [];
$captionConfig = $config['caption'] ?? [];

// Generate unique IDs for accessibility attributes
$figureId = 'figure-' . uniqid();
$imageId = 'image-' . uniqid();
$captionId = 'caption-' . uniqid();

// Add ARIA attributes to the figure element
$figureConfig['attributes'] = array_merge($figureConfig['attributes'] ?? [], [
    'role' => 'group',
    'aria-labelledby' => $captionId
]);

if (!function_exists('createSVGPlaceholder')) {
    function createSVGPlaceholder($width, $height, $color = '#f0f0f0'): string
    {
        $svg = <<<SVG
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {$width} {$height}">
        <rect width="100%" height="100%" fill="{$color}"/>
    </svg>
    SVG;
        return 'data:image/svg+xml,' . rawurlencode($svg);
    }
}

$managedMedia = MFragmentMediaHelper::getManagedMediaImage($media, $mediaConfig['mediaManagerType'] ?? 'default');
$managedMediaAttributes = $managedMedia['attributes'] ?? [];
unset($managedMedia['attributes']);

$imgAttributes = array_merge($mediaConfig['attributes'] ?? [], $managedMediaAttributes, $managedMedia, [
    'alt' => $alt,
    'id' => $imageId
]);

// Add lazy loading if configured
if (!empty($mediaConfig['lazyLoading']) && $mediaConfig['lazyLoading'] === true && !rex::isBackend()) {
    $imgAttributes['class']['lazy'] = 'lazy';
    $imgAttributes['src'] = createSVGPlaceholder(($managedMediaAttributes['width'] ?? 800), ($managedMediaAttributes['height'] ?? 800), $color = '#f0f0f0');

}

$figureContent = [
    MFragmentHelper::createTag('img', null, ['attributes' => $imgAttributes])
];

// TODO: optionally retrieve title, description, author, copyright from media pool
if (!empty($caption)) {
    $captionContent = [];
    if (!empty($caption['title'])) {
        $captionContent[] = MFragmentHelper::createTag('strong', $caption['title'], ['attributes' => ['id' => $captionId, 'class' => 'title']]);
    }
    if (!empty($caption['description'])) {
        $captionContent[] = MFragmentHelper::createTag('span', $caption['description'], ['attributes' => ['class' => ['default' => 'description']]]);
    }
    if (!empty($caption['author'])) {
        $captionContent[] = MFragmentHelper::createTag('cite', $caption['author'], ['attributes' => ['class' =>  ['default' => 'author']]]);
    }
    if (!empty($caption['copyright'])) {
        $captionContent[] = MFragmentHelper::createTag('small', "© {$caption['copyright']}", ['attributes' => ['class' => ['default' => 'copyright']]]);
    }

    if (!empty($captionContent)) {
        $captionAttributes = array_merge($captionConfig['attributes'] ?? [], [
            'id' => $captionId,
            'aria-describedby' => $imageId
        ]);
        $figureContent[] = MFragmentHelper::createTag('figcaption', $captionContent, ['attributes' => $captionAttributes]);
    }
}

$figure = MFragmentHelper::createTag('figure', $figureContent, ['attributes' => $figureConfig['attributes']]);

// TODO!
if (!empty($config['lightbox'])) {
    $lightboxClass = $config['lightboxClass'] ?? 'lightbox';
    $figure = MFragmentHelper::createTag('a', $figure, [
        'attributes' => [
            'href' => $media->getUrl(),
            'class' => ['lightbox' => $lightboxClass],
            'data-lightbox' => 'gallery',
            'data-title' => $caption['title'] ?? $alt,
            'aria-label' => 'Öffne Bild in Großansicht',
            'role' => 'button'
        ]
    ]);
} elseif (!empty($config['link'])) {
    $url = rex_getUrl($config['link']);
    $figure = MFragmentHelper::createTag('a', $figure, [
        'attributes' => [
            'href' => $url,
            'aria-label' => 'Mehr Informationen zu ' . ($caption['title'] ?? $alt)
        ]
    ]);
}

$processor = new MFragmentProcessor();
echo $processor->process($figure);
