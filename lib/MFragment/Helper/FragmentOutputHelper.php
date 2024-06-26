<?php
/**
 * @author Joachim Doerr
 * @package redaxo5
 * @license MIT
 */

namespace FriendsOfRedaxo\MFragment\Helper;

use FriendsOfRedaxo\MFragment;
use rex_fragment;
use rex_string;

class FragmentOutputHelper
{
    public static function eachFragmentParts($fragmentParts, string $default = ''): string
    {
        $output = '';
        $fragmentParts = (is_array($fragmentParts)) ? array_filter($fragmentParts) : $fragmentParts;
        if (is_array($fragmentParts) && count($fragmentParts) > 0) {
            if (!empty($fragmentParts['fragment'])) {
                $output .= MFragment::parse($fragmentParts['fragment'], $fragmentParts);
            } else {
                foreach ($fragmentParts as $key => $fragmentPart) {
                    if (!empty($fragmentPart['fragment'])) {
                        $output .= MFragment::parse($fragmentPart['fragment'], $fragmentPart);
                    } else {
                        if (is_array($fragmentPart)) {
                            // tag
                            $tag = (!empty($fragmentPart['tag'])) ? $fragmentPart['tag'] : (($key === 'subHeadline') ? 'h6' : 'h5');
                            if ($key === 'lead') $tag = 'p';
                            // class
                            $class = (!empty($fragmentPart['class']) && is_array($fragmentPart['class'])) ? ' class="' . implode(' ', $fragmentPart['class']) . '"' : '';
                            // attributes
                            $attributes = (!empty($fragmentPart['attributes']) && is_array($fragmentPart['attributes'])) ? ' ' . rex_string::buildAttributes($fragmentPart['attributes']) : '';
                            // output
                            $output .= '<' . $tag . $class . $attributes . '>' . $fragmentPart['text'] . '</' . $tag . '>';
                        } else if (is_string($fragmentPart) && !empty($fragmentPart)) {
                            $output .= $fragmentPart;
                        }
                    }
                }
            }
        } else if (is_string($fragmentParts)) {
            $output = $fragmentParts;
        }
        if (empty($output)) {
            $output = $default;
        }
        return $output;
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
}