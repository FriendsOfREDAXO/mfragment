<?php

namespace FriendsOfRedaxo\MFragment\Components\Bootstrap;

use FriendsOfRedaxo\MFragment\Components\AbstractComponent;
use FriendsOfRedaxo\MFragment;

/**
 * Optimierte Card-Komponente mit direktem HTML-Rendering
 * 
 * Diese Komponente verwendet renderHtml() statt des Fragment-Systems
 * für bessere Performance und einfachere Wartung.
 */
class Card extends AbstractComponent
{
    /**
     * Bereiche der Komponente
     */
    private array $sections = [
        'header' => null,
        'image' => null,
        'body' => null,
        'list' => null,
        'footer' => null,
        'ribbon' => null
    ];

    /**
     * Konfiguration der Bereiche
     */
    private array $sectionConfig = [];

    /**
     * Standard-Klassen für Bereiche
     */
    private array $defaultClasses = [
        'header' => ['card-header'],
        'image' => ['card-image', 'card-img-top'],
        'body' => ['card-body'],
        'list' => ['list-group', 'list-group-flush'],
        'footer' => ['card-footer'],
        'ribbon' => ['ribbon']
    ];

    /**
     * Konfigurationseigenschaften
     */
    private array $config = [
        'image_position' => 'left'
    ];

    /**
     * Konstruktor
     */
    public function __construct()
    {
        $this->addClass('card');

        // Sectionconfig initialisieren
        foreach (array_keys($this->sections) as $section) {
            $this->sectionConfig[$section] = [
                'classes' => [],
                'attributes' => []
            ];
        }
    }

    /**
     * Allgemeine Methode zum Setzen eines Bereichs mit Content und Attributen
     *
     * @param string $section Name des Bereichs (header, body, footer, etc.)
     * @param mixed $content Inhalt des Bereichs
     * @param array $attributes Attribute für den Bereich
     * @return $this
     */
    public function setSection(string $section, $content, array $attributes = []): self
    {
        if (!array_key_exists($section, $this->sections)) {
            return $this;
        }

        $this->sections[$section] = $content;

        // Klassen aus Attributen extrahieren und zur sectionConfig hinzufügen
        if (isset($attributes['class'])) {
            $classes = $attributes['class'];
            unset($attributes['class']);

            if (is_string($classes)) {
                $classes = explode(' ', $classes);
            }

            $this->sectionConfig[$section]['attributes']['class'] = array_filter($classes);
        }

        // Restliche Attribute setzen
        foreach ($attributes as $name => $value) {
            $this->sectionConfig[$section]['attributes'][$name] = $value;
        }

        return $this;
    }

    /**
     * Setzt eine Konfigurationsoption
     *
     * @param string $key Konfigurationsschlüssel
     * @param mixed $value Konfigurationswert
     * @return $this
     */
    public function setConfig(string $key, $value): self
    {
        $this->config[$key] = $value;
        return $this;
    }

    /**
     * Setzt den Anzeigeort des Bildes
     *
     * @param string $position Position (top, bottom, left, right)
     * @return $this
     */
    public function setImagePosition(string $position): self
    {
        if (in_array($position, ['top', 'bottom', 'left', 'right'])) {
            $this->config['image_position'] = $position;
        }
        return $this;
    }

    /**
     * Hilfsmethoden für einzelne Bereiche mit der kombinierten API
     */

    /**
     * Setzt den Header
     *
     * @param mixed $content Inhalt des Headers
     * @param array $attributes Attribute für den Header
     * @return $this
     */
    public function setHeader($content, array $attributes = []): self
    {
        return $this->setSection('header', $content, $attributes);
    }

    /**
     * Setzt den Body
     *
     * @param mixed $content Inhalt des Bodys
     * @param array $attributes Attribute für den Body
     * @return $this
     */
    public function setBody($content, array $attributes = []): self
    {
        return $this->setSection('body', $content, $attributes);
    }

    /**
     * Setzt den Footer
     *
     * @param mixed $content Inhalt des Footers
     * @param array $attributes Attribute für den Footer
     * @return $this
     */
    public function setFooter($content, array $attributes = []): self
    {
        return $this->setSection('footer', $content, $attributes);
    }

    /**
     * Setzt das Bild
     *
     * @param mixed $content Inhalt des Bildes
     * @param array $attributes Attribute für das Bild
     * @return $this
     */
    public function setImage($content, array $attributes = []): self
    {
        return $this->setSection('image', $content, $attributes);
    }

    /**
     * Setzt die Liste
     *
     * @param mixed $content Inhalt der Liste
     * @param array $attributes Attribute für die Liste
     * @return $this
     */
    public function setList($content, array $attributes = []): self
    {
        return $this->setSection('list', $content, $attributes);
    }

    /**
     * Setzt das Ribbon
     *
     * @param mixed $content Inhalt des Ribbons
     * @param array $attributes Attribute für das Ribbon
     * @return $this
     */
    public function setRibbon($content, array $attributes = []): self
    {
        return $this->setSection('ribbon', $content, $attributes);
    }

    /**
     * Fügt eine Klasse zu einem Bereich hinzu
     *
     * @param string $section Name des Bereichs
     * @param array|string $class CSS-Klasse oder Array von Klassen
     * @return $this
     */
    public function addSectionClass(string $section, array|string $class): self
    {
        if (!isset($this->sectionConfig[$section])) {
            return $this;
        }

        if (is_array($class)) {
            foreach ($class as $c) {
                $this->addSectionClass($section, $c);
            }
            return $this;
        }

        if (is_string($class) && !empty($class) && !in_array($class, $this->sectionConfig[$section]['classes'])) {
            $this->sectionConfig[$section]['classes'][] = $class;
        }

        return $this;
    }

    /**
     * Setzt ein Attribut für einen Bereich
     *
     * @param string $section Name des Bereichs
     * @param string $name Name des Attributs
     * @param mixed $value Wert des Attributs
     * @return $this
     */
    public function setSectionAttribute(string $section, string $name, $value): self
    {
        if (!isset($this->sectionConfig[$section])) {
            return $this;
        }

        if ($name === 'class') {
            if (is_string($value)) {
                $value = explode(' ', $value);
            }
            $this->sectionConfig[$section]['classes'] = array_filter((array)$value);
            return $this;
        }

        $this->sectionConfig[$section]['attributes'][$name] = $value;
        return $this;
    }

    /**
     * Hilfsmethoden für einzelne Bereiche - Klassen
     */

    /**
     * Fügt eine Klasse zum Header hinzu
     */
    public function addHeaderClass(array|string $class): self
    {
        return $this->addSectionClass('header', $class);
    }

    /**
     * Fügt eine Klasse zum Body hinzu
     */
    public function addBodyClass(array|string $class): self
    {
        return $this->addSectionClass('body', $class);
    }

    /**
     * Fügt eine Klasse zum Footer hinzu
     */
    public function addFooterClass(array|string $class): self
    {
        return $this->addSectionClass('footer', $class);
    }

    /**
     * Hilfsmethoden für einzelne Bereiche - Attribute
     */

    /**
     * Setzt ein Attribut für den Header
     */
    public function setHeaderAttribute(string $name, $value): self
    {
        return $this->setSectionAttribute('header', $name, $value);
    }

    /**
     * Setzt ein Attribut für den Body
     */
    public function setBodyAttribute(string $name, $value): self
    {
        return $this->setSectionAttribute('body', $name, $value);
    }

    /**
     * Setzt ein Attribut für den Footer
     */
    public function setFooterAttribute(string $name, $value): self
    {
        return $this->setSectionAttribute('footer', $name, $value);
    }

    /**
     * Überschreibt getComponentKey für korrekte Config-Generierung (nicht mehr verwendet)
     */
    protected function getComponentKey(): ?string
    {
        return 'card';
    }

    /**
     * Implementiert getContentForFragment (nicht mehr verwendet, da renderHtml)
     */
    protected function getContentForFragment()
    {
        // Nicht mehr verwendet, da direkte HTML-Generierung
        return [];
    }

    /**
     * Implementiert getConfigForFragment (nicht mehr verwendet, da renderHtml)
     */
    protected function getConfigForFragment(): array
    {
        // Nicht mehr verwendet, da direkte HTML-Generierung
        return [];
    }

    /**
     * Direktes HTML-Rendering ohne Fragment-System
     */
    protected function renderHtml(): string
    {
        $cardFragment = MFragment::factory();
        
        // Ribbon zuerst hinzufügen, wenn vorhanden (positioniert sich absolut)
        if (!empty($this->sections['ribbon'])) {
            $ribbonHtml = $this->createSection('ribbon')->show();
            $cardFragment->addHtml($ribbonHtml);
        }

        // Reihenfolge der Bereiche entsprechend Bootstrap Card-Struktur
        $sectionOrder = ['header', 'image', 'body', 'list', 'footer'];
        
        foreach ($sectionOrder as $section) {
            if (!empty($this->sections[$section])) {
                $sectionHtml = $this->createSection($section)->show();
                $cardFragment->addHtml($sectionHtml);
            }
        }

        // Card-Container mit Attributen und Klassen erstellen
        return MFragment::factory()
            ->addDiv($cardFragment, $this->getAttributesWithClasses())
            ->show();
    }

    /**
     * Erstellt einen MFragment für einen Card-Bereich
     */
    private function createSection(string $section): MFragment
    {
        $content = $this->sections[$section];
        if ($content === null) {
            return MFragment::factory();
        }

        // Klassen für den Bereich zusammenbauen
        $classes = [];
        
        // Default-Klassen hinzufügen
        if (isset($this->defaultClasses[$section])) {
            $classes = array_merge($classes, $this->defaultClasses[$section]);
        }
        
        // Konfigurierte Klassen hinzufügen
        if (!empty($this->sectionConfig[$section]['classes'])) {
            $classes = array_merge($classes, $this->sectionConfig[$section]['classes']);
        }

        // Attribute zusammenbauen
        $attributes = $this->sectionConfig[$section]['attributes'] ?? [];
        
        // Klassen aus den Attributen hinzufügen (fix für custom classes)
        if (isset($attributes['class'])) {
            if (is_array($attributes['class'])) {
                $classes = array_merge($classes, $attributes['class']);
            } elseif (is_string($attributes['class'])) {
                $classes = array_merge($classes, explode(' ', $attributes['class']));
            }
            unset($attributes['class']); // Entfernen um Doppelung zu vermeiden
        }
        
        if (!empty($classes)) {
            $attributes['class'] = $classes;
        }

        // Content verarbeiten und als MFragment-Element zurückgeben
        $processedContent = $this->processContent($content);
        
        return MFragment::factory()->addDiv($processedContent, $attributes);
    }

    /**
     * Gibt Attribute inklusive der Klassen aus $this->classes zurück
     * 
     * @return array Vollständige Attribute inklusive Klassen
     */
    private function getAttributesWithClasses(): array
    {
        $attributes = $this->getAttributes();
        
        // Klassen aus $this->classes zu den Attributen hinzufügen
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
        
        return $attributes;
    }
}