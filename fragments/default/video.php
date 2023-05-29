<?php
/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 */

use MFragment\DTO\MediaElement;
use MFragment\FragmentOutputHelper;
use MFragment\FragmentVarHelper;
use MFragment\MediaOutputHelper;

$tagName = $this->getVar('tag', 'video');
$tagTemplate = $this->getVar('template', '<video %s>%s</video>');
$tagHelp = $this->getVar($tagName . 'Help', []);

// merge help info array
$help = FragmentVarHelper::mergeHelp([
    'info'          => "this $tagName fragment will be generate a default html $tagName element",
    'media'         => "rex_media which will output as an $tagName source element (rex_media|string|MFragment\DTOMedia\Element|array)",
    $tagName . 'Output'   => "rex_media which will output as an $tagName source element (rex_media|string|MFragment\DTOMedia\Element|array)",
    'noSupportOutput'     => 'no support HTML output (string)',
    'config'        => [
        'attributes'   => "attributes of the $tagName element (array<key,value>)",
        'template'     => "individual template for the video element \"$tagTemplate\" (string)",
        'help'         => 'to show help information (boolean)',
        'debug'        => 'to view the debug information (boolean)',
    ],
    'mediaConfig'   => 'will be setup the configuration for media element fragment (array)',
], $tagHelp, false);

// read variables
$var = [
    'media'         => $this->getVar('media'),
    $tagName . 'Output'   => $this->getVar($tagName . 'Output', ''),
    'noSupportOutput'     => $this->getVar('noSupportOutput', ''),
    'config'        => $this->getVar('config', []),
    'mediaConfig'   => $this->getVar('mediaConfig'),
];

// set default config
$var['config'] = FragmentVarHelper::mergeDefaultConfigVariables($this->getVar($tagName . 'Config', ['template' => $tagTemplate]), $var['config']);

// display help
FragmentOutputHelper::viewHelp($this, $help);

$mediaOutput = $var[$tagName . 'Output'];
$noSupportOutput = $var['noSupportOutput'];
$attributes = '';

if (empty($mediaOutput)) {
    // create media element
    if (!is_null($var['media']) && is_array($var['media'] = FragmentVarHelper::getMediaElementArray($var['media'], [])) && count($var['media']) > 0) {
        foreach ($var['media'] as $mediaElement) {
            if ($mediaElement instanceof MediaElement) {
                $fragment = new rex_fragment([
                    'tag' => 'source',
                    'source' => 'src="' . MediaOutputHelper::getMediaUrlPath($mediaElement->rexMedia) . '"',
                    'config' => $mediaElement->mediaConfig,
                ]);
                $mediaOutput .= $fragment->parse("default/source.php");
            } else {
                if ((isset($fragment->debug) && $fragment->debug === true) || (isset($var['config']['debug']) && $var['config']['debug'] === true)) {
                    rex_logger::factory()->debug("\"" . var_dump($mediaElement) . "\" is not instanceof MediaElement");
                }
            }
        }
    }
}

// parse attributes to string
$attributes = FragmentOutputHelper::parseAttributesToString($var['config']['attributes']);

// create output
$output = sprintf($var['config']['template'], $attributes, $mediaOutput . $noSupportOutput);

// display debug outputs
FragmentOutputHelper::viewDebug($this, $var, [
    'attributes'        => $attributes,
    'mediaOutput'       => $mediaOutput,
    'noSupportOutput'   => $noSupportOutput,
    'output'            => $output,
]);

// print output
echo $output;
