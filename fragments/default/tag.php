<?php
/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 */

use FriendsOfRedaxo\MFragment\Helper\FragmentOutputHelper;
use FriendsOfRedaxo\MFragment\Helper\FragmentVarHelper;

$tagName = $this->getVar('tag');
$tagTemplate = $this->getVar('template');
$tagHelp = $this->getVar($tagName . 'Help', []);

// overwrite config by tagNameConfig
if (!is_null($config = $this->getVar($tagName . 'Config')) && is_array($config) && count($config) > 0) {
    $this->setVar('config', $config, false);
}

// merge help info array
$help = FragmentVarHelper::mergeHelp([
    'help' => "this $tagName fragment will be generate a default html $tagName element",
    $tagName => "$tagName to display (string)",
    'prefix' => 'custom output before element',
    'suffix' => 'custom output after element',
    'config' => [
        'attributes' => "attributes of the $tagName element [key=>value] (array)",
        'template' => "individual template for the $tagName element \"$tagTemplate\" you can use 2 placeholders the first for attributes and the second for $tagName content (string)",
        'help' => 'to show help information (boolean)',
        'debug' => 'to view the debug information (boolean)',
    ]
], $tagHelp);

// read variables
$var = [
    $tagName => $this->getVar($tagName),
    'config' => $this->getVar('config', []),
];

// set default config
$var['config'] = FragmentVarHelper::mergeDefaultConfigVariables([
    'template' => $tagTemplate,
    'attributes' => [],
], $var['config']);

// display help
FragmentOutputHelper::viewHelp($this, $help);

// parse attributes to string
$attributes = FragmentOutputHelper::parseAttributesToString($var['config']['attributes']);

// parse fragment output
$output = ($config['prefix'] ?? '') . sprintf($var['config']['template'], $attributes, $var[$tagName]) . ($config['suffix'] ?? '');

// display debug outputs
FragmentOutputHelper::viewDebug($this, $var, [
    'attributes' => $attributes,
    'output' => $output,
]);

// show output result
echo $output;
