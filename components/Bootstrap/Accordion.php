<?php

namespace FriendsOfRedaxo\MFragment\Components\Bootstrap;

use FriendsOfRedaxo\MFragment\Components\AbstractComponent;

/**
 * Komponente für Accordion-Navigation
 *
 * Erbt von Collapse, aber mit angepasstem Verhalten:
 * - Nur ein Item kann gleichzeitig geöffnet sein
 * - Spezielle Bootstrap-Accordion-Klassen
 * - Parent-Container für exklusives Verhalten
 */
class Accordion extends Collapse
{
    /**
     * Konstruktor
     *
     * @param bool $multiple Erlaubt mehrere offene Items gleichzeitig (default: false für Accordion)
     */
    public function __construct(bool $multiple = false)
    {
        parent::__construct($multiple);
        
        // Accordion-spezifische Konfiguration
        $this->config['wrapper'] = [
            'attributes' => ['class' => ['default' => 'accordion']]
        ];
        
        // Generiere eindeutige ID für das Accordion
        if (empty($this->getAttribute('id'))) {
            $this->setAttribute('id', 'accordion-' . uniqid());
        }
    }

    /**
     * Factory-Methode für Accordion
     *
     * @param bool $multiple Erlaubt mehrere offene Items gleichzeitig (default: false)
     * @return static
     */
    public static function create(bool $multiple = false): self
    {
        return new static($multiple);
    }
}