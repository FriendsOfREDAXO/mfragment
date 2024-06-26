<?php
/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 * https://www.w3.org/TR/html5/sections.html#the-figure-element
 * https://developer.mozilla.org/en-US/docs/Web/HTML/Element/figure
 */

use FriendsOfRedaxo\MFragment\DTO\MediaElement;
use FriendsOfRedaxo\MFragment\Helper\FragmentOutputHelper;
use FriendsOfRedaxo\MFragment\Helper\FragmentVarHelper;

$help = [
    'info'          => 'this figure fragment will be generate a default html figure element',
    'media'         => 'rex_media which will output as an media figure element (rex_media|string|MFragment\DTOMedia\Element|array)',
    'quote'         => 'some text to display as a blockquote figure element (string)',
    'figureOutput'  => 'this output string will be used primary for output (string)',
    'figcaption'    => 'figcaption text to display as description (string)',
    'config'        => [
        'attributes'            => 'attributes of the figure element (array<key,value>)',
        'template'              => 'individual template for the figure element "<figure %s>%s%s</figure>" (string)',
        'figCaptionFirst'       => 'in case of true the figcaption will display before (boolean)',
        'mediaTitleIsCaption'   => 'use the media title as default caption content (boolean)',
        'help'                  => 'to show help information (boolean)',
        'debug'                 => 'to view the debug information (boolean)',
    ],
    'mediaConfig'       => 'will be setup the configuration for media element fragment (array)',
    'quoteConfig'       => 'will be setup the configuration for quote element fragment (array)',
    'figcaptionConfig'  => 'will be setup the configuration for the figcaption element fragment (array)',
];

// read variables
$var = [
    'media'             => $this->getVar('media'),
    'quote'             => $this->getVar('quote'),
    'element'           => $this->getVar('element'),
    'figureOutput'      => $this->getVar('figureOutput', ''),
    'figcaption'        => $this->getVar('figcaption'),
    'config'            => $this->getVar('config', []),
    'mediaConfig'       => $this->getVar('mediaConfig'),
    'quoteConfig'       => $this->getVar('quoteConfig'),
    'figcaptionConfig'  => $this->getVar('figcaptionConfig'),
];

// set default config
$var['config'] = FragmentVarHelper::mergeDefaultConfigVariables([
    'template'              => '<figure %s>%s%s</figure>',
    'mediaTitleIsCaption'   => false,
    'attributes'            => []
], $var['config']);

// display help
FragmentOutputHelper::viewHelp($this, $help);

$figureOutput = $var['figureOutput'];
$attributes = '';
$figcaption = '';

if (empty($figureOutput)) {
// create media figure element
    if (!is_null($var['media']) && is_array($var['media'] = FragmentVarHelper::getMediaElementArray($var['media'], $var['mediaConfig'])) && count($var['media']) > 0) {
        /** @var MediaElement $mediaElement */
        foreach ($var['media'] as $mediaElement) {
            if ($mediaElement instanceof MediaElement) {
                $fragment = new rex_fragment([
                    'tag' => $mediaElement->mediaType,
                    'media' => $mediaElement,
                    'config' => $mediaElement->mediaConfig,
                ]);
                $figureOutput .= $fragment->parse("default/$mediaElement->mediaType.php");
            } else {
                if ((isset($fragment->debug) && $fragment->debug === true) || (isset($config['debug']) && $config['debug'] === true)) {
                    rex_logger::factory()->debug("\"" . var_dump($mediaElement) . "\" is not instanceof MediaElement");
                }
            }
        }
        // get title from latest media element for figcaption content
        if ($mediaElement instanceof MediaElement && (!empty($mediaElement->title) && empty($var['figcaption'])) && $var['config']['mediaTitleIsCaption']) {
            $var['figcaption'] = $mediaElement->title;
        }
    // create quote figure element
    } else if (!empty($var['quote'])) {
        $figureOutput = $this->getSubfragment("default/quote.php");
    }
}

// parse attributes to string
$attributes = FragmentOutputHelper::parseAttributesToString($var['config']['attributes']);

// create figcaption element
if (!empty($var['figcaption'])) $figcaption = $this->getSubfragment("default/figcaption.php");

// create output
if (isset($var['config']['figCaptionFirst']) && $var['config']['figCaptionFirst'] === true) {
    $output = sprintf($var['config']['template'], $attributes, $figcaption, $figureOutput);
} else {
    $output = sprintf($var['config']['template'], $attributes, $figureOutput, $figcaption);
}

// display debug outputs
FragmentOutputHelper::viewDebug($this, $var, [
    'attributes'    => $attributes,
    'figureOutput'  => $figureOutput,
    'figcaption'    => $figcaption,
    'output'        => $output,
]);

// print output
echo $output;
