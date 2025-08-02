<?php

namespace FriendsOfRedaxo\MFragment\Components\Bootstrap;

use FriendsOfRedaxo\MFragment\Components\AbstractComponent;

/**
 * Komponente für einzelne ausklappbare Elemente (Collapse)
 *
 * Im Gegensatz zu Accordion kann diese Komponente unabhängig verwendet werden
 * und unterstützt auch mehrere gleichzeitig geöffnete Elemente
 */
class Collapse extends AbstractComponent
{
    /**
     * Items der Collapse-Gruppe
     *
     * @var array
     */
    protected array $items = [];

    /**
     * Konfiguration
     *
     * @var array
     */
    protected array $config = [
        'multiple' => true,         // Mehrere Items gleichzeitig öffnen
        'transition' => true,       // Animierte Übergänge
        'parent' => null,          // Parent-Container für Accordion-ähnliches Verhalten
        'item' => [
            'attributes' => ['class' => ['default' => 'accordion-item']]
        ],
        'button' => [
            'attributes' => ['class' => ['default' => 'accordion-button']]
        ],
        'headerText' => [
            'tag' => 'h4',
            'attributes' => ['class' => ['default' => 'accordion-header-text lh-140']]
        ],
        'headerToggle' => [
            'attributes' => ['class' => ['default' => 'accordion-header-toggle']]
        ],
        'collapseItem' => [
            'attributes' => ['class' => ['default' => 'accordion-collapse', 'collapse' => 'collapse']]
        ],
        'body' => [
            'attributes' => ['class' => ['default' => 'accordion-body ck-content']]
        ],
        'icon' => false
    ];



    private bool $multiple = true;

    /**
     * Konstruktor
     *
     * @param bool $multiple Erlaubt mehrere offene Items gleichzeitig
     */
    public function __construct(bool $multiple = true)
    {
        
        $this->setMultiple($multiple);
    }

    /**
     * Factory-Methode
     *
     * @return static
     */
    public static function create(bool $multiple = true): self
    {
        return static::factory($multiple);
    }

    /**
     * Setzt den Header-Stil
     *
     * @param string $tag HTML-Tag für Header (default: h2)
     * @param array $attributes Attribute für den Header
     * @param string|null $textTag HTML-Tag für den Header-Text (default: h4)
     * @param string|null $textClass CSS-Klasse für den Header-Text
     * @return $this
     */
    public function configureHeader(string $tag = 'h4', array $attributes = [], ?string $textTag = null, ?string $textClass = null): self
    {
        $this->config['headerText']['tag'] = $tag;

        if (!empty($attributes)) {
            $this->config['headerText']['attributes'] = array_merge(
                $this->config['headerText']['attributes'],
                $attributes
            );
        }

        if ($textTag !== null) {
            $this->config['headerText']['tag'] = $textTag;
        }

        if ($textClass !== null) {
            $this->config['headerText']['attributes']['class'] = [$textClass];
        }

        return $this;
    }

    /**
     * Konfiguriert Toggle-Icon
     *
     * @param bool|array $icon Icon-Konfiguration oder false zum Ausblenden
     * @return $this
     */
    public function configureToggle($icon): self
    {
        if ($icon === false) {
            $this->config['toggle'] = false;
        } else if (is_array($icon)) {
            $this->config['toggle']['html'] = $icon;
//        } else {
//            $this->config['icon'] = [
//                'html' => '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon icon-chevron-down"><path d="M6 9l6 6 6-6"></path></svg>'
//            ];
        }
        return $this;
    }

    /**
     * Konfiguriert die Accordion-Items
     *
     * @param array $itemConfig Item-Konfiguration
     * @return $this
     */
    public function configureItems(array $itemConfig): self
    {
        if (isset($itemConfig['attributes']['class'])) {
            // Speichere zusätzliche CSS-Klassen für Items
            $this->config['item']['additionalClasses'] = $itemConfig['attributes']['class'];
        }
        
        return $this;
    }

    /**
     * Fügt ein Accordion-Item hinzu (Wrapper für parent::addItem)
     *
     * @param string $title Titel des Accordion-Items
     * @param mixed $content Inhalt des Items
     * @param bool $show Initial geöffnet
     * @param array $config Konfiguration für das Item
     * @return $this
     */
    public function addAccordionItem(string $title, $content, bool $show = false, array $config = []): self
    {
        return $this->addItem('accordion-' . uniqid(), $title, $content, $show, $config['trigger'] ?? [], $config['collapse'] ?? [], $config['body'] ?? []);
    }

    /**
     * Fügt mehrere Accordion-Elemente auf einmal hinzu
     *
     * @param array $items Array von Accordion-Elementen
     * @return $this
     */
    public function addItems(array $items): self
    {
        foreach ($items as $item) {
            if (isset($item['header']) && isset($item['content'])) {
                $this->addAccordionItem(
                    $item['header'],
                    $item['content'],
                    $item['show'] ?? false,
                    $item['config'] ?? []
                );
            }
        }
        return $this;
    }

    public function setConfig($key, $value): self
    {
        if (isset($this->config[$key])) {
            $this->config[$key] = $value;
        }
        return $this;
    }

    public function getConfig(): array
    {
        return $this->config;
    }

    /**
     * Fügt ein einzelnes Collapse-Item hinzu
     *
     * @param string $id Eindeutige ID für dieses Item
     * @param string $trigger Trigger-Text oder HTML
     * @param mixed $content Inhalt des ausklappbaren Bereichs
     * @param bool $show Initial geöffnet
     * @param array $triggerConfig Konfiguration für den Trigger
     * @param array $contentConfig Konfiguration für den Content
     * @return $this
     */
    public function addItem(
        string $id,
        string $trigger,
               $content,
        bool $show = false,
        array $triggerConfig = [],
        array $collapseConfig = [],
        array $bodyConfig = []
    ): self {
        $this->items[] = [
            'id' => $id,
            'header' => $trigger,
            'content' => $content,
            'show' => $show,
            'config' => [
                'button' => $triggerConfig,
                'collapseItem' => $collapseConfig,
                'body' => $bodyConfig
            ],
            'hasContent' => !empty($content)
        ];

        return $this;
    }

    /**
     * Erstellt ein einfaches Collapse-Item
     *
     * @param string $trigger Trigger-Text
     * @param mixed $content Inhalt
     * @param bool $show Initial geöffnet
     * @param array $config Gemeinsame Konfiguration
     * @return $this
     */
    public function addSimpleItem(string $trigger, $content, bool $show = false, array $config = []): self
    {
        $id = 'collapse-' . uniqid();
        return $this->addItem($id, $trigger, $content, $show, $config['trigger'] ?? [], $config['collapse'] ?? [], $config['body'] ?? []);
    }

    /**
     * Setzt, ob mehrere Items gleichzeitig offen sein können
     *
     * @param bool $multiple True für mehrere offene Items
     * @return $this
     */
    public function setMultiple(bool $multiple = true): self
    {
        $this->config['multiple'] = $multiple;
        $this->multiple = $multiple;
        if (!$this->multiple) {
            $this->config['accordion']['attributes']['class'] = ['default' => 'accordion'];
        }

        return $this;
    }

    /**
     * Setzt den Parent-Container (für Accordion-ähnliches Verhalten)
     *
     * @param string|null $parent Parent-ID oder null für kein Parent
     * @return $this
     */
    public function setParent(?string $parent): self
    {
        $this->config['parent'] = $parent;
        return $this;
    }

    /**
     * Aktiviert/Deaktiviert Übergangsanimationen
     *
     * @param bool $enabled True für Animationen
     * @return $this
     */
    public function setTransition(bool $enabled = true): self
    {
        $this->config['transition'] = $enabled;
        return $this;
    }

    /**
     * Gibt die Datenstruktur für das Fragment zurück
     *
     * @return array Datenstruktur für das Fragment
     */
    protected function getContentForFragment()
    {
        return $this->items;
    }

    /**
     * Gibt die Konfiguration für das Fragment zurück
     */
    protected function getConfigForFragment(): array
    {
        $parentId = $this->config['parent'] ?? $this->getAttribute('id', 'collapse-group-' . uniqid());
        $this->config['accordion']['attributes']['class'] = array_merge(
            $this->getClasses(),
            $this->config['accordion']['attributes']['class'] ?? []
        );
        $config = [
            'accordion' => $this->config['accordion'],
            'parent' => $parentId,
            'icon' => $this->config['icon'],
            'item' => $this->config['item'],
            'button' => $this->config['button'],
            'headerText' => $this->config['headerText'],
            'headerToggle' => $this->config['headerToggle'],
            'collapseItem' => $this->config['collapseItem'],
            'body' => $this->config['body']
        ];

        if (!$this->multiple) {
            $config['type'] = 'accordion';
            $config['allowMultiple'] = true;
        } else {
            $config['type'] = 'collapse';
            $config['allowMultiple'] = false; // Wichtig: Nur ein Item offen
        }

        return $config;
    }

    /**
     * Setzt eine eindeutige ID für das Accordion
     *
     * @param string $id ID für das Accordion
     * @return $this
     */
    public function setId(string $id): self
    {
        $this->setAttribute('id', $id);
        $this->config['parent'] = $id;
        return $this;
    }

    /**
     * HTML-Rendering für Collapse/Accordion
     */
    protected function renderHtml(): string
    {
        if (empty($this->items)) {
            return '';
        }

        $accordionId = $this->getAttribute('id') ?: 'accordion_' . uniqid();
        $html = '';
        
        // Accordion Container - exakt wie Original
        $html .= '<div class="accordion" id="' . $accordionId . '">';
        
        foreach ($this->items as $index => $item) {
            if (!$item['hasContent']) continue;

            $itemId = $item['id'];
            $collapseId = 'collapse-' . $accordionId . '_' . $index;
            $isFirst = ($index === 0);
            
            // Accordion Item - mit zusätzlichen CSS-Klassen aus Konfiguration
            $itemClass = 'accordion-item';
            if (isset($this->config['item']['additionalClasses'])) {
                foreach ($this->config['item']['additionalClasses'] as $key => $value) {
                    $itemClass .= ' ' . $value;
                }
            }
            $html .= '<div class="' . $itemClass . '" data-accordion-item="' . $itemId . '">';
            
            // Button Header - exakt wie Original (Button direkt im Item, nicht in separatem Header)
            $buttonClass = 'accordion-header accordion-button';
            if (!$item['show'] && !$isFirst) {
                $buttonClass .= ' collapsed';
            }
            
            $html .= '<button class="' . $buttonClass . '" type="button" ';
            $html .= 'data-bs-toggle="collapse" data-bs-target="#' . $collapseId . '" ';
            $html .= 'aria-expanded="' . ($item['show'] || $isFirst ? 'true' : 'false') . '">';
            
            // Header Text INNERHALB des Buttons - exakt wie Original
            $headerTextClass = 'accordion-header-text lh-140';
            $html .= '<h4 class="' . $headerTextClass . '">' . $item['header'] . '</h4>';
            
            // Toggle Icon - exakt wie Original
            $html .= '<div class="accordion-header-toggle accordion-header-toggle-icon"></div>';
            
            $html .= '</button>';
            
            // Collapse Content - exakt wie Original
            $collapseClass = 'accordion-collapse collapse accordion-collapse';
            if ($item['show'] || $isFirst) {
                $collapseClass .= ' show';
            }
            
            $html .= '<div class="' . $collapseClass . '" id="' . $collapseId . '" data-bs-parent="#' . $accordionId . '">';
            
            // Body - exakt wie Original
            $bodyClass = 'accordion-body accordion-body ck-content';
            $html .= '<div class="' . $bodyClass . '">';
            $html .= $item['content'];
            $html .= '</div>';
            
            $html .= '</div>'; // collapse
            $html .= '</div>'; // item
        }
        
        $html .= '</div>'; // accordion
        
        return $html;
    }
}