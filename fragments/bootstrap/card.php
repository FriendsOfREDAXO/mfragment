<?php
/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 */

use FriendsOfRedaxo\MFragment\Core\MFragmentProcessor;
use FriendsOfRedaxo\MFragment\Helper\MFragmentHelper;

$config = $this->getVar('config', []);
$content = $this->getVar('content', []);

$cardConfig = $config['card'] ?? [];
$cardAttributes = $cardConfig['attributes'] ?? [];

// Default Bootstrap card classes
$cardAttributes = array_merge([
    'class' => ['card'],
], $cardAttributes);

$cardContent = [];

$defaultConfig = [
    'header' => [
        'tag' => 'div',
        'attributes' => ['class' => ['default' => 'card-header', 'border' => 'border-solid']]
    ],
    'body' => [
        'tag' => 'div',
        'attributes' => ['class' => ['default' => 'card-body']]
    ],
    'footer' => [
        'tag' => 'div',
        'attributes' => ['class' => ['default' => 'card-footer']]
    ]
];

if (is_array($content)) {
    foreach ($content as $key => $partData) {
        if (is_array($partData)) {
            $defaultPart = $defaultConfig[$key] ?? [];
            $partTag = $partData['tag'] ?? $defaultPart['tag'] ?? 'div';

            $attributes = MFragmentHelper::mergeConfig($defaultPart['attributes'] ?? [], $partData['attributes'] ?? []);

            if (!empty($partData['content'])) {
                $cardContent[] = MFragmentHelper::createTag($partTag, $partData['content'], ['attributes' => $attributes]);
            }
        }
    }
} else if (is_string($content)) {
    $cardContent = $content;
}

$cardStructure = MFragmentHelper::createTag('div', $cardContent, ['attributes' => $cardAttributes]);

$processor = new MFragmentProcessor();
echo $processor->process($cardStructure);
