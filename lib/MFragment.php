<?php

namespace FriendsOfRedaxo;

use FriendsOfRedaxo\MFragment\Core\MFragmentProcessor;
use FriendsOfRedaxo\MFragment\Core\RenderEngine;
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

    /**
     * Rendert das MFragment-Objekt mit der RenderEngine
     * Dies ist die einzige öffentliche Render-Methode - alle anderen sind deprecated
     *
     * @return string Gerenderter HTML-String
     */
    public function show(): string
    {
        // Debug-Informationen hinzufügen, wenn Debug aktiviert ist
        if (isset($this->debug) && $this->debug) {
            $debugInfo = RenderEngine::getDebugInfo();
            $content = RenderEngine::render($this);
            RenderEngine::resetStats();
            return $debugInfo . $content;
        }

        // Direktes Rendern mit RenderEngine
        return RenderEngine::render($this);
    }

    /**
     * Legacy Fragment-Parser (nur für Rückwärtskompatibilität)
     * @description filename can be with or without .php extension
     * @deprecated Verwende stattdessen show() mit Komponenten
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

}