<?php

namespace FriendsOfRedaxo\MFragment\Components\Bootstrap;

use FriendsOfRedaxo\MFragment\Components\AbstractComponent;

/**
 * Komponente für Bootstrap-Badges
 *
 * Kleine Labels und Indikatoren mit verschiedenen Stilen und Farben
 * Nutzt renderHtml() für direktes, performantes Rendering
 */
class Badge extends AbstractComponent
{
    /**
     * Badge-Text
     *
     * @var string
     */
    protected string $text = '';

    /**
     * Konfiguration
     *
     * @var array
     */
    protected array $config = [
        'type' => 'text',           // text, pill, counter
        'variant' => 'secondary',   // primary, secondary, success, danger, warning, info, light, dark
        'positioned' => false,      // Position absolute für counter
        'position' => 'top-0 start-100', // Positions-Klassen für positioned badges
        'icon' => null,            // Icon vor dem Text
        'iconAfter' => null,       // Icon nach dem Text
        'dismissible' => false,    // Schließbar machen (wie Alert)
    ];

    /**
     * Konstruktor
     *
     * @param string $text Badge-Text
     * @param string $variant Bootstrap-Variante
     */
    public function __construct(string $text = '', string $variant = 'secondary')
    {
        parent::__construct(''); // Kein Fragment, wir nutzen renderHtml()
        
        $this->setText($text);
        $this->setVariant($variant);
        
        // Standard Badge-Klasse
        $this->addClass('badge');
    }

    /**
     * Factory-Methode
     *
     * @param string $text Badge-Text
     * @param string $variant Bootstrap-Variante
     * @return static
     */
    public static function create(string $text = '', string $variant = 'secondary'): self
    {
        return static::factory($text, $variant);
    }

    /**
     * Erstellt ein Pill-Badge (abgerundete Ecken)
     *
     * @param string $text Badge-Text
     * @param string $variant Bootstrap-Variante
     * @return static
     */
    public static function pill(string $text = '', string $variant = 'secondary'): self
    {
        return static::create($text, $variant)->setType('pill');
    }

    /**
     * Erstellt ein Counter-Badge (für Notifications etc.)
     *
     * @param int|string $count Anzahl oder Text
     * @param string $variant Bootstrap-Variante
     * @param bool $positioned Absolute Positionierung aktivieren
     * @return static
     */
    public static function counter($count, string $variant = 'danger', bool $positioned = true): self
    {
        $badge = static::create((string)$count, $variant)
            ->setType('counter');
            
        if ($positioned) {
            $badge->setPositioned(true);
        }
        
        return $badge;
    }

    /**
     * Helper für spezifische Varianten
     */
    public static function success(string $text): self
    {
        return static::create($text, 'success');
    }

    public static function danger(string $text): self
    {
        return static::create($text, 'danger');
    }

    public static function warning(string $text): self
    {
        return static::create($text, 'warning');
    }

    public static function info(string $text): self
    {
        return static::create($text, 'info');
    }

    /**
     * Setzt den Badge-Text
     *
     * @param string $text Text
     * @return $this
     */
    public function setText(string $text): self
    {
        $this->text = $text;
        return $this;
    }

    /**
     * Setzt die Bootstrap-Variante
     *
     * @param string $variant Bootstrap color variant
     * @return $this
     */
    public function setVariant(string $variant): self
    {
        $validVariants = ['primary', 'secondary', 'success', 'danger', 'warning', 'info', 'light', 'dark'];
        
        if (in_array($variant, $validVariants)) {
            // Alte Variante entfernen
            foreach ($validVariants as $v) {
                $this->removeClass("text-bg-{$v}");
            }
            
            $this->config['variant'] = $variant;
            $this->addClass("text-bg-{$variant}");
        }
        
        return $this;
    }

    /**
     * Setzt den Badge-Typ
     *
     * @param string $type text, pill, counter
     * @return $this
     */
    public function setType(string $type): self
    {
        if (in_array($type, ['text', 'pill', 'counter'])) {
            // Alte Typ-Klassen entfernen
            $this->removeClass('rounded-pill');
            
            $this->config['type'] = $type;
            
            // Neue Klassen hinzufügen
            if ($type === 'pill') {
                $this->addClass('rounded-pill');
            }
        }
        
        return $this;
    }

    /**
     * Aktiviert absolute Positionierung für den Badge
     *
     * @param bool $positioned True für absolute Positionierung
     * @param string|null $position Positions-Klassen (z.B. 'top-0 start-100')
     * @return $this
     */
    public function setPositioned(bool $positioned = true, ?string $position = null): self
    {
        $this->config['positioned'] = $positioned;
        
        if ($positioned) {
            $this->addClass('position-absolute');
            $this->addClass('translate-middle');
            
            if ($position !== null) {
                $this->config['position'] = $position;
            }
            
            // Positions-Klassen hinzufügen
            $positionClasses = explode(' ', $this->config['position']);
            foreach ($positionClasses as $class) {
                $this->addClass($class);
            }
        } else {
            $this->removeClass('position-absolute');
            $this->removeClass('translate-middle');
            
            // Positions-Klassen entfernen
            $positionClasses = explode(' ', $this->config['position']);
            foreach ($positionClasses as $class) {
                $this->removeClass($class);
            }
        }
        
        return $this;
    }

    /**
     * Fügt ein Icon hinzu
     *
     * @param string $icon Icon-HTML oder CSS-Klasse
     * @param bool $after True für Icon nach dem Text
     * @return $this
     */
    public function setIcon(string $icon, bool $after = false): self
    {
        if ($after) {
            $this->config['iconAfter'] = $icon;
        } else {
            $this->config['icon'] = $icon;
        }
        
        return $this;
    }

    /**
     * Macht den Badge schließbar
     *
     * @param bool $dismissible True für schließbar
     * @return $this
     */
    public function setDismissible(bool $dismissible = true): self
    {
        $this->config['dismissible'] = $dismissible;
        
        if ($dismissible) {
            $this->addClass('alert');
            $this->addClass('alert-dismissible');
            $this->addClass('d-inline-flex');
            $this->addClass('align-items-center');
            $this->addClass('p-2');
        } else {
            $this->removeClass('alert');
            $this->removeClass('alert-dismissible');
            $this->removeClass('d-inline-flex');
            $this->removeClass('align-items-center');
            $this->removeClass('p-2');
        }
        
        return $this;
    }

    /**
     * Rendert den Badge
     *
     * @return string HTML-String des Badges
     */
    protected function renderHtml(): string
    {
        $content = [];

        // Icon vor dem Text
        if ($this->config['icon']) {
            $icon = $this->config['icon'];
            
            // Wenn Icon nur CSS-Klasse ist
            if (strpos($icon, '<') === false) {
                $content[] = '<i class="' . $icon . ' me-1"></i>';
            } else {
                $content[] = $icon;
            }
        }

        // Text
        $content[] = $this->text;

        // Icon nach dem Text
        if ($this->config['iconAfter']) {
            $icon = $this->config['iconAfter'];
            
            // Wenn Icon nur CSS-Klasse ist
            if (strpos($icon, '<') === false) {
                $content[] = '<i class="' . $icon . ' ms-1"></i>';
            } else {
                $content[] = $icon;
            }
        }

        // Close-Button für schließbare Badges
        if ($this->config['dismissible']) {
            $content[] = '<button type="button" class="btn-close btn-close-white ms-2" data-bs-dismiss="alert" aria-label="Schließen" style="width: 0.5em; height: 0.5em;"></button>';
        }

        $contentString = implode('', $content);
        $attributesStr = $this->buildAttributesString();

        // Badge-Element
        if ($this->config['dismissible']) {
            // Für schließbare Badges verwenden wir span
            return "<span{$attributesStr}>{$contentString}</span>";
        } else {
            // Standard Badge
            return "<span{$attributesStr}>{$contentString}</span>";
        }
    }
}