<?php
/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 */


$count = $this->getVar('count', 0);

$items = [];
for ($x = 0; $x < $count; $x++) {
    $link = MFragment::parseHtml('a', '', [
        'attributes' => [
            'href' => '#',
            'title' => "Item $x"
        ]
    ]);
    $items[] = MFragment::parseHtml('li', $link, [
        'attributes' => [
            'uk-slideshow-item' => "$x"
        ]
    ]);
}

$itemsList = MFragment::parseHtml('ul', implode('', $items), [
    'attributes' => [
        'class' => 'uk-dotnav uk-flex-center uk-margin'
    ]
]);

$nav = MFragment::parseHtml('div', $itemsList, [
    'attributes' => [
        'class' => 'uk-position-bottom-center uk-position-small'
    ]
]);

echo $nav;