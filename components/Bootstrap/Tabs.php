<?php

namespace FriendsOfRedaxo\MFragment\Components\Bootstrap;

use FriendsOfRedaxo\MFragment\Components\AbstractComponent;
use FriendsOfRedaxo\MFragment\Components\ComponentInterface;

/**
 * Komponente für Tab-Navigation mit Content-Panels
 */
class Tabs extends AbstractComponent
{
    /**
     * Tabs mit Inhalt
     *
     * @var array
     */
    protected array $tabs = [];

    /**
     * Konfiguration der Tabs
     *
     * @var array
     */
    protected array $config = [
        'type' => 'tabs', // tabs, pills, underline
        'fill' => false,
        'justified' => false,
        'position' => 'top', // top, left, right, bottom
        'fade' => true, // Animation beim Tabwechsel
        'vertical' => false, // Vertikale Tabs (nur bei left/right)
        'contentClass' => 'tab-content p-3', // CSS-Klasse für den Content-Bereich
        'navClass' => 'nav', // CSS-Klasse für die Nav
        'navItemClass' => 'nav-item', // CSS-Klasse für die Nav-Items
        'navLinkClass' => 'nav-link', // CSS-Klasse für die Nav-Links
        'tabPaneClass' => 'tab-pane', // CSS-Klasse für die Tab-Panes
    ];

    /**
     * Konstruktor
     */
    public function __construct()
    {
        parent::__construct('');
    }

    /**
     * Factory-Methode
     *
     * @return static
     */
    public static function create(): self
    {
        return static::factory();
    }

    /**
     * Fügt einen Tab hinzu
     *
     * @param string $title Titel des Tabs
     * @param mixed $content Inhalt des Tabs
     * @param bool $active Ob der Tab aktiv sein soll
     * @param array $attributes Attribute für den Tab-Container
     * @param array $titleAttributes Attribute für den Tab-Titel
     * @return $this Für Method Chaining
     */
    public function addTab(string $title, $content, bool $active = false, array $attributes = [], array $titleAttributes = []): self
    {
        $tab = [
            'title' => $title,
            'content' => $content,
            'active' => $active,
            'attributes' => $attributes,
            'titleAttributes' => $titleAttributes,
        ];

        $this->tabs[] = $tab;
        return $this;
    }

    /**
     * Setzt den Tab-Typ
     *
     * @param string $type Typ der Tabs (tabs, pills, underline)
     * @return $this Für Method Chaining
     */
    public function setType(string $type): self
    {
        if (in_array($type, ['tabs', 'pills', 'underline'])) {
            $this->config['type'] = $type;
        }
        return $this;
    }

    /**
     * Setzt ob die Tabs den verfügbaren Platz ausfüllen sollen
     *
     * @param bool $fill True, wenn die Tabs den verfügbaren Platz ausfüllen sollen
     * @return $this Für Method Chaining
     */
    public function setFill(bool $fill = true): self
    {
        $this->config['fill'] = $fill;
        return $this;
    }

    /**
     * Setzt ob die Tabs gleichmäßig verteilt werden sollen
     *
     * @param bool $justified True, wenn die Tabs gleichmäßig verteilt werden sollen
     * @return $this Für Method Chaining
     */
    public function setJustified(bool $justified = true): self
    {
        $this->config['justified'] = $justified;
        return $this;
    }

    /**
     * Setzt die Position der Tabs
     *
     * @param string $position Position der Tabs (top, left, right, bottom)
     * @return $this Für Method Chaining
     */
    public function setPosition(string $position): self
    {
        if (in_array($position, ['top', 'left', 'right', 'bottom'])) {
            $this->config['position'] = $position;
            
            // Automatisch auf vertikal setzen bei left/right
            if ($position === 'left' || $position === 'right') {
                $this->config['vertical'] = true;
            } else {
                $this->config['vertical'] = false;
            }
        }
        return $this;
    }

    /**
     * Setzt ob die Tabs vertikal ausgerichtet werden sollen
     *
     * @param bool $vertical True, wenn die Tabs vertikal ausgerichtet werden sollen
     * @return $this Für Method Chaining
     */
    public function setVertical(bool $vertical = true): self
    {
        $this->config['vertical'] = $vertical;
        return $this;
    }

    /**
     * Setzt ob die Tabs mit Fade-Effekt angezeigt werden sollen
     *
     * @param bool $fade True, wenn die Tabs mit Fade-Effekt angezeigt werden sollen
     * @return $this Für Method Chaining
     */
    public function setFade(bool $fade = true): self
    {
        $this->config['fade'] = $fade;
        return $this;
    }

    /**
     * Rendert die Tabs-Komponente
     *
     * @return string HTML-Code der Tabs-Komponente
     */
    protected function renderHtml(): string
    {
        if (empty($this->tabs)) {
            return '<!-- Empty tabs -->';
        }

        $id = $this->getAttribute('id', 'tabs-' . uniqid());
        $this->setAttribute('id', $id);

        // Navigation-Klassen
        $navClass = $this->config['navClass'];
        
        if ($this->config['type'] === 'tabs') {
            $navClass .= ' nav-tabs';
        } elseif ($this->config['type'] === 'pills') {
            $navClass .= ' nav-pills';
        } elseif ($this->config['type'] === 'underline') {
            $navClass .= ' nav-underline';
        }
        
        if ($this->config['fill']) {
            $navClass .= ' nav-fill';
        }
        
        if ($this->config['justified']) {
            $navClass .= ' nav-justified';
        }
        
        // Wrapper-Klassen
        $wrapperClass = '';
        
        if ($this->config['vertical']) {
            $wrapperClass = 'row';
        }

        // Output generieren
        $output = '<div' . $this->buildAttributesString() . '>' . PHP_EOL;
        
        // Wenn vertikal, ein umschließendes row-Element hinzufügen
        if ($this->config['vertical']) {
            $output = '<div class="' . $wrapperClass . '">' . PHP_EOL;
            
            // Reihenfolge der Elemente basierend auf Position
            $navCol = 'col-md-3';
            $contentCol = 'col-md-9';
            
            if ($this->config['position'] === 'right') {
                // Zuerst Inhalt, dann Navigation
                $output .= $this->renderTabContent($id, $contentCol);
                $output .= $this->renderTabNav($id, $navClass, $navCol);
            } else {
                // Zuerst Navigation, dann Inhalt
                $output .= $this->renderTabNav($id, $navClass, $navCol);
                $output .= $this->renderTabContent($id, $contentCol);
            }
            
            $output .= '</div>' . PHP_EOL;
        } else {
            // Horizontale Tabs
            if ($this->config['position'] === 'bottom') {
                // Zuerst Inhalt, dann Navigation
                $output .= $this->renderTabContent($id);
                $output .= $this->renderTabNav($id, $navClass);
            } else {
                // Zuerst Navigation, dann Inhalt
                $output .= $this->renderTabNav($id, $navClass);
                $output .= $this->renderTabContent($id);
            }
        }
        
        $output .= '</div>';

        return $output;
    }

    /**
     * Rendert die Tab-Navigation
     *
     * @param string $id ID der Tabs-Komponente
     * @param string $navClass CSS-Klassen für die Navigation
     * @param string|null $colClass CSS-Klasse für die umschließende Spalte bei vertikalen Tabs
     * @return string HTML-Code der Tab-Navigation
     */
    protected function renderTabNav(string $id, string $navClass, ?string $colClass = null): string
    {
        $output = '';
        
        // Bei vertikalen Tabs die Navigation in eine Spalte packen
        if ($colClass) {
            $output .= '<div class="' . $colClass . '">' . PHP_EOL;
            $navClass .= ' flex-column';
        }
        
        $output .= '<ul class="' . $navClass . '" role="tablist">' . PHP_EOL;
        
        foreach ($this->tabs as $index => $tab) {
            $tabId = 'tab-' . $id . '-' . $index;
            $contentId = 'content-' . $id . '-' . $index;
            $active = $tab['active'] ? ' active' : '';
            $titleAttributes = $tab['titleAttributes'] ?? [];
            
            $titleAttributesStr = $this->buildAttributesString(array_merge($titleAttributes, [
                'class' => $this->config['navLinkClass'] . $active,
                'id' => $tabId,
                'data-bs-toggle' => 'tab',
                'data-bs-target' => '#' . $contentId,
                'role' => 'tab',
                'aria-controls' => $contentId,
                'aria-selected' => $tab['active'] ? 'true' : 'false'
            ]));
            
            $output .= '  <li class="' . $this->config['navItemClass'] . '" role="presentation">' . PHP_EOL;
            $output .= '    <button' . $titleAttributesStr . '>' . $tab['title'] . '</button>' . PHP_EOL;
            $output .= '  </li>' . PHP_EOL;
        }
        
        $output .= '</ul>' . PHP_EOL;
        
        // Bei vertikalen Tabs die umschließende Spalte schließen
        if ($colClass) {
            $output .= '</div>' . PHP_EOL;
        }
        
        return $output;
    }

    /**
     * Rendert den Tab-Inhalt
     *
     * @param string $id ID der Tabs-Komponente
     * @param string|null $colClass CSS-Klasse für die umschließende Spalte bei vertikalen Tabs
     * @return string HTML-Code des Tab-Inhalts
     */
    protected function renderTabContent(string $id, ?string $colClass = null): string
    {
        $output = '';
        
        // Bei vertikalen Tabs den Inhalt in eine Spalte packen
        if ($colClass) {
            $output .= '<div class="' . $colClass . '">' . PHP_EOL;
        }
        
        $output .= '<div class="' . $this->config['contentClass'] . '">' . PHP_EOL;
        
        foreach ($this->tabs as $index => $tab) {
            $contentId = 'content-' . $id . '-' . $index;
            $tabId = 'tab-' . $id . '-' . $index;
            $active = $tab['active'] ? ' show active' : '';
            $fade = $this->config['fade'] ? ' fade' : '';
            $attributes = $tab['attributes'] ?? [];
            
            $tabAttributesStr = $this->buildAttributesString(array_merge($attributes, [
                'class' => $this->config['tabPaneClass'] . $active . $fade,
                'id' => $contentId,
                'role' => 'tabpanel',
                'aria-labelledby' => $tabId
            ]));
            
            $output .= '  <div' . $tabAttributesStr . '>' . PHP_EOL;
            $output .= '    ' . $this->processContent($tab['content']) . PHP_EOL;
            $output .= '  </div>' . PHP_EOL;
        }
        
        $output .= '</div>' . PHP_EOL;
        
        // Bei vertikalen Tabs die umschließende Spalte schließen
        if ($colClass) {
            $output .= '</div>' . PHP_EOL;
        }
        
        return $output;
    }

    /**
     * Verarbeitet Content verschiedener Typen
     *
     * @param mixed $content Zu verarbeitender Inhalt
     * @return string Verarbeiteter Inhalt als String
     */
    protected function processContent($content): string
    {
        if ($content instanceof ComponentInterface) {
            return $content->show();
        } elseif (is_string($content)) {
            return $content;
        } else {
            return '';
        }
    }

    /**
     * Gibt die Datenstruktur für das Fragment zurück
     * (Wird nicht verwendet, da kein Fragment-Aufruf)
     *
     * @return array Leeres Array
     */
    public function getFragmentData(): array
    {
        return [];
    }
}
