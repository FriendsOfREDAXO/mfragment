<?php
/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 */

use FriendsOfRedaxo\MFragment\Helper\MFragmentHelper;
use FriendsOfRedaxo\MFragment\Core\MFragmentProcessor;

$items = $this->getVar('content', []);
$config = $this->getVar('config', []);

$accordionAttributes = $this->getVar('attributes', []);

$defaultConfig = [
    'accordion' => [
        'attributes' => MFragmentHelper::mergeConfig(['class' => ['default' => 'accordion']], $accordionAttributes),
    ],
    'item' => [
        'attributes' => ['class' => ['default' => 'accordion-item']],
    ],
    'header' => [
        'tag' => 'h2',
        'attributes' => ['class' => ['default' => 'accordion-header']],
    ],
    'button' => [
        'attributes' => ['class' => ['default' => 'accordion-button', 'bold' => 'fw-bold']],
    ],
    'collapse' => [
        'attributes' => ['class' => ['default' => 'accordion-collapse', 'collapse' => 'collapse']],
    ],
    'body' => [
        'attributes' => ['class' => ['default' => 'accordion-body']],
    ],
];

$config = MFragmentHelper::mergeConfig($defaultConfig, $config);

$uniqueKey = uniqid('accordion_');
$accordionItems = [];

foreach ($items as $key => $item) {
    $itemKey = $uniqueKey . '_' . $key;
    $isExpanded = $item['show'] ?? false;

    $headerTag = $item['config']['header']['tag'] ?? $config['header']['tag'];

    $headerConfig = MFragmentHelper::mergeConfig($config['header'], $item['config']['header'] ?? []);
    $headerAttributes = array_merge($headerConfig['attributes'], [
        'id' => "heading-{$itemKey}"
    ]);

    $buttonConfig = MFragmentHelper::mergeConfig($config['button'], $item['config']['button'] ?? []);
    $buttonAttributes = array_merge($buttonConfig['attributes'], [
        'type' => 'button',
        'data-bs-toggle' => 'collapse',
        'data-bs-target' => "#collapse-{$itemKey}",
        'aria-expanded' => $isExpanded ? 'true' : 'false',
        'aria-controls' => "collapse-{$itemKey}"
    ]);
    if (!$isExpanded) {
        $buttonAttributes['class'][] = 'collapsed';
    }

    $collapseConfig = MFragmentHelper::mergeConfig($config['collapse'], $item['config']['collapse'] ?? []);
    $collapseAttributes = array_merge($collapseConfig['attributes'], [
        'id' => "collapse-{$itemKey}",
        'aria-labelledby' => "heading-{$itemKey}",
        'data-bs-parent' => "#{$uniqueKey}"
    ]);
    if ($isExpanded) {
        $collapseAttributes['class'][] = 'show';
    }

    $bodyConfig = MFragmentHelper::mergeConfig($config['body'], $item['config']['body'] ?? []);

    $accordionItems[] = MFragmentHelper::createTag('div', [
        MFragmentHelper::createTag($headerTag,
            MFragmentHelper::createTag('button', $item['header'], ['attributes' => $buttonAttributes]),
            ['attributes' => $headerAttributes]
        ),
        MFragmentHelper::createTag('div',
            MFragmentHelper::createTag('div', $item['content'], ['attributes' => $bodyConfig['attributes']]),
            ['attributes' => $collapseAttributes]
        )
    ], ['attributes' => $config['item']['attributes']]);
}

if (count($accordionItems) > 0) {

    $accordionStructure = MFragmentHelper::createTag('div', $accordionItems, [
        'attributes' => array_merge($config['accordion']['attributes'], [
            'id' => $uniqueKey,
        ])
    ]);

    $processor = new MFragmentProcessor();
    echo $processor->process($accordionStructure);
}