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
     * @param bool $multiple Erlaubt mehrere offene Items gleichzeitig
     */
    public function __construct(bool $multiple = false)
    {
        parent::__construct(false); // false = nur ein Item offen
    }
}