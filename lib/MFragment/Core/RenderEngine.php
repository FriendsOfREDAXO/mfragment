<?php
# path: src/addons/mfragment/lib/MFragment/Core/RenderEngine.php
namespace FriendsOfRedaxo\MFragment\Core;

use FriendsOfRedaxo\MFragment;
use FriendsOfRedaxo\MFragment\Components\ComponentInterface;

/**
 * Singleton RenderEngine für zentrales Rendering
 * 
 * Diese Klasse ersetzt redundante MFragmentProcessor-Instanziierungen
 * und bietet einen einheitlichen Einstiegspunkt für alle Rendering-Prozesse.
 */
class RenderEngine
{
    /**
     * Singleton-Instanz
     */
    private static ?self $instance = null;
    
    /**
     * Der zentrale Processor
     */
    private MFragmentProcessor $processor;
    
    /**
     * Statistiken für Performance-Monitoring
     */
    private array $stats = [
        'renderCalls' => 0,
        'fragmentCalls' => 0,
        'processingTime' => 0,
        'memoryUsage' => 0
    ];
    
    /**
     * Private Konstruktor für Singleton
     */
    private function __construct()
    {
        $this->processor = new MFragmentProcessor();
    }
    
    /**
     * Gibt die Singleton-Instanz zurück
     */
    private static function getInstance(): self
    {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }
    
    /**
     * Hauptmethode zum Rendern von Content
     * 
     * @param mixed $content Zu rendernder Content (String, Component, MFragment, Array)
     * @return string Gerenderter HTML-String
     */
    public static function render($content): string
    {
        $instance = self::getInstance();
        $startTime = microtime(true);
        $startMemory = memory_get_usage();

        // Rendern
        $result = $instance->processor->process($content);
        
        // Statistiken aktualisieren
        $instance->stats['renderCalls']++;
        $instance->stats['processingTime'] += microtime(true) - $startTime;
        $instance->stats['memoryUsage'] += memory_get_usage() - $startMemory;
        
        return $result;
    }
    
    /**
     * Spezialisierte Methode zum Rendern von Fragmenten
     * 
     * @param string $fragmentName Name des Fragments (ohne .php)
     * @param array $data Fragment-Daten
     * @return string Gerenderter HTML-String
     */
    public static function renderFragment(string $fragmentName, array $data = []): string
    {
        $instance = self::getInstance();
        $startTime = microtime(true);
        
        // Fragment parsen
        $result = MFragment::parse($fragmentName, $data);

        // Statistiken aktualisieren
        $instance->stats['fragmentCalls']++;
        $instance->stats['processingTime'] += microtime(true) - $startTime;
        
        return $result;
    }
    
    /**
     * Shortcut für häufig verwendete Fragment-Typen
     * 
     * @param string $fragmentName Name des Fragments
     * @param array $content Content-Array
     * @param array $config Config-Array
     * @param array $attributes Attribute-Array
     * @return string Gerenderter HTML-String
     */
    public static function renderWithData(string $fragmentName, array $content = [], array $config = [], array $attributes = []): string
    {
        $data = [];
        
        if (!empty($content)) {
            $data['content'] = $content;
        }
        
        if (!empty($config)) {
            $data['config'] = $config;
        }
        
        if (!empty($attributes)) {
            $data['attributes'] = $attributes;
        }
        
        return self::renderFragment($fragmentName, $data);
    }
    
    /**
     * Spezialisierte Methode für Bootstrap-Komponenten
     * 
     * @param string $component Bootstrap-Komponenten-Name (z.B. 'accordion', 'tabs')
     * @param array $content Content-Daten
     * @param array $config Konfiguration
     * @return string Gerenderter HTML-String
     */
    public static function renderBootstrap(string $component, array $content = [], array $config = []): string
    {
        return self::renderWithData("bootstrap/{$component}", $content, $config);
    }
    
    /**
     * Spezialisierte Methode für Default-Komponenten
     * 
     * @param string $component Default-Komponenten-Name (z.B. 'figure')
     * @param array $content Content-Daten
     * @param array $config Konfiguration
     * @return string Gerenderter HTML-String
     */
    public static function renderDefault(string $component, array $content = [], array $config = []): string
    {
        return self::renderWithData("default/{$component}", $content, $config);
    }
    
    /**
     * Gibt Statistiken über die Rendering-Performance zurück
     * 
     * @return array Performance-Statistiken
     */
    public static function getStats(): array
    {
        return self::getInstance()->stats;
    }
    
    /**
     * Setzt die Statistiken zurück
     */
    public static function resetStats(): void
    {
        $instance = self::getInstance();
        $instance->stats = [
            'renderCalls' => 0,
            'fragmentCalls' => 0,
            'processingTime' => 0,
            'memoryUsage' => 0
        ];
    }
    
    /**
     * Debug-Informationen ausgeben
     * 
     * @return string Debug-Informationen als HTML
     */
    public static function getDebugInfo(): string
    {
        $stats = self::getStats();
        $avgTime = $stats['renderCalls'] > 0 ? $stats['processingTime'] / $stats['renderCalls'] : 0;
        $avgMemory = $stats['renderCalls'] > 0 ? $stats['memoryUsage'] / $stats['renderCalls'] : 0;
        
        return sprintf(
            '<pre>' .
            'RenderEngine Performance Stats:' . PHP_EOL .
            '- Total Render Calls: %d' . PHP_EOL .
            '- Total Fragment Calls: %d' . PHP_EOL .
            '- Total Processing Time: %.4f sec' . PHP_EOL .
            '- Average Time per Call: %.6f sec' . PHP_EOL .
            '- Total Memory Usage: %d bytes' . PHP_EOL .
            '- Average Memory per Call: %d bytes' . PHP_EOL .
            '</pre>',
            $stats['renderCalls'],
            $stats['fragmentCalls'],
            $stats['processingTime'],
            $avgTime,
            $stats['memoryUsage'],
            (int)$avgMemory
        );
    }
    
    /**
     * Konvertiert ComponentInterface zu HTML
     * 
     * @param ComponentInterface $component Zu rendernde Komponente
     * @return string Gerenderter HTML-String
     */
    public static function renderComponent(ComponentInterface $component): string
    {
        return self::render($component);
    }
    
    /**
     * Rendert ein Tag-Element mit Inhalt und Attributen
     * 
     * @param string $tag HTML-Tag
     * @param mixed $content Inhalt des Tags
     * @param array $attributes HTML-Attribute
     * @return string Gerenderter HTML-String
     */
    public static function renderTag(string $tag, $content = null, array $attributes = []): string
    {
        $element = [
            'tag' => $tag,
            'content' => $content,
            'attributes' => $attributes
        ];
        
        return self::render($element);
    }
    
    /**
     * Gibt die aktuelle Processor-Instanz zurück
     * 
     * @return MFragmentProcessor Der zentrale Processor
     */
    public static function getProcessor(): MFragmentProcessor
    {
        return self::getInstance()->processor;
    }
}