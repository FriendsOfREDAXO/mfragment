<?php
/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 * https://developer.mozilla.org/en-US/docs/Web/HTML/Element/video
 */

use MFragment\DTO\MediaElement;
use MFragment\Helper\FragmentOutputHelper;
use MFragment\Helper\FragmentVarHelper;
use MFragment\Helper\MediaOutputHelper;

$tagName = $this->getVar('tag', 'video');
$tagTemplate = $this->getVar('template', '<video %s>%s</video>');
$tagHelp = $this->getVar($tagName . 'Help', []);

// merge help info array
$help = FragmentVarHelper::mergeHelp([
    'info'          => "this $tagName fragment will be generate a default html $tagName element",
    $tagName        => "rex_media which will output as an $tagName source element (rex_media|string|MFragment\DTOMedia\Element|array)",
    $tagName . 'Output'=> "rex_media which will output as an $tagName source element (rex_media|string|MFragment\DTOMedia\Element|array)",
    'appendOutput'     => 'append HTML output (string)',
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
    $tagName        => $this->getVar($tagName),
    $tagName . 'Output'   => $this->getVar($tagName . 'Output', ''),
    'appendOutput'  => $this->getVar('appendOutput', ''),
    'config'        => $this->getVar('config', []),
    'mediaConfig'   => $this->getVar('mediaConfig'),
];

// set default config
$var['config'] = FragmentVarHelper::mergeDefaultConfigVariables($this->getVar($tagName . 'Config', ['template' => $tagTemplate]), $var['config']);

// display help
FragmentOutputHelper::viewHelp($this, $help);

$mediaOutput = $var[$tagName . 'Output'];
$appendOutput = $var['appendOutput'];
$attributes = '';

//ob_start();echo '<pre>';
//print_r($var);die;


if (empty($mediaOutput)) {
    // create media element
    if (!is_null($var[$tagName]) && is_array($var[$tagName] = FragmentVarHelper::getMediaElementArray($var[$tagName], [])) && count($var[$tagName]) > 0) {
        $count = 0;
        foreach ($var[$tagName] as $mediaElement) {
            $count++;
            if ($mediaElement instanceof MediaElement) {
                $type = ($tagName === 'picture' && $count == (count($var[$tagName])+1)) ? 'img' : 'source';
                $fragment = new rex_fragment([
                    'tag' => $type,
                    $type => 'src="' . MediaOutputHelper::getMediaUrlPath($mediaElement->rexMedia) . '"',
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
$output = sprintf($var['config']['template'], $attributes, $mediaOutput . $appendOutput);

// display debug outputs
FragmentOutputHelper::viewDebug($this, $var, [
    'attributes'    => $attributes,
    'mediaOutput'   => $mediaOutput,
    'appendOutput'  => $appendOutput,
    'output'        => $output,
]);

// print output
echo $output;
