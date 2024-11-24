<?php
/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 */

use FriendsOfRedaxo\MFragment\Core\MFragmentProcessor;
use FriendsOfRedaxo\MFragment\Helper\MFragmentHelper;

$config = $this->getVar('config', []);
$content = $this->getVar('content', []);

$defaultConfig = [
    'section' => [
        'tag' => 'section',
        'attributes' => [
            'class' => [
                //'default' => 'section'
            ]
        ],
        'enabled' => true
    ],
    'container' => [
        'tag' => 'div',
        'attributes' => [
            'class' => [
                'default' => 'container'
            ]
        ],
        'enabled' => true
    ]
];

// Custom merge for nested configurations
$finalConfig = [];

// Process section configuration
$finalConfig['section'] = [
    'tag' => $config['section']['tag'] ?? $defaultConfig['section']['tag'],
    'enabled' => $config['section']['enabled'] ?? $defaultConfig['section']['enabled'],
    'attributes' => [
        'class' => array_merge(
            $defaultConfig['section']['attributes']['class'] ?? [],
            $config['section']['attributes']['class'] ?? []
        )
    ]
];

// Process container configuration
$finalConfig['container'] = [
    'tag' => $config['container']['tag'] ?? $defaultConfig['container']['tag'],
    'enabled' => $config['container']['enabled'] ?? $defaultConfig['container']['enabled'],
    'attributes' => [
        'class' => array_merge(
            $defaultConfig['container']['attributes']['class'] ?? [],
            $config['container']['attributes']['class'] ?? []
        )
    ]
];

// Add any additional attributes
if (isset($config['section']['attributes'])) {
    foreach ($config['section']['attributes'] as $key => $value) {
        if ($key !== 'class') {
            $finalConfig['section']['attributes'][$key] = $value;
        }
    }
}

if (isset($config['container']['attributes'])) {
    foreach ($config['container']['attributes'] as $key => $value) {
        if ($key !== 'class') {
            $finalConfig['container']['attributes'][$key] = $value;
        }
    }
}

$processedContent = $content;

// Process container if enabled
if ($finalConfig['container']['enabled']) {
    $processedContent = MFragmentHelper::createTag(
        $finalConfig['container']['tag'],
        $processedContent,
        ['attributes' => $finalConfig['container']['attributes']]
    );
}

// Process section if enabled
if ($finalConfig['section']['enabled']) {
    $processedContent = MFragmentHelper::createTag(
        $finalConfig['section']['tag'],
        $processedContent,
        ['attributes' => $finalConfig['section']['attributes']]
    );
}

$processor = new MFragmentProcessor();
echo $processor->process($processedContent);