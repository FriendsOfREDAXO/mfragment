<?php
/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 * https://www.w3.org/TR/html5/sections.html#the-figure-element
 * https://developer.mozilla.org/en-US/docs/Web/HTML/Element/figure
 */

echo $this->getSubfragment("default/tag.php", [
    'tag' => 'quote',
    'template' => '<blockquote %s>%s</blockquote>',
]);
