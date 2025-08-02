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
     * Optimierte Methode zum direkten Rendern von Komponenten
     *
     * @param string $componentName Name der Komponente
     * @param array $content Content-Array
     * @param array $config Config-Array
     * @param array $attributes Attribute-Array
     * @return string Gerenderter HTML-String
     */
    public static function render(string $componentName, array $content = [], array $config = [], array $attributes = []): string
    {
        return RenderEngine::renderWithData($componentName, $content, $config, $attributes);
    }

    /**
     * Shortcut für Bootstrap-Komponenten
     *
     * @param string $component Bootstrap-Komponenten-Name
     * @param array $content Content-Array
     * @param array $config Config-Array
     * @return string Gerenderter HTML-String
     */
    public static function bootstrap(string $component, array $content = [], array $config = []): string
    {
        return RenderEngine::renderBootstrap($component, $content, $config);
    }

    /**
     * Shortcut für Default-Komponenten
     *
     * @param string $component Default-Komponenten-Name
     * @param array $content Content-Array
     * @param array $config Config-Array
     * @return string Gerenderter HTML-String
     */
    public static function default(string $component, array $content = [], array $config = []): string
    {
        return RenderEngine::renderDefault($component, $content, $config);
    }

    /**
     * Gibt Performance-Statistiken der RenderEngine zurück
     *
     * @return array Performance-Statistiken
     */
    public static function getPerformanceStats(): array
    {
        return RenderEngine::getStats();
    }

    /**
     * Prüft ob FORHtml verfügbar ist
     *
     * @return bool True wenn FORHtml verfügbar ist
     */
    public static function isFORHtmlAvailable(): bool
    {
        try {
            return \rex_addon::get('forhtml')->isAvailable();
        } catch (\Exception $e) {
            return false;
        }
    }

    /**
     * HTML-Element mit FORHtml parsen (falls verfügbar), sonst nativer Fallback
     *
     * @param string $tag HTML-Tag
     * @param mixed $content Inhalt des Elements
     * @param array $config Konfiguration mit attributes
     * @return string Gerenderter HTML-String
     */
    public static function parseHtml(string $tag, $content = '', array $config = []): string
    {
        // Prüfen ob FORHtml Addon verfügbar und aktiviert ist
        try {
            if (\rex_addon::get('forhtml')->isAvailable()) {
                $generator = new \FriendsOfRedaxo\MFragment\Core\BaseHtmlGenerator();
                $element = $generator->element($tag);
                
                if ($content) {
                    $element->content($content);
                }
                
                if (isset($config['attributes']) && is_array($config['attributes'])) {
                    foreach ($config['attributes'] as $key => $value) {
                        $element->setAttribute($key, $value);
                    }
                }
                
                return (string) $element;
            }
        } catch (\Exception $e) {
            // Falls FORHtml Fehler wirft, Fallback verwenden
        }
        
        // Nativer HTML-Fallback ohne FORHtml-Abhängigkeit
        return self::parseHtmlFallback($tag, $content, $config);
    }

    /**
     * Nativer HTML-Parser Fallback ohne externe Abhängigkeiten
     *
     * @param string $tag HTML-Tag
     * @param mixed $content Inhalt des Elements
     * @param array $config Konfiguration mit attributes
     * @return string Gerenderter HTML-String
     */
    private static function parseHtmlFallback(string $tag, $content = '', array $config = []): string
    {
        $attributes = '';
        
        if (isset($config['attributes']) && is_array($config['attributes'])) {
            $attrPairs = [];
            foreach ($config['attributes'] as $key => $value) {
                if (is_array($value)) {
                    $value = implode(' ', $value);
                }
                $attrPairs[] = htmlspecialchars($key) . '="' . htmlspecialchars($value) . '"';
            }
            if (!empty($attrPairs)) {
                $attributes = ' ' . implode(' ', $attrPairs);
            }
        }
        
        // Selbstschließende Tags
        $voidElements = ['area', 'base', 'br', 'col', 'embed', 'hr', 'img', 'input', 'link', 'meta', 'param', 'source', 'track', 'wbr'];
        
        if (in_array(strtolower($tag), $voidElements)) {
            return "<{$tag}{$attributes}>";
        }
        
        return "<{$tag}{$attributes}>{$content}</{$tag}>";
    }
}