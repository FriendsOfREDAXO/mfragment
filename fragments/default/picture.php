<?php
/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 * https://developer.mozilla.org/en-US/docs/Web/HTML/Element/picture
 */

/*
<picture>
   <source media="(min-width: 80em)" srcset="Blume-1200.jpg">
   <source media="(min-width: 60em)" srcset="Blume-600.jpg">
   <!---Fallback--->
   <img src="Blume-400.jpg" alt="wilde Blume vor einem Gebirgssee">
</picture>
 */

echo $this->getSubfragment("default/tag.php", [
    'tag' => 'picture',
    'picture' => 'list of source and fallback img',
    'template' => '<picture %s>%s</picture>',
]);
