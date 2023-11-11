<?php
/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 * https://developer.mozilla.org/en-US/docs/Web/HTML/Element/audio
 */

echo $this->getSubfragment("default/video.php", [
    'tag' => 'audio',
    'template' => '<audio %s>%s</audio>',
]);
