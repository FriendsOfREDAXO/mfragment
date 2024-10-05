<?php
/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 */

use FriendsOfRedaxo\MFragment\Core\MFragmentProcessor;

$config = $this->getVar('config', []);
$columns = $this->getVar('columns', []);

$defaultConfig = [
    'tag' => 'div',
    'attributes' => ['class' => ['default' => 'row']],
];

$config = array_replace_recursive($defaultConfig, $config);

$columnElements = [];

foreach ($columns as $column) {
    $columnConfig = $column['config'] ?? [];
    $columnContent = $column['content'] ?? '';

    $defaultColumnConfig = [
        'tag' => 'div',
        'attributes' => ['class' => ['default' => 'col']],
    ];

    $columnConfig = array_replace_recursive($defaultColumnConfig, $columnConfig);

    // Ensure 'class' is always an array
    if (!isset($columnConfig['attributes']['class'])) {
        $columnConfig['attributes']['class'] = ['col'];
    } elseif (is_string($columnConfig['attributes']['class'])) {
        $columnConfig['attributes']['class'] = explode(' ', $columnConfig['attributes']['class']);
    }

    $columnElements[] = [
        'tag' => $columnConfig['tag'],
        'attributes' => $columnConfig['attributes'],
        'content' => $columnContent
    ];
}

$output = [
    'tag' => $config['tag'],
    'attributes' => $config['attributes'],
    'content' => $columnElements
];

$processor = new MFragmentProcessor();
echo $processor->process($output);
