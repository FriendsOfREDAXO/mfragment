<?php

namespace FriendsOfRedaxo\MFragment\Components\Default;

use FriendsOfRedaxo\MFragment\Components\AbstractComponent;

/**
 * Komponente für ungeordnete, geordnete und Beschreibungs-Listen
 *
 * Diese Komponente nutzt renderHtml() für optimales Performance-Rendering
 * und supportet alle Standard-HTML-Listen-Typen: ul, ol, dl
 */
class ListElement extends AbstractComponent
{
    /**
     * Typ der Liste
     *
     * @var string ul|ol|dl
     */
    protected string $listType = 'ul';

    /**
     * Liste der Items
     *
     * @var array
     */
    protected array $items = [];

    /**
     * Attribute für einzelne List-Items
     *
     * @var array
     */
    protected array $itemAttributes = [];

    /**
     * Spezifische Attribute für Terme (nur bei dl)
     *
     * @var array
     */
    protected array $termAttributes = [];

    /**
     * Spezifische Attribute für Beschreibungen (nur bei dl)
     *
     * @var array
     */
    protected array $descriptionAttributes = [];

    /**
     * Konstruktor
     *
     * @param string $listType Typ der Liste (ul, ol, dl)
     */
    public function __construct(string $listType = 'ul')
    {
         // Kein Fragment, wir nutzen renderHtml()
        $this->setListType($listType);
    }

    /**
     * Factory-Methode für ungeordnete Liste
     *
     * @param array $items Listenelemente
     * @param array $attributes Attribute für die Liste
     * @param array $itemAttributes Attribute für einzelne Items
     * @return static
     */
    public static function createUnordered(array $items = [], array $attributes = [], array $itemAttributes = []): self
    {
        return self::factory()
            ->setListType('ul')
            ->setItems($items)
            ->setAttributes($attributes)
            ->setItemAttributes($itemAttributes);
    }

    /**
     * Factory-Methode für geordnete Liste
     *
     * @param array $items Listenelemente
     * @param array $attributes Attribute für die Liste
     * @param array $itemAttributes Attribute für einzelne Items
     * @return static
     */
    public static function createOrdered(array $items = [], array $attributes = [], array $itemAttributes = []): self
    {
        return self::factory()
            ->setListType('ol')
            ->setItems($items)
            ->setAttributes($attributes)
            ->setItemAttributes($itemAttributes);
    }

    /**
     * Factory-Methode für Beschreibungsliste
     *
     * @param array $items Array mit Term => Beschreibung Paaren
     * @param array $attributes Attribute für die Liste
     * @param array $termAttributes Attribute für Terme
     * @param array $descriptionAttributes Attribute für Beschreibungen
     * @return static
     */
    public static function createDescription(
        array $items = [],
        array $attributes = [],
        array $termAttributes = [],
        array $descriptionAttributes = []
    ): self {
        return self::factory()
            ->setListType('dl')
            ->setItems($items)
            ->setAttributes($attributes)
            ->setTermAttributes($termAttributes)
            ->setDescriptionAttributes($descriptionAttributes);
    }

    /**
     * Setzt den Listen-Typ
     *
     * @param string $listType ul, ol oder dl
     * @return $this
     */
    public function setListType(string $listType): self
    {
        if (in_array($listType, ['ul', 'ol', 'dl'])) {
            $this->listType = $listType;
        }
        return $this;
    }

    /**
     * Gibt den Listen-Typ zurück
     *
     * @return string
     */
    public function getListType(): string
    {
        return $this->listType;
    }

    /**
     * Setzt alle Items
     *
     * @param array $items Listenelemente
     * @return $this
     */
    public function setItems(array $items): self
    {
        $this->items = $items;
        return $this;
    }

    /**
     * Fügt ein Item hinzu
     *
     * @param mixed $item Item (String oder ComponentInterface)
     * @param string|null $term Term für dl-Listen
     * @return $this
     */
    public function addItem($item, ?string $term = null): self
    {
        if ($this->listType === 'dl' && $term !== null) {
            $this->items[$term] = $item;
        } else {
            $this->items[] = $item;
        }
        return $this;
    }

    /**
     * Gibt alle Items zurück
     *
     * @return array
     */
    public function getItems(): array
    {
        return $this->items;
    }

    /**
     * Setzt Item-Attribute
     *
     * @param array $itemAttributes
     * @return $this
     */
    public function setItemAttributes(array $itemAttributes): self
    {
        $this->itemAttributes = $itemAttributes;
        return $this;
    }

    /**
     * Setzt Term-Attribute (nur für dl)
     *
     * @param array $termAttributes
     * @return $this
     */
    public function setTermAttributes(array $termAttributes): self
    {
        $this->termAttributes = $termAttributes;
        return $this;
    }

    /**
     * Setzt Beschreibungs-Attribute (nur für dl)
     *
     * @param array $descriptionAttributes
     * @return $this
     */
    public function setDescriptionAttributes(array $descriptionAttributes): self
    {
        $this->descriptionAttributes = $descriptionAttributes;
        return $this;
    }

    /**
     * Fügt Bootstrap-Container-Klassen hinzu
     *
     * @param bool $responsive Responsive Layout
     * @return $this
     */
    public function setBootstrapListGroup(bool $responsive = false): self
    {
        if ($this->listType === 'ul') {
            $this->addClass('list-group');
            if ($responsive) {
                $this->addClass('list-group-flush');
            }

            // List-group-item für alle Items
            $this->itemAttributes = array_merge($this->itemAttributes, [
                'class' => 'list-group-item'
            ]);
        }
        return $this;
    }

    /**
     * Rendert die Liste
     *
     * @return string HTML-String der Liste
     */
    protected function renderHtml(): string
    {
        if (empty($this->items)) {
            return '';
        }

        $output = '';
        $attributesStr = $this->buildAttributesString();

        switch ($this->listType) {
            case 'ul':
            case 'ol':
                $output .= "<{$this->listType}{$attributesStr}>" . PHP_EOL;

                foreach ($this->items as $item) {
                    $itemAttrsStr = $this->buildAttributesString($this->itemAttributes);
                    $itemContent = $this->processContent($item);
                    $output .= "  <li{$itemAttrsStr}>{$itemContent}</li>" . PHP_EOL;
                }

                $output .= "</{$this->listType}>";
                break;

            case 'dl':
                $output .= "<dl{$attributesStr}>" . PHP_EOL;

                foreach ($this->items as $term => $description) {
                    $termAttrsStr = $this->buildAttributesString($this->termAttributes);
                    $descAttrsStr = $this->buildAttributesString($this->descriptionAttributes);

                    $termContent = $this->processContent($term);
                    $descContent = $this->processContent($description);

                    $output .= "  <dt{$termAttrsStr}>{$termContent}</dt>" . PHP_EOL;
                    $output .= "  <dd{$descAttrsStr}>{$descContent}</dd>" . PHP_EOL;
                }

                $output .= "</dl>";
                break;
        }

        return $output;
    }
}