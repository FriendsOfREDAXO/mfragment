<?php

namespace FriendsOfRedaxo\MFragment\Components\Bootstrap;

use FriendsOfRedaxo\MFragment\Components\AbstractComponent;

/**
 * Komponente für Bootstrap-Fortschrittsbalken
 *
 * Unterstützt einfache und mehrstufige Fortschrittsbalken
 * sowie animierte und stripes Varianten
 */
class Progress extends AbstractComponent
{
    /**
     * Fortschrittswerte
     *
     * @var array
     */
    protected array $values = [];

    /**
     * Konfiguration
     *
     * @var array
     */
    protected array $config = [
        'height' => null,          // Benutzerdefinierte Höhe
        'showLabel' => false,      // Prozent-Label anzeigen
        'animated' => false,       // Animation aktivieren
        'striped' => false,        // Gestreifte Darstellung
        'variant' => 'primary',    // Standard-Variante
        'stacked' => false,        // Mehrere Segmente übereinander
    ];

    /**
     * Konstruktor
     *
     * @param int|float $value Fortschrittswert (0-100)
     * @param string $variant Bootstrap-Variante
     */
    public function __construct($value = 0, string $variant = 'primary')
    {
         // Kein Fragment, wir nutzen renderHtml()
        
        // Standard Bootstrap Progress-Klasse
        $this->addClass('progress');
        
        // Ersten Wert hinzufügen
        if ($value !== null) {
            $this->addValue($value, $variant);
        }
    }

    /**
     * Factory-Methode für einfachen Fortschrittsbalken
     *
     * @param int|float $value Fortschrittswert (0-100)
     * @param string $variant Bootstrap-Variante
     * @return static
     */
    public static function create($value = 0, string $variant = 'primary'): self
    {
        return static::factory($value, $variant);
    }

    /**
     * Factory-Methode für gestapelten Fortschrittsbalken
     *
     * @param array $values Array mit Werten und Varianten
     * @return static
     */
    public static function stacked(array $values = []): self
    {
        $progress = static::factory()->setStacked(true);
        
        foreach ($values as $value) {
            if (isset($value['value'])) {
                $progress->addValue(
                    $value['value'],
                    $value['variant'] ?? 'primary',
                    $value['label'] ?? null
                );
            }
        }
        
        return $progress;
    }

    /**
     * Fügt einen Fortschrittswert hinzu
     *
     * @param int|float $value Fortschrittswert (0-100)
     * @param string $variant Bootstrap-Variante
     * @param string|null $label Optionales Label
     * @return $this
     */
    public function addValue($value, string $variant = 'primary', ?string $label = null): self
    {
        $value = max(0, min(100, (float)$value)); // Auf 0-100 begrenzen
        
        $this->values[] = [
            'value' => $value,
            'variant' => $variant,
            'label' => $label,
        ];
        
        return $this;
    }

    /**
     * Setzt die Höhe des Fortschrittsbalkens
     *
     * @param string $height Höhe in CSS-Format (z.B. '25px', '2rem')
     * @return $this
     */
    public function setHeight(string $height): self
    {
        $this->config['height'] = $height;
        return $this;
    }

    /**
     * Aktiviert/deaktiviert Prozent-Labels
     *
     * @param bool $show True für sichtbare Labels
     * @return $this
     */
    public function showLabel(bool $show = true): self
    {
        $this->config['showLabel'] = $show;
        return $this;
    }

    /**
     * Aktiviert/deaktiviert Animation
     *
     * @param bool $animated True für Animation
     * @return $this
     */
    public function setAnimated(bool $animated = true): self
    {
        $this->config['animated'] = $animated;
        return $this;
    }

    /**
     * Aktiviert/deaktiviert gestreifte Darstellung
     *
     * @param bool $striped True für Streifen
     * @return $this
     */
    public function setStriped(bool $striped = true): self
    {
        $this->config['striped'] = $striped;
        return $this;
    }

    /**
     * Aktiviert/deaktiviert gestapelte Darstellung
     *
     * @param bool $stacked True für gestapelt
     * @return $this
     */
    public function setStacked(bool $stacked = true): self
    {
        $this->config['stacked'] = $stacked;
        return $this;
    }

    /**
     * Erstellt ein Segment des Fortschrittsbalkens
     *
     * @param array $value Werte-Array mit value, variant, label
     * @return string HTML für ein Progress-Segment
     */
    private function createProgressBar(array $value): string
    {
        $classes = ['progress-bar'];
        
        // Variante
        $classes[] = 'bg-' . $value['variant'];
        
        // Stripes
        if ($this->config['striped']) {
            $classes[] = 'progress-bar-striped';
        }
        
        // Animation
        if ($this->config['animated']) {
            $classes[] = 'progress-bar-animated';
        }
        
        $attributes = [
            'class' => implode(' ', $classes),
            'role' => 'progressbar',
            'style' => 'width: ' . $value['value'] . '%',
            'aria-valuenow' => $value['value'],
            'aria-valuemin' => '0',
            'aria-valuemax' => '100',
        ];
        
        $content = '';
        
        // Label anzeigen
        if ($this->config['showLabel'] || $value['label'] !== null) {
            if ($value['label'] !== null) {
                $content = $value['label'];
            } else {
                $content = round($value['value']) . '%';
            }
        }
        
        $attributesStr = $this->buildAttributesString($attributes);
        return "<div{$attributesStr}>{$content}</div>";
    }

    /**
     * Rendert den Fortschrittsbalken
     *
     * @return string HTML-String des Fortschrittsbalkens
     */
    protected function renderHtml(): string
    {
        if (empty($this->values)) {
            return '';
        }
        
        // Container-Attribute
        $containerAttrs = $this->attributes;
        
        // Höhe setzen
        if ($this->config['height']) {
            if (!isset($containerAttrs['style'])) {
                $containerAttrs['style'] = '';
            }
            $containerAttrs['style'] .= 'height: ' . $this->config['height'] . ';';
        }
        
        // Klassen setzen
        $containerAttrs['class'] = $this->getClasses();
        
        $containerAttrsStr = $this->buildAttributesString($containerAttrs);
        
        // Progress-Balken erstellen
        $bars = [];
        foreach ($this->values as $value) {
            $bars[] = $this->createProgressBar($value);
        }
        
        return "<div{$containerAttrsStr}>" . implode('', $bars) . '</div>';
    }
}
