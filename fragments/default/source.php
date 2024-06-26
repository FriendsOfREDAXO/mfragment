<?php
/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 * https://www.w3.org/TR/html5/embedded-content-0.html#the-img-element
 * https://developer.mozilla.org/en-US/docs/Web/HTML/Element/source
 */

use FriendsOfRedaxo\MFragment\Helper\FragmentVarHelper;

$tagName = $this->getVar('tag', 'source');
$tagTemplate = $this->getVar('template', '<source %s %s>');
$tagHelp = $this->getVar($tagName . 'Help', []);

$help = FragmentVarHelper::mergeHelp([
    $tagName => "rex_media img which will output as an $tagName html element (rex_media|string)",
    'src' => 'source url will be use primary in case of not empty (string)',
    'config' => [
        'attributes' => "attributes of the $tagName element (array<key,value>)",
        'template' => "individual template for the figure element \"<$tagName %s%s>\" (string)",
        'showAsDataSrc' => "option to display the $tagName rex_mediaType as data-src or data-srcset depending on (bool)",
        'addInfoData' => '(boolean)',
        'help' => 'to show help information (boolean)',
        'debug' => 'to view the debug information (boolean)',
    ],
], $tagHelp, false);

// set default config
$config = FragmentVarHelper::mergeDefaultConfigVariables($this->getVar($tagName . 'Config', []), $this->getVar('config', []));

echo $this->getSubfragment("default/tag.php", [
    'tag' => $tagName,
    $tagName . 'Help' => $help,
    'template' => $tagTemplate,
    $tagName . 'Config' => $config
]);
