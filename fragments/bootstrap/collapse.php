<?php
# path: src/addons/mfragment/fragments/bootstrap/accordion.php

/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 */

use FriendsOfRedaxo\MFragment\Helper\MFragmentHelper;
use FriendsOfRedaxo\MFragment\Core\RenderEngine;

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
    'button' => [
        'attributes' => ['class' => ['default' => 'accordion-header']],
    ],
    'headerText' => [
        'tag' => 'h4',
        'attributes' => ['class' => ['default' => 'accordion-header-text lh-140']],
    ],
    'headerToggle' => [
        'attributes' => ['class' => ['default' => 'accordion-header-toggle']],
    ],
    'collapseItem' => [
        'attributes' => ['class' => ['default' => 'accordion-collapse collapse']],
    ],
    'body' => [
        'attributes' => ['class' => ['default' => 'accordion-body']],
    ],
    'icon' => false,
];

$config = MFragmentHelper::mergeConfig($defaultConfig, $config);

$uniqueKey = uniqid('accordion_');
$accordionItems = [];

foreach ($items as $key => $item) {
    // Prüfen ob Content vorhanden ist oder ein hasContent-Flag gesetzt wurde
    $hasContent = !empty($item['content']) || (isset($item['hasContent']) && $item['hasContent'] === true);

    // Wenn kein Content vorhanden ist, Item als statisches Element ohne Collapse-Funktionalität darstellen
    if (!$hasContent) {
        $itemConfig = MFragmentHelper::mergeConfig($config['item'], $item['config']['item'] ?? []);

        // Headertext Konfiguration für statischen Header
        $headerTextTag = $item['config']['headerText']['tag'] ?? $config['headerText']['tag'];
        $headerTextConfig = MFragmentHelper::mergeConfig($config['headerText'], $item['config']['headerText'] ?? []);

        // Statisches Header-Element erstellen
        $staticHeaderContent = MFragmentHelper::createTag($headerTextTag, $item['header'], ['attributes' => $headerTextConfig['attributes']]);

        // Statisches Item nur mit Header erstellen
        // Füge data-accordion-item Attribut hinzu, auch für statische Items
        $itemConfig['attributes']['data-accordion-item'] = $item['id'] ?? "static-{$key}";
        
        $accordionItems[] = MFragmentHelper::createTag('div', [
            MFragmentHelper::createTag('div', $staticHeaderContent, ['attributes' => ['class' => 'static-accordion-header']])
        ], ['attributes' => $itemConfig['attributes']]);

        continue;
    }

    $itemKey = $uniqueKey . '_' . $key;
    $isExpanded = $item['show'] ?? false;

    $buttonConfig = MFragmentHelper::mergeConfig($config['button'], $item['config']['button'] ?? []);
    $buttonAttributes = array_merge($buttonConfig['attributes'], [
        'type' => 'button',
        'data-bs-toggle' => 'collapse',
        'data-bs-target' => "#collapse-{$itemKey}",
        'aria-expanded' => $isExpanded ? 'true' : 'false',
    ]);

    if (!$isExpanded) {
        $buttonAttributes['class'][] = 'collapsed';
    }

    // Header Text (mit optionalem Heading-Tag)
    $headerTextTag = $item['config']['headerText']['tag'] ?? $config['headerText']['tag'];
    $headerTextConfig = MFragmentHelper::mergeConfig($config['headerText'], $item['config']['headerText'] ?? []);
    $headerText = MFragmentHelper::createTag($headerTextTag, $item['header'], ['attributes' => $headerTextConfig['attributes']]);

    // Header Toggle mit Icon
    $headerToggleConfig = MFragmentHelper::mergeConfig($config['headerToggle'], $item['config']['headerToggle'] ?? []);
    $iconHtml = '';
    if ($item['config']['icon'] !== false) {
        $headerToggleConfig['attributes']['class'][] = 'accordion-header-toggle-icon';
        $iconHtml = $item['config']['icon']['html'] ?? $config['icon']['html'];
    }
    $headerToggle = MFragmentHelper::createTag('div',
        $iconHtml,
        ['attributes' => $headerToggleConfig['attributes']]
    );

    // Collapse Container
    $collapseConfig = MFragmentHelper::mergeConfig($config['collapseItem'], $item['config']['collapseItem'] ?? []);
    $collapseAttributes = array_merge($collapseConfig['attributes'], [
        'id' => "collapse-{$itemKey}",
    ]);

    if ($config['allowMultiple'] ?? false) {
        $collapseAttributes = array_merge($collapseAttributes, [
            'data-bs-parent' => "#{$uniqueKey}"
        ]);
    }

    if ($isExpanded) {
        $collapseAttributes['class'][] = 'show';
    }

    // Body
    $bodyConfig = MFragmentHelper::mergeConfig($config['body'], $item['config']['body'] ?? []);

    // Header Button mit Text und Toggle
    $accordionButton = MFragmentHelper::createTag('button',
        [$headerText, $headerToggle],
        ['attributes' => $buttonAttributes]
    );

    // Collapse mit Body
    $accordionCollapse = MFragmentHelper::createTag('div',
        MFragmentHelper::createTag('div', $item['content'], ['attributes' => $bodyConfig['attributes']]),
        ['attributes' => $collapseAttributes]
    );

    // Accordion Item mit data-accordion-item Attribut für Navigation
    $itemAttributes = $config['item']['attributes'];
    
    // Füge data-accordion-item Attribut hinzu, verwende die Item-ID
    $itemAttributes['data-accordion-item'] = $item['id'] ?? $itemKey;
    
    $accordionItems[] = MFragmentHelper::createTag('div',
        [$accordionButton, $accordionCollapse],
        ['attributes' => $itemAttributes]
    );
}

if (count($accordionItems) > 0) {
    $accordionStructure = MFragmentHelper::createTag('div', $accordionItems, [
        'attributes' => array_merge($config['accordion']['attributes'], [
            'id' => $uniqueKey,
        ])
    ]);

    // RenderEngine verwenden statt directe Processor-Instanz
    echo RenderEngine::render($accordionStructure);
}