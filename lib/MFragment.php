<?php
class MFragment
{
    public static function parse(array $vars, string $filename): string
    {
        $fragment = new rex_fragment($vars);
        return $fragment->parse($filename);
    }
}