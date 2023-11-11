<?php
/**
 * @author Joachim Doerr
 * @package redaxo5
 * @license MIT
 */

namespace MFragment\Helper;

use rex_fragment;

class FragmentOutputHelper
{
    public static function viewHelp(rex_fragment $fragment, array $help = []): void
    {
        // get fragment config var
        $config = $fragment->getVar('config');

        // display help
        if (((isset($fragment->help) && $fragment->help === true) || (isset($config['help']) && $config['help'] === true)) && count($help) > 0) {
            dump($help);
        }
    }

    public static function viewDebug(rex_fragment $fragment, array $var = [], array $outputs = []): void
    {
        // get fragment config var
        $config = $fragment->getVar('config');

        // display var and output dump
        if ((isset($fragment->debug) && $fragment->debug === true) || (isset($config['debug']) && $config['debug'] === true)) {
            dump($var);
            dump($outputs);
        }
    }

    public static function parseAttributesToString(array $attributes = []): string
    {
        $output = [];
        if (count($attributes) > 0) {
            foreach ($attributes as $key => $value) {
                if (empty($value) && $value !== "0") {
                    continue;
                }
                if (is_array($value)) $value = implode(' ', $value);
                if (in_array($key, ['autoplay', 'controls', 'muted', 'playsinline']) && $value === true) {
                    $output[] = $key;
                } else if (is_int($key)) {
                    $output[] = $value;
                } else {
                    $output[] = $key . '="' . $value . '"';
                }
            }
        }
        return implode(' ', $output);
    }
}