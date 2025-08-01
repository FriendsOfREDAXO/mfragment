<?php
# path: src/addons/mfragment/lib/MFragment/Components/AbstractComponent.php
namespace FriendsOfRedaxo\MFragment\Components;

use FriendsOfRedaxo\MFragment;
use FriendsOfRedaxo\MFragment\Core\RenderEngine;
use rex_factory_trait;
use rex_string;

/**
 * Moderne Basisklasse für alle MFragment-Komponenten
 *
 * Diese Version nutzt ausschließlich direktes HTML-Rendering 
 * ohne REDAXO-Fragment-Abhängigkeiten für bessere Performance.
 */
abstract class AbstractComponent implements ComponentInterface
{
    use rex_factory_trait;

    /**
     * HTML-Attribute der Komponente
     */
    protected array $attributes = [];

    /**
     * CSS-Klassen der Komponente
     */
    protected array $classes = [];

    /**
     * Konstruktor
     */
    public function __construct()
    {
        // Keine Fragment-Parameter mehr
    }

    /**
     * Factory-Methode für die Fluent-API
     *
     * @return static Eine neue Instanz der Komponente
     */
    public static function factory(): static
    {
        $class = self::getFactoryClass();
        return new $class();
    }

    /**
     * Überschreibt alle vorhandenen Klassen
     *
     * @param array|string $class
     * @return $this Für Method Chaining
     */
    public function setClass(array|string $class): self
    {
        if (is_string($class)) {
            $class = explode(' ', $class);
        }
        $this->classes = array_filter($class);
        return $this;
    }

    /**
     * Fügt eine oder mehrere CSS-Klassen hinzu
     *
     * @param array|string $class CSS-Klassenname oder Array von Klassennamen
     * @return $this Für Method Chaining
     */
    public function addClass(array|string $class): self
    {
        if (is_array($class)) {
            $class = array_filter($class);
            foreach ($class as $c) {
                if (is_string($c)) {
                    $this->addClass($c);
                }
            }
            return $this;
        }

        if (is_string($class) && !empty($class) && !in_array($class, $this->classes)) {
            $this->classes[] = $class;
        }
        return $this;
    }

    /**
     * Entfernt eine CSS-Klasse
     *
     * @param string $class CSS-Klassenname
     * @return $this Für Method Chaining
     */
    public function removeClass(string $class): self
    {
        $key = array_search($class, $this->classes);
        if ($key !== false) {
            unset($this->classes[$key]);
            $this->classes = array_values($this->classes); // Neu indizieren
        }
        return $this;
    }

    /**
     * Prüft, ob eine CSS-Klasse vorhanden ist
     *
     * @param string $class CSS-Klassenname
     * @return bool True, wenn die Klasse vorhanden ist
     */
    public function hasClass(string $class): bool
    {
        return in_array($class, $this->classes);
    }

    /**
     * Gibt alle CSS-Klassen zurück
     *
     * @return array Liste der CSS-Klassen
     */
    public function getClasses(): array
    {
        return $this->classes;
    }

    /**
     * Überschreibt alle HTML-Attribute
     *
     * Wenn 'class' in den Attributen enthalten ist, werden die Klassen ebenfalls überschrieben
     *
     * @param array $attributes Assoziatives Array von Attributen
     * @return $this Für Method Chaining
     */
    public function setAttributes(array $attributes): self
    {
        if (isset($attributes['class'])) {
            $class = $attributes['class'];
            unset($attributes['class']);

            if (is_array($class)) {
                $this->setClass($class);
            } elseif (is_string($class) && !empty($class)) {
                $this->setClass($class);
            }
        }
        $this->attributes = $attributes;
        return $this;
    }

    /**
     * Setzt ein einzelnes HTML-Attribut
     *
     * @param string $name Name des Attributs
     * @param mixed $value Wert des Attributs
     * @return $this Für Method Chaining
     */
    public function setAttribute(string $name, $value): self
    {
        if ($name === 'class') {
            return $this->setClass($value);
        }
        $this->attributes[$name] = $value;
        return $this;
    }

    /**
     * Entfernt ein HTML-Attribut
     *
     * @param string $name Name des Attributs
     * @return $this Für Method Chaining
     */
    public function removeAttribute(string $name): self
    {
        unset($this->attributes[$name]);
        return $this;
    }

    /**
     * Prüft, ob ein HTML-Attribut vorhanden ist
     *
     * @param string $name Name des Attributs
     * @return bool True, wenn das Attribut vorhanden ist
     */
    public function hasAttribute(string $name): bool
    {
        return isset($this->attributes[$name]);
    }

    /**
     * Gibt den Wert eines HTML-Attributs zurück
     *
     * @param string $name Name des Attributs
     * @param mixed $default Standardwert, wenn Attribut nicht existiert
     * @return mixed Wert des Attributs oder Standardwert
     */
    public function getAttribute(string $name, $default = null)
    {
        return $this->attributes[$name] ?? $default;
    }

    /**
     * Gibt alle HTML-Attribute zurück
     *
     * @return array Liste der HTML-Attribute
     */
    public function getAttributes(): array
    {
        return $this->attributes;
    }

    /**
     * Erstellt ein HTML-Attribut-String aus den definierten Attributen
     * Verwendet rex_string::buildAttributes() aus REDAXO
     *
     * @param array|null $attributes Optionale Attribute, die statt $this->attributes verwendet werden sollen
     * @return string HTML-Attribut-String
     */
    protected function buildAttributesString(?array $attributes = null): string
    {
        $attributes = $attributes ?? $this->attributes;

        // Klassen hinzufügen, wenn vorhanden
        if (!empty($this->classes)) {
            if (!isset($attributes['class'])) {
                $attributes['class'] = implode(' ', $this->classes);
            } else {
                $currentClasses = is_array($attributes['class'])
                    ? $attributes['class']
                    : explode(' ', (string)$attributes['class']);

                $attributes['class'] = implode(' ', array_unique(array_merge($currentClasses, $this->classes)));
            }
        }

        // rex_string::buildAttributes verwenden
        return rex_string::buildAttributes($attributes);
    }

    /**
     * Verarbeitet Content verschiedener Typen in einen String
     *
     * Diese Methode verarbeitet verschiedene Content-Typen in einen String:
     * - Komponenten werden zu HTML gerendert
     * - Arrays werden rekursiv verarbeitet
     * - MFragment-Objekte werden gerendert
     * - Strings werden direkt zurückgegeben
     *
     * @param mixed $content Zu verarbeitender Content
     * @return string Verarbeiteter Content als String
     */
    protected function processContent($content): string
    {
        if ($content === null) {
            return '';
        }

        if ($content instanceof ComponentInterface) {
            return $content->show();
        }

        if ($content instanceof MFragment) {
            return $content->show();
        }

        if (is_array($content)) {
            $result = '';
            foreach ($content as $item) {
                $result .= $this->processContent($item);
            }
            return $result;
        }

        return (string)$content;
    }

    /**
     * Rendert die Komponente als HTML-String
     *
     * Nutzt ausschließlich direktes HTML-Rendering ohne Fragment-Abhängigkeiten
     *
     * @return string HTML-Code der Komponente
     */
    public function show(): string
    {
        return RenderEngine::render($this->renderHtml());
    }

    /**
     * Direkte HTML-Rendering-Implementierung
     *
     * Diese Methode muss von allen Komponenten implementiert werden.
     *
     * @return string HTML-Code der Komponente
     */
    abstract protected function renderHtml(): string;
}