<?php
/**
 * @author Joachim Doerr
 * @package redaxo5
 * @license MIT
 */

namespace FriendsOfRedaxo;

use FriendsOfRedaxo\MFragment\Core\MFragmentProcessor;
use FriendsOfRedaxo\MFragment\MFragmentElements;
use rex_factory_trait;
use rex_fragment;

class MFragment extends MFragmentElements
{
    use rex_factory_trait;

    private bool $debug;

    public static function factory(): MFragment
    {
        $class = static::getFactoryClass();
        return new $class();
    }

    public function setDebug(bool $debug): MFragment
    {
        $this->debug = $debug;
        return $this;
    }

    public function show(): string
    {
        $processor = new MFragmentProcessor();
        return $processor->process($this);
    }

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
     * @description Parse content using ContentProcessor
     */
    public static function process($content): string
    {
        $processor = new MFragmentProcessor();
        return $processor->process($content);
    }
}