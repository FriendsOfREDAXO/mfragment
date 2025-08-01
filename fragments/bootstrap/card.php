<?php
# path: src/addons/mfragment/fragments/bootstrap/card.php

/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 */

use FriendsOfRedaxo\MFragment;
use FriendsOfRedaxo\MFragment\Components\ComponentInterface;
use FriendsOfRedaxo\MFragment\Core\RenderEngine;
use FriendsOfRedaxo\MFragment\Helper\MFragmentHelper;

$config = $this->getVar('config', []);
$content = $this->getVar('content', []);

$cardConfig = $config['card'] ?? [];
$cardAttributes = isset($cardConfig['attributes']) ? $cardConfig['attributes'] : [];

// Default Bootstrap card classes
if (!isset($cardAttributes['class'])) {
    $cardAttributes['class'] = ['card'];
} elseif (is_string($cardAttributes['class'])) {
    $cardAttributes['class'] = array_merge(['card'], explode(' ', $cardAttributes['class']));
} elseif (is_array($cardAttributes['class'])) {
    $cardAttributes['class'] = array_merge(['card'], $cardAttributes['class']);
}

// Zusätzliche Klassen aus der Konfiguration hinzufügen
if (isset($config['class'])) {
    if (is_string($config['class'])) {
        $cardAttributes['class'][] = $config['class'];
    } elseif (is_array($config['class'])) {
        $cardAttributes['class'] = array_merge($cardAttributes['class'], $config['class']);
    }
}

$cardContent = [];

$defaultConfig = [
    'ribbon' => [
        'tag' => 'div',
        'attributes' => ['class' => ['default' => 'ribbon']]
    ],
    'header' => [
        'tag' => 'div',
        'attributes' => ['class' => ['default' => 'card-header']]
    ],
    'image' => [
        'tag' => 'div',
        'attributes' => ['class' => ['default' => 'card-image']]
    ],
    'body' => [
        'tag' => 'div',
        'attributes' => ['class' => ['default' => 'card-body']]
    ],
    'list' => [
        'tag' => 'div',
        'attributes' => ['class' => ['default' => 'card-list']]
    ],
    'footer' => [
        'tag' => 'div',
        'attributes' => ['class' => ['default' => 'card-footer']]
    ]
];

if (is_array($content)) {
    foreach ($content as $key => $partData) {
        if (!is_array($partData)) {
            continue;
        }

        $defaultPart = $defaultConfig[$key] ?? [];
        $partTag = $partData['tag'] ?? $defaultPart['tag'] ?? 'div';

        // Attribute vorbereiten
        $attributes = isset($defaultPart['attributes']) ? $defaultPart['attributes'] : [];
        if (isset($partData['attributes'])) {
            $attributes = MFragmentHelper::mergeConfig($attributes, $partData['attributes']);
        }

        // Nur hinzufügen, wenn Inhalt vorhanden ist
        if (isset($partData['content'])) {
            $partContent = $partData['content'];
            // Spezielle Behandlung für MFragment-Objekte
            if ($partContent instanceof ComponentInterface) {
                $cardContent[] = MFragmentHelper::createTag($partTag, $partContent->show(), ['attributes' => $attributes]);
            } else if ($partContent instanceof MFragment) {
                if (!$partContent->isEmpty()) {
                    $processedContent = RenderEngine::render($partContent);
                    $cardContent[] = MFragmentHelper::createTag($partTag, $processedContent, ['attributes' => $attributes]);
                }
            } else {
                $cardContent[] = MFragmentHelper::createTag($partTag, $partContent, ['attributes' => $attributes]);
            }
        }
    }
} else if (is_string($content)) {
    $cardContent = $content;
}

// Karte erzeugen
$cardStructure = MFragmentHelper::createTag('div', $cardContent, ['attributes' => $cardAttributes]);

// RenderEngine verwenden statt direkte Processor-Instanz
echo RenderEngine::render($cardStructure);