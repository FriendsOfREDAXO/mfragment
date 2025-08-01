<?php
# path: src/addons/mfragment/fragments/bootstrap/images.php

/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 */

use FriendsOfRedaxo\MFragment\Core\RenderEngine;
use FriendsOfRedaxo\MFragment\Helper\MFragmentHelper;

// Versuche verschiedene Wege, die Bilddaten zu erhalten
$rawImages = $this->getVar('images', []);
$rawContent = $this->getVar('content', []);
$images = [];

// Wenn die Bilder in content.images verschachtelt sind, extrahiere sie
if (empty($rawImages) && is_array($rawContent)) {
    $images = (is_array($rawContent['images'])) ? is_array($rawContent['images']) : $rawContent;
} else {
    $images = $rawImages;
}

// Hier das gleiche für die Konfiguration
$rawConfig = $this->getVar('config', []);
$config = [];

// Wenn die Konfiguration in content.config verschachtelt ist, extrahiere sie
if (empty($rawConfig) && isset($rawContent['config']) && is_array($rawContent['config'])) {
    $config = $rawContent['config'];
} else {
    $config = $rawConfig;
}

$defaultConfig = [
    'wrapper' => [
        'tag' => 'div',
        'attributes' => ['class' => 'col col-sm-6 col-lg-4']
    ],
    'figure' => [
        'attributes' => ['class' => ['figure']]
    ],
    'media' => [
        'attributes' => ['class' => ['img-fluid']],
        'mediaManagerType' => 'default',
        'lazyLoading' => true,
    ],
    'caption' => [
        'attributes' => ['class' => ['figure-caption']]
    ],
    'container' => [
        'tag' => 'div',
        'attributes' => [
            'class' => ['default' => 'row'],
        ]
    ],
    'defaultShowTitleAndDescription' => true,
    'lightboxEnabled' => false,
    'lightboxClass' => 'lightbox',
    'lightboxGalleryId' => 'gallery-' . uniqid() // Eindeutige Galerie-ID für diese Instanz
];

$config = MFragmentHelper::mergeConfig($defaultConfig, $config);
$imageElements = [];

foreach ($images as $image) {
    if (!isset($image['media']) || !$image['media'] instanceof rex_media) {
        continue;
    }

    // Bestimme, ob Titel und Beschreibung angezeigt werden sollen
    $showTitleAndDescription = false;
    if (isset($image['showTitleAndDescription']) && $image['showTitleAndDescription'] === '1') {
        $showTitleAndDescription = true;
    } else {
        $showTitleAndDescription = $config['defaultShowTitleAndDescription'] ?? true;
    }

    // Bereite die Figurenkonfiguration vor
    $figureConfig = [
        'media' => $image['media'],
        'alt' => $image['alt'] ?? $image['media']->getTitle(),
        'config' => [
            'figure' => $config['figure'],
            'media' => array_merge($config['media'], [
                'mediaManagerType' => $config['media']['mediaManagerType']
            ]),
            'caption' => $config['caption']
        ]
    ];

    // Füge imgWrapper hinzu, wenn konfiguriert
    if (isset($config['imgWrapper'])) {
        $figureConfig['config']['imgWrapper'] = $config['imgWrapper'];
    }

    // Setze Caption-Daten
    if ($showTitleAndDescription) {
        $figureConfig['caption'] = [
            'title' => $image['customTitle'] ?? $image['media']->getTitle(),
            'description' => $image['customDescription'] ?? $image['media']->getValue('med_description'),
            'author' => $image['customAuthor'] ?? $image['media']->getValue('med_author'),
            'copyright' => $image['customCopyright'] ?? $image['media']->getValue('med_copyright')
        ];
    }

    // Lightbox-Konfiguration
    if ($config['lightboxEnabled']) {
        $figureConfig['config']['lightbox'] = true;
        $figureConfig['config']['lightboxClass'] = $config['lightboxClass'];
        $figureConfig['config']['lightboxGallery'] = $config['lightboxGalleryId'];
    }
    // Oder Custom Link-Option
    elseif (isset($image['linkOption']) && $image['linkOption'] === '3' && !empty($image['link']) && isset($image['link']['id'])) {
        $figureConfig['config']['link'] = $image['link']['id'];
    }

    echo MFragmentHelper::createFragment('default/figure', $figureConfig);

    // Erzeuge das Figur-Element
    $imageElements[] = MFragmentHelper::createTag(
        $config['wrapper']['tag'],
        MFragmentHelper::createFragment('default/figure', $figureConfig),
        ['attributes' => $config['wrapper']['attributes']]
    );

}


if (count($imageElements) > 0) {
    dump($imageElements);
    // Stelle sicher, dass die Container-Konfiguration gültig ist
    $containerAttributes = $config['container']['attributes'] ?? [];
    if (isset($containerAttributes['class']) && is_string($containerAttributes['class'])) {
        $containerAttributes['class'] = explode(' ', $containerAttributes['class']);
    }

    echo RenderEngine::render(
        MFragmentHelper::createTag(
            $config['container']['tag'],
            $imageElements,
            ['attributes' => $containerAttributes]
        )
    );
}
