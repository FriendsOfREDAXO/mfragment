<?php
/**
 * User: joachimdoerr
 * Date: 19.05.23
 * Time: 18:04
 */

namespace MFragment;

use rex_fragment;

class FragmentOutputHelper
{
    /**
     * @param rex_fragment $fragment
     * @param array $help
     * @author Joachim Doerr
     */
    public static function viewHelp(rex_fragment $fragment, array $help = []): void
    {
        // get fragment config var
        $config = $fragment->getVar('config');

        // display help
        if (((isset($fragment->help) && $fragment->help === true) || (isset($config['help']) && $config['help'] === true)) && count($help) > 0) {
            dump($help);
        }
    }

    /**
     * @param rex_fragment $fragment
     * @param array $var
     * @param array $outputs
     * @author Joachim Doerr
     */
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

    /**
     * @param array $attributes
     * @return string
     * @author Joachim Doerr
     */
    public static function parseAttributesToString(array $attributes = []): string
    {
        $output = [];
        $attributes = array_filter($attributes);
        if (count($attributes) > 0) {
            foreach ($attributes as $key => $value) {
                if (is_array($value)) $value = implode(' ', $value);
                if (in_array($key, ['autoplay', 'controls', 'muted', 'playsinline']) && $value === true) {
                    $output[] = $key;
                } else {
                    $output[] = $key . '="' . $value . '"';
                }
            }
        }
        return implode(' ', $output);
    }
}