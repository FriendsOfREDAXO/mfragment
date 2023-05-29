<?php
/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 * https://www.w3.org/TR/html5/embedded-content-0.html#the-img-element
 */

use MFragment\DTO\MediaElement;
use MFragment\FragmentVarHelper;
use MFragment\MediaOutputHelper;

$help = [
    'config' => [
        'alt' => 'alt attribute text (string)',
        'mediaManagerType' => 'rex_media_type as url or query parameter for images (string)',
        // 'decodeBase64' => 'decode img to a base64 string (boolean)',
        // 'writeSvg' => 'read and print svg content instead of putting a img (boolean)',
        'titleIsAltAttr' => 'use the media title as img alt attribute (boolean)',
        'showAltAttribute' => 'option to print out the image alt attribute (bool)',
    ]
];

// set default config
$config = FragmentVarHelper::mergeDefaultConfigVariables([
    'titleIsAltAttr' => true,
    'showAltAttribute' => true,
    'attributes' => [],
], $this->getVar('config', []));

/** @var null|rex_media $rexMedia */
$rexMedia = null;
$src = '';
/** @var MediaElement|rex_media|string $media */
$media = $this->getVar('img', $this->getVar('media'));

if (is_string($media)) {
    $rexMedia = FragmentVarHelper::getRexMedia($media);
}
if ($media instanceof MediaElement) {
    $rexMedia = $media->rexMedia;
    $config = FragmentVarHelper::mergeDefaultConfigVariables($config, $media->mediaConfig);
}

if (!is_null($rexMedia)) {
    // alt attribute
    if ((isset($config['showAltAttribute']) && $config['showAltAttribute'])) {
        if ((isset($config['titleIsAltAttr']) && $config['titleIsAltAttr'] === true)
            && (!empty($rexMedia->getTitle()) && empty($config['alt']))) {
            $config['attributes']['alt'] = $rexMedia->getTitle();
        }
    }
    if (!$config['showAltAttribute']) {
        unset($config['attributes']['alt']);
    }
    $src = MediaOutputHelper::getManagedMediaFile($rexMedia->getFileName(), $config['mediaType'], (bool) $config['showAsDataSrc']);
}

echo $this->getSubfragment("default/source.php", [
    'tag' => 'img',
    'img' => $src,
    'template' => '<img %s %s>',
    'imgConfig' => $config,
    'imgHelp' => $help,
]);
