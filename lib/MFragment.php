<?php
/**
 * @author Joachim Doerr
 * @package redaxo5
 * @license MIT
 */

namespace FriendsOfRedaxo;

use rex_fragment;

class MFragment
{
    /**
     * @description  filename can be with or without .php extension
     */
    public static function parse(string $filename, array $vars): string
    {
        $extension = pathinfo($filename, PATHINFO_EXTENSION);
        if ($extension == 'php') {
            $filename = substr($filename, 0, strlen($filename) - 4);
        }
        $fragment = new rex_fragment($vars);
        return $fragment->parse($filename . '.php');
    }

    /**
     * @description to parse html tags quickly
     */
    public static function parseHtml(string $tagName, string $content, array $vars): string
    {
        return MFragment::parse("default/tag", [
            'tag' => $tagName,
            $tagName => $content,
            'template' => "<$tagName %s>%s</$tagName>",
            $tagName . 'Config' => $vars
        ]);
    }
}