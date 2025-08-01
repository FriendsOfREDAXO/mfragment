<?php

namespace FriendsOfRedaxo\MFragment\Components\Default;

use FriendsOfRedaxo\MFragment\Components\AbstractComponent;

/**
 * Komponente für HTML-Tabellen mit Bootstrap-Integration
 *
 * Diese Komponente nutzt renderHtml() für direkte Performance
 * und bietet vollständige Bootstrap-Table-Unterstützung
 */
class Table extends AbstractComponent
{
    /**
     * Tabellenkörper (tbody)
     *
     * @var array
     */
    protected array $body = [];

    /**
     * Tabellenkopf (thead)
     *
     * @var array
     */
    protected array $header = [];

    /**
     * Tabellenfuß (tfoot)
     *
     * @var array
     */
    protected array $footer = [];

    /**
     * Tabellen-Konfiguration
     *
     * @var array
     */
    protected array $config = [
        'striped' => false,      // Zebra-Streifen
        'bordered' => false,     // Rahmen
        'borderless' => false,   // Keine Rahmen
        'hover' => false,        // Hover-Effekt
        'responsive' => false,   // Responsive Wrapper
        'sm' => false,           // Kompakte Darstellung
        'dark' => false,         // Dunkles Design
        'caption' => null,       // Tabellen-Beschriftung
        'captionTop' => false,   // Beschriftung oben anzeigen
    ];

    /**
     * Konstruktor
     *
     * @param array $body Tabellenkörper
     * @param array $header Tabellenkopf
     * @param array $footer Tabellenfuß
     */
    public function __construct(array $body = [], array $header = [], array $footer = [])
    {
        parent::__construct(''); // Kein Fragment, wir nutzen renderHtml()

        $this->setBody($body);
        $this->setHeader($header);
        $this->setFooter($footer);

        // Standard Bootstrap-Klasse
        $this->addClass('table');
    }

    /**
     * Factory-Methode
     *
     * @param array $body Tabellenkörper
     * @param array $header Tabellenkopf
     * @param array $footer Tabellenfuß
     * @param array $attributes Tabellen-Attribute
     * @return static
     */
    public static function create(array $body = [], array $header = [], array $footer = [], array $attributes = []): self
    {
        return self::factory()
            ->setBody($body)
            ->setHeader($header)
            ->setFooter($footer)
            ->setAttributes($attributes);
    }

    /**
     * Setzt den Tabellenkörper
     *
     * @param array $body Array von Zeilen (array von Zellen)
     * @return $this
     */
    public function setBody(array $body): self
    {
        $this->body = $body;
        return $this;
    }

    /**
     * Fügt eine Zeile zum Körper hinzu
     *
     * @param array $row Array von Zellen
     * @return $this
     */
    public function addBodyRow(array $row): self
    {
        $this->body[] = $row;
        return $this;
    }

    /**
     * Setzt den Tabellenkopf
     *
     * @param array $header Array von Kopf-Zellen oder array von Zeilen
     * @return $this
     */
    public function setHeader(array $header): self
    {
        $this->header = $header;
        return $this;
    }

    /**
     * Setzt den Tabellenfuß
     *
     * @param array $footer Array von Fuß-Zellen oder array von Zeilen
     * @return $this
     */
    public function setFooter(array $footer): self
    {
        $this->footer = $footer;
        return $this;
    }

    /**
     * Aktiviert Zebra-Streifen
     *
     * @param bool $striped True für Zebra-Streifen
     * @return $this
     */
    public function setStriped(bool $striped = true): self
    {
        $this->config['striped'] = $striped;
        $this->updateClass('table-striped', $striped);
        return $this;
    }

    /**
     * Aktiviert Rahmen
     *
     * @param bool $bordered True für Rahmen
     * @return $this
     */
    public function setBordered(bool $bordered = true): self
    {
        $this->config['bordered'] = $bordered;
        $this->updateClass('table-bordered', $bordered);
        return $this;
    }

    /**
     * Entfernt alle Rahmen
     *
     * @param bool $borderless True für keine Rahmen
     * @return $this
     */
    public function setBorderless(bool $borderless = true): self
    {
        $this->config['borderless'] = $borderless;
        $this->updateClass('table-borderless', $borderless);
        return $this;
    }

    /**
     * Aktiviert Hover-Effekt
     *
     * @param bool $hover True für Hover-Effekt
     * @return $this
     */
    public function setHover(bool $hover = true): self
    {
        $this->config['hover'] = $hover;
        $this->updateClass('table-hover', $hover);
        return $this;
    }

    /**
     * Setzt responsive Layout
     *
     * @param bool|string $responsive True oder responsive Breakpoint
     * @return $this
     */
    public function setResponsive($responsive = true): self
    {
        $this->config['responsive'] = $responsive;
        return $this;
    }

    /**
     * Setzt kompakte Darstellung
     *
     * @param bool $sm True für kleine Tabelle
     * @return $this
     */
    public function setSmall(bool $sm = true): self
    {
        $this->config['sm'] = $sm;
        $this->updateClass('table-sm', $sm);
        return $this;
    }

    /**
     * Setzt dunkles Design
     *
     * @param bool $dark True für dunkles Design
     * @return $this
     */
    public function setDark(bool $dark = true): self
    {
        $this->config['dark'] = $dark;
        $this->updateClass('table-dark', $dark);
        return $this;
    }

    /**
     * Setzt eine Beschriftung
     *
     * @param string|null $caption Beschriftungstext
     * @param bool $top Beschriftung oben anzeigen
     * @return $this
     */
    public function setCaption(?string $caption, bool $top = false): self
    {
        $this->config['caption'] = $caption;
        $this->config['captionTop'] = $top;
        return $this;
    }

    /**
     * Hilfsmethode zum Aktualisieren einer CSS-Klasse
     *
     * @param string $class CSS-Klasse
     * @param bool $add Hinzufügen oder entfernen
     */
    private function updateClass(string $class, bool $add): void
    {
        if ($add) {
            $this->addClass($class);
        } else {
            $this->removeClass($class);
        }
    }

    /**
     * Rendert eine Tabellen-Sektion (thead, tbody, tfoot)
     *
     * @param string $tag Tag (thead, tbody, tfoot)
     * @param array $rows Zeilen-Daten
     * @param string $cellTag Zell-Tag (th oder td)
     * @return string
     */
    private function renderSection(string $tag, array $rows, string $cellTag = 'td'): string
    {
        if (empty($rows)) {
            return '';
        }

        $output = "<{$tag}>" . PHP_EOL;

        // Wenn es einfache Array-Struktur ist (eine Zeile)
        if (!is_array(reset($rows))) {
            $output .= $this->renderRow($rows, $cellTag);
        } else {
            // Mehrere Zeilen
            foreach ($rows as $row) {
                $output .= $this->renderRow($row, $cellTag);
            }
        }

        $output .= "</{$tag}>" . PHP_EOL;
        return $output;
    }

    /**
     * Rendert eine einzelne Zeile
     *
     * @param array $row Zeilen-Daten
     * @param string $cellTag Zell-Tag (th oder td)
     * @return string
     */
    private function renderRow(array $row, string $cellTag = 'td'): string
    {
        $output = "  <tr>" . PHP_EOL;

        foreach ($row as $cell) {
            $cellContent = $this->processContent($cell);
            $output .= "    <{$cellTag}>{$cellContent}</{$cellTag}>" . PHP_EOL;
        }

        $output .= "  </tr>" . PHP_EOL;
        return $output;
    }

    /**
     * Rendert die Tabelle
     *
     * @return string HTML-String der Tabelle
     */
    protected function renderHtml(): string
    {
        $tableContent = '';

        // Beschriftung (caption) oben
        if ($this->config['caption'] && $this->config['captionTop']) {
            $tableContent .= '<caption class="caption-top">' . $this->config['caption'] . '</caption>' . PHP_EOL;
        }

        // Kopf (thead)
        if (!empty($this->header)) {
            $tableContent .= $this->renderSection('thead', $this->header, 'th');
        }

        // Körper (tbody)
        if (!empty($this->body)) {
            $tableContent .= $this->renderSection('tbody', $this->body);
        }

        // Fuß (tfoot)
        if (!empty($this->footer)) {
            $tableContent .= $this->renderSection('tfoot', $this->footer, 'th');
        }

        // Beschriftung (caption) unten
        if ($this->config['caption'] && !$this->config['captionTop']) {
            $tableContent .= '<caption>' . $this->config['caption'] . '</caption>' . PHP_EOL;
        }

        // Tabellen-HTML
        $tableAttrs = $this->buildAttributesString();
        $tableHtml = "<table{$tableAttrs}>" . PHP_EOL . $tableContent . "</table>";

        // Responsive Wrapper
        if ($this->config['responsive']) {
            $responsiveClass = is_string($this->config['responsive'])
                ? 'table-responsive-' . $this->config['responsive']
                : 'table-responsive';

            $tableHtml = '<div class="' . $responsiveClass . '">' . PHP_EOL . $tableHtml . PHP_EOL . '</div>';
        }

        return $tableHtml;
    }
}