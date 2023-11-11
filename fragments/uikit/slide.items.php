<?php
/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 */

use MForm\Utils\MFormOutputHelper;
use MFragment\Helper\FragmentVarHelper;
use MFragment\Helper\MediaOutputHelper;

// read variables
$items = $this->getVar('items', null);

// set default config
$var['config'] = FragmentVarHelper::mergeDefaultConfigVariables([
    'attributes' => [],
    'format' => 'list'
], $this->getVar('config', []));

$slideItems = [];

foreach ($items as $item) {
    $mediaPrefix = $mediaSuffix = $media = $mediaSrc = $itemMedia = $link_prefix = $link_suffix = '';
    $link = MFormOutputHelper::prepareCustomLink(['link' => $item['1']]);

    if (isset($link['customlink_url'])) {
        $link_prefix = '<a href="' . $link['customlink_url'] . '">';
        $link_suffix = '</a>';
    }

    $item['bg_parallax'] = true;

    if (!empty($item['REX_MEDIA_1'])) {
        if (FragmentVarHelper::isMediaVideo($item['REX_MEDIA_1'])) {
            $media = MFragment::parseDefault('video', $item['REX_MEDIA_1'], ['config' => ['attributes' => ['uk-video', 'autoplay', 'loop', 'muted', 'playsinline', 'uk-cover', 'preload' => 'none', 'class' => 'uk-width-1-1']]]);
        } else if (FragmentVarHelper::isMediaImg($item['REX_MEDIA_1'])) {
            $media = MFragment::parseDefault('img', $item['REX_MEDIA_1'], ['config' => ['mediaManagerType' => 'slide_item', 'showAsDataSrc' => true, 'attributes' => ['uk-img' => 'loading: eager', 'uk-cover']], 'prefix' => '<div class="uk-position-cover uk-animation-kenburns">', 'suffix' => '</div>']);
            if ($item['bg_parallax'] == true && rex::isFrontend()) {
                $mediaSrc = MediaOutputHelper::getManagedMediaFile($item['REX_MEDIA_1'], 'slide_item', true);
                $media = '<div class="uk-position-cover uk-animation-kenburns"><div class="uk-height-1-1 uk-background-cover uk-light uk-flex" uk' . (($item['bg_slideshow_parallax'] == "true") ? '-slideshow' : '') . '-parallax="bgy: 100;" uk-img="loading: lazy" ' . $mediaSrc . '></div></div>';
            }
        }
    }

    $content = ($item['title'] !== '') ? '<h2 class="tt uk-text-bold" uk-slideshow-parallax="x: 200,0,200;">' . $item['title'] . '</h2>' : '';
    $content .= ($item['text'] !== '') ? '<p class="tt uk-text-lighter">' . $item['text'] . '</p>' : '';

    if (!empty($content)) {
        $content = '<div class="' . $item['posText'] . ' uk-position-medium uk-width-1-2 uk-padding-bottom uk-light" uk-scrollspy="target: > .tt ; cls: uk-animation-fade;">' . $content . '<br><br></div>';
    }

//    $slideItems[] = '<' . (($var['config']['format'] == 'list') ? 'li' : 'div') . $itemMedia . '>    '.$media.'
//            <div class="uk-container-large uk-align-center">
//                <div class="uk-card uk-card-default uk-position-medium">
//                    <div class="uk-card-body">
//                        <h3 class="uk-card-title">Headline</h3>
//                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.</p>
//                    </div>
//                </div>
//            </div>
//</' . (($var['config']['format'] == 'list') ? 'li' : 'div') . '>';


    $slideItems[] = '<' . (($var['config']['format'] == 'list') ? 'li' : 'div') . $itemMedia . '>' . $link_prefix . $media . $content . $link_suffix . '</' . (($var['config']['format'] == 'list') ? 'li' : 'div') . '>';
}

echo implode('', $slideItems);