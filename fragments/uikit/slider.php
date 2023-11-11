<?php
/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 */

use MFragment\Helper\FragmentOutputHelper;
use MFragment\Helper\FragmentVarHelper;

// display help
FragmentOutputHelper::viewHelp($this, [
    'info' => 'uikit slider fragment',
    'items' => '',
    'config' => [
        'attributes' => 'attributes of the figure element (array<key,value>)',
        'format' => '[list|div]',
        'help' => 'to show help information (boolean)',
        'debug' => 'to view the debug information (boolean)',
    ]
]);

$uniqueId = uniqid(rand(1000, 9999));

// read variables
$var = [
    'slides' => $this->getVar('items', [])
];

// set default config
$var['config'] = FragmentVarHelper::mergeDefaultConfigVariables([
    'attributes' => [],
    'format' => 'list'
], $this->getVar('config', []));

// PREPARE SETTINGS

// SLIDE LOOP
if ($var['config']['slider']['uk-slider']['finite'] === 'true') {
    unset($var['config']['slider']['uk-slider']['finite']);
} else {
    $var['config']['slider']['uk-slider']['finite'] = 'true';
}

// PARALLAX
$containerStyle = $parallax = $sticky = '';
if (rex::isFrontend() && isset($var['config']['section']['uk-parallax']) && is_array($var['config']['section']['uk-parallax']) && count($var['config']['section']['uk-parallax']) > 0) {
    $items = [];
    foreach ($var['config']['section']['uk-parallax'] as $key => $val) {
        if ($var['config']['section']['parallax-sticky'] == "true") {
            if ($key == 'start' || $key == 'end') continue;
            if ($key == 'y') $val = ((int) $val) * -1;
        }
        if (!empty($val)) $items[] = "$key:$val";
    }

    $parallax = ' uk-parallax="' . implode("; ", $items) . '"';
    $var['config']['section']['class']['uk-overflow-hidden'] = 'uk-overflow-hidden';

    if ($var['config']['section']['parallax-sticky'] == "true") {
        $var['config']['section']['class']['uk-position-z-index-negative'] = 'uk-position-z-index-negative';
        $parallax = ' uk-parallax="target: !.uk-section-'.$uniqueId.' +* +*; end:100%; ' . implode("; ", $items) . '"';
        $sticky = ' uk-sticky="overflow-flip: true; end: 100%"';
    }
}

// VIEWPORT HEIGHT
$viewportHeight = '';
if (rex::isFrontend() && $var['config']['slider']['fullHeight'] === '1') {
    if (!empty($parallax)) {
        $var['config']['slider']['uk-height-viewport']['offset-bottom'] = '-' . ($var['config']['section']['parallax-offset'] / 2) . 'px';
    }
    $viewportHeight = ' uk-height-viewport="' . str_replace(['=', '%3A'], [':', ': '], http_build_query(array_filter($var['config']['slider']['uk-height-viewport']), null, '; ')) . '"';
    unset($var['config']['slider']['uk-slider']['ratio']);
}

// RENDER OUTPUTS
$slides = $this->getSubfragment("uikit/slide.items.php", $var);
$arrows = ($var['config']['slider']['showArrows'] === 'true') ? MFragment::parseUiKit('slidenav', []) : '';
$navigation = ($var['config']['slider']['showDotNavigation'] === 'true') ? MFragment::parseUiKit('dotnav', ['count' => count($var['slides'])]) : '';

$output = '
<section class="uk-section-' . $uniqueId . ' ' . implode(' ', $var['config']['section']['class']) . '"' . $sticky . '>
    <div class="' . implode(' ', $var['config']['container']['class']) . '">
        <div class="uk-position-relative uk-visible-toggle uk-light" uk-slider="' . str_replace(['=', '%3A'], [':', ': '], http_build_query(array_filter($var['config']['slider']['uk-slider']), null, '; ')) . '"' . $parallax . '>
            <' . (($var['config']['format'] == 'list') ? 'ul' : 'div') . ' class="uk-slider-items"' . $viewportHeight . '>
                ' . $slides . '
            </' . (($var['config']['format'] == 'list') ? 'ul' : 'div') . '>
            ' . $arrows . $navigation . '
        </div>
    </div>
</section>
';

// display debug outputs
FragmentOutputHelper::viewDebug($this, $var, [
//    'attributes'    => $attributes,
    'output' => $output,
]);

echo $output;