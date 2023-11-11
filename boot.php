<?php
/** @var rex_addon $this */

rex_extension::register('PACKAGES_INCLUDED', function () {
    // Register fragment folder
    rex_fragment::addDirectory(rex_path::addon('mfragment', 'fragments'));
}, rex_extension::LATE);

include_once rex_addon::get('mfragment')->getPath('fragment_defaults.php');
