<?php
/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 */

echo $this->getSubfragment("default/video.php", [
    'tag' => 'audio',
    'template' => '<audio %s>%s</audio>',
]);
