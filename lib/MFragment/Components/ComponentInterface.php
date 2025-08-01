<?php
# path: src/addons/mfragment/lib/MFragment/Components/ComponentInterface.php
namespace FriendsOfRedaxo\MFragment\Components;

/**
 * Interface für alle MFragment-Komponenten
 *
 * Definiert den Mindestumfang an Methoden, die alle Komponenten
 * implementieren müssen. Eliminiert redundante getFragmentData() Methode.
 */
interface ComponentInterface
{
    /**
     * Factory-Methode für die Fluent-API
     *
     * @return static Eine neue Instanz der Komponente
     */
    public static function factory(): self;

    /**
     * Rendert die Komponente und gibt das Ergebnis als String zurück
     *
     * @return string HTML-Code der Komponente
     */
    public function show(): string;

    /**
     * Überschreibt alle vorhandenen Klassen
     *
     * @param array|string $class CSS-Klassenname oder Array von Klassennamen
     * @return $this Für Method Chaining
     */
    public function setClass(array|string $class): self;

    /**
     * Fügt eine oder mehrere CSS-Klassen hinzu
     *
     * @param array|string $class CSS-Klassenname oder Array von Klassennamen
     * @return $this Für Method Chaining
     */
    public function addClass(array|string $class): self;

    /**
     * Entfernt eine CSS-Klasse
     *
     * @param string $class CSS-Klassenname
     * @return $this Für Method Chaining
     */
    public function removeClass(string $class): self;

    /**
     * Prüft, ob eine CSS-Klasse vorhanden ist
     *
     * @param string $class CSS-Klassenname
     * @return bool True, wenn die Klasse vorhanden ist
     */
    public function hasClass(string $class): bool;

    /**
     * Gibt alle CSS-Klassen zurück
     *
     * @return array Liste der CSS-Klassen
     */
    public function getClasses(): array;

    /**
     * Überschreibt alle HTML-Attribute
     *
     * @param array $attributes Assoziatives Array von Attributen
     * @return $this Für Method Chaining
     */
    public function setAttributes(array $attributes): self;

    /**
     * Setzt ein einzelnes HTML-Attribut
     *
     * @param string $name Name des Attributs
     * @param mixed $value Wert des Attributs
     * @return $this Für Method Chaining
     */
    public function setAttribute(string $name, $value): self;

    /**
     * Entfernt ein HTML-Attribut
     *
     * @param string $name Name des Attributs
     * @return $this Für Method Chaining
     */
    public function removeAttribute(string $name): self;

    /**
     * Prüft, ob ein HTML-Attribut vorhanden ist
     *
     * @param string $name Name des Attributs
     * @return bool True, wenn das Attribut vorhanden ist
     */
    public function hasAttribute(string $name): bool;

    /**
     * Gibt den Wert eines HTML-Attributs zurück
     *
     * @param string $name Name des Attributs
     * @param mixed $default Standardwert, wenn Attribut nicht existiert
     * @return mixed Wert des Attributs oder Standardwert
     */
    public function getAttribute(string $name, $default = null);

    /**
     * Gibt alle HTML-Attribute zurück
     *
     * @return array Liste der HTML-Attribute
     */
    public function getAttributes(): array;

    /**
     * Setzt den Fragment-Namen
     *
     * @param string $fragmentName Fragment-Name
     * @return $this Für Method Chaining
     */
    public function setFragmentName(string $fragmentName): self;

    /**
     * Gibt den Fragment-Namen zurück
     *
     * @return string Fragment-Name
     */
    public function getFragmentName(): string;
}