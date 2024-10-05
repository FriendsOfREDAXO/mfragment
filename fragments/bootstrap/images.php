<?php
/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 */

use FriendsOfRedaxo\MFragment\Core\MFragmentProcessor;
use FriendsOfRedaxo\MFragment\Helper\MFragmentHelper;

$images = $this->getVar('images', []);
$config = $this->getVar('config', []);

$defaultConfig = [
    'wrapper' => [
        'tag' => 'div',
        'attributes' => ['class' => ['default' => 'col', 'column' => 'col-sm-6 col-lg-4']]
    ],
    'figure' => [
        'attributes' => ['class' => ['default' => 'figure']]
    ],
    'media' => [
        'attributes' => ['class' => ['default' => 'img-fluid']],
        'mediaManagerType' => 'default',
        'lazyLoading' => true,
    ],
    'caption' => [
        'attributes' => ['class' => ['default' => 'figure-caption']]
    ],
    'container' => [
        'tag' => 'div',
        'attributes' => [
            'class' => ['default' => 'row'],
            'data-masonry' => '{"percentPosition": true}'
        ]
    ],
    'defaultShowTitleAndDescription' => true,
    'lightboxEnabled' => false,
    'lightboxClass' => 'lightbox'
];

$config = MFragmentHelper::mergeConfig($defaultConfig, $config);
$imageElements = [];

foreach ($images as $image) {
    if (!isset($image['media']) || !$image['media'] instanceof rex_media) {
        continue;
    }

    $showTitleAndDescription = $image['showTitleAndDescription'] ?? $config['defaultShowTitleAndDescription'];

    $figure = [
        'media' => $image['media'],
        'alt' => $image['customTitle'] ?? $image['media']->getTitle(),
        'config' => [
            'figure' => $config['figure'],
            'media' => array_merge($config['media'], [
                'mediaManagerType' => $config['media']['mediaManagerType']
            ]),
            'caption' => $config['caption']
        ]
    ];

    if ($showTitleAndDescription) {
        $figure['caption'] = [
            'title' => $image['customTitle'] ?? $image['media']->getTitle(),
            'description' => $image['customDescription'] ?? $image['media']->getValue('med_description'),
            'author' => $image['customAuthor'] ?? $image['media']->getValue('med_author'),
            'copyright' => $image['customCopyright'] ?? $image['media']->getValue('med_copyright')
        ];
    }

    if (isset($image['linkOption'])) {
        if ($image['linkOption'] === '2' && $config['lightboxEnabled']) {
            $figure['config']['lightbox'] = true;
            $figure['config']['lightboxClass'] = $config['lightboxClass'];
        } elseif ($image['linkOption'] === '3' && !empty($image['link']) && isset($image['link']['id'])) {
            $figure['config']['link'] = $image['link']['id'];
        }
    }

    $imageElements[] = MFragmentHelper::createTag(
        $config['wrapper']['tag'],
        MFragmentHelper::createFragment('default/figure', $figure),
        ['attributes' => $config['wrapper']['attributes']]
    );
}

$processor = new MFragmentProcessor();
echo $processor->process(
    MFragmentHelper::createTag(
        $config['container']['tag'],
        $imageElements,
        ['attributes' => $config['container']['attributes']]
    )
);
