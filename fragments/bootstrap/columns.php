<?php
/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 */

use FriendsOfRedaxo\MFragment\Helper\MFragmentHelper;
use FriendsOfRedaxo\MFragment\Core\MFragmentProcessor;

$columns = $this->getVar('columns', []);
$config = $this->getVar('config', []);

$defaultConfig = [
    'wrapper' => [
        'tag' => 'div',
        'attributes' => ['class' => ['default' => 'row']]
    ],
    'column' => [
        'tag' => 'div',
        'attributes' => ['class' => ['default' => 'col']]
    ]
];

$config = MFragmentHelper::mergeConfig($defaultConfig, $config);

$columnElements = [];

foreach ($columns as $column) {
    $columnConfig = MFragmentHelper::mergeConfig($config['column'], $column['config'] ?? []);

    // Ensure 'class' is always an array
    if (!isset($columnConfig['attributes']['class'])) {
        $columnConfig['attributes']['class'] = ['col'];
    } elseif (is_string($columnConfig['attributes']['class'])) {
        $columnConfig['attributes']['class'] = explode(' ', $columnConfig['attributes']['class']);
    }

    // Add size class if specified
    if (isset($column['config']['size'])) {
        $columnConfig['attributes']['class'][] = 'col-' . $column['config']['size'];
    }

    $columnElements[] = MFragmentHelper::createTag(
        $columnConfig['tag'],
        $column['content'],
        ['attributes' => $columnConfig['attributes']]
    );
}

$output = MFragmentHelper::createTag(
    $config['wrapper']['tag'],
    $columnElements,
    ['attributes' => $config['wrapper']['attributes']]
);

$processor = new MFragmentProcessor();
echo $processor->process($output);