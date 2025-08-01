<?php
# path: src/addons/mfragment/lib/MFragment/MFragmentElements.php
namespace FriendsOfRedaxo\MFragment;

use FriendsOfRedaxo\MFragment;
use FriendsOfRedaxo\MFragment\Components\Bootstrap\Badge;
use FriendsOfRedaxo\MFragment\Components\Bootstrap\Card;
use FriendsOfRedaxo\MFragment\Components\Bootstrap\Carousel;
use FriendsOfRedaxo\MFragment\Components\Bootstrap\Modal;
use FriendsOfRedaxo\MFragment\Components\Bootstrap\Progress;
use FriendsOfRedaxo\MFragment\Components\Bootstrap\Tabs;
use FriendsOfRedaxo\MFragment\Components\ComponentInterface;
use FriendsOfRedaxo\MFragment\Components\Default\Downloads;
use FriendsOfRedaxo\MFragment\Components\Default\DownloadsWithIcons;
use FriendsOfRedaxo\MFragment\DTO\MFragmentItem;
use FriendsOfRedaxo\MFragment\Components\Default\Figure;
use FriendsOfRedaxo\MFragment\Components\Default\HTMLElement;
use rex_media;

//use FriendsOfRedaxo\MFragment\Components\Heading;
use FriendsOfRedaxo\MFragment\Components\Default\ListElement;
//use FriendsOfRedaxo\MFragment\Components\Default\Table;

/**
 * Basisklasse für die Erstellung von HTML-Elementen und Komponenten
 *
 * Diese Klasse bietet Methoden zum Hinzufügen von HTML-Elementen und Komponenten
 * zu einem MFragment und zur Ausgabe des resultierenden HTML-Codes.
 */
abstract class MFragmentElements
{
    /**
     * Array für die Items des MFragment
     * Kann verschiedene Typen enthalten:
     * - String: Direktes HTML
     * - ComponentInterface: HTML-Komponenten
     * - MFragmentItem: Für Fragmente
     * - MFragment: Für verschachtelte Fragmente
     */
    public array $items = [];

    /**
     * Fügt ein HTML-Tag-Element hinzu
     *
     * @param string $tag HTML-Tag (z.B. 'div', 'p', 'h1')
     * @param ComponentInterface|MFragment|array|string|null $content Inhalt des Elements
     * @param array $attributes Attribute für das Element
     * @return $this Für Method Chaining
     */
    public function addTagElement(string $tag, ComponentInterface|MFragment|array|string|null $content, array $attributes = []): self
    {
        $this->items[] = HTMLElement::create($tag, $content, $attributes);
        return $this;
    }

    /**
     * Fügt eine Überschrift hinzu
     *
     * @param int $level Überschriftebene (1-6)
     * @param ComponentInterface|MFragment|array|string|null $content Inhalt der Überschrift
     * @param array $attributes Attribute für das Element
     * @return $this Für Method Chaining
     */
    public function addHeading(int $level = 1, ComponentInterface|MFragment|array|string|null $content = '', array $attributes = []): self
    {
        if ($level < 1 || $level > 6) {
            $level = 1; // Standard auf h1
        }
        $this->items[] = HTMLElement::create("h".$level, $content, $attributes);
        return $this;
    }

    /**
     * Fügt einen Paragraphen hinzu
     *
     * @param ComponentInterface|MFragment|array|string|null $content Inhalt des Paragraphen
     * @param array $attributes Attribute für das Element
     * @return $this Für Method Chaining
     */
    public function addParagraph(ComponentInterface|MFragment|array|string|null $content, array $attributes = []): self
    {
        $this->items[] = HTMLElement::create('p', $content, $attributes);
        return $this;
    }

    /**
     * Fügt ein Div-Element hinzu
     *
     * @param ComponentInterface|MFragment|array|string|null $content Inhalt des Div-Elements
     * @param array $attributes Attribute für das Element
     * @return $this Für Method Chaining
     */
    public function addDiv(ComponentInterface|MFragment|array|string|null $content, array $attributes = []): self
    {
        $this->items[] = HTMLElement::create('div', $content, $attributes);
        return $this;
    }

    /**
     * Fügt ein Span-Element hinzu
     *
     * @param ComponentInterface|MFragment|array|string|null $content Inhalt des Span-Elements
     * @param array $attributes Attribute für das Element
     * @return $this Für Method Chaining
     */
    public function addSpan(ComponentInterface|MFragment|array|string|null $content, array $attributes = []): self
    {
        $this->items[] = HTMLElement::create('span', $content, $attributes);
        return $this;
    }

    /**
     * Fügt eine Liste hinzu
     *
     * @param array $items Listenelemente
     * @param string $type Listentyp ('ul' oder 'ol')
     * @param array $attributes Attribute für das Listenelement
     * @param array $itemAttributes Attribute für die Listenelemente
     * @return $this Für Method Chaining
     */
    public function addList(array $items, string $type = 'ul', array $attributes = [], array $itemAttributes = []): self
    {
        $list = $type === 'ol'
            ? ListElement::createOrdered($items, $attributes, $itemAttributes)
            : ListElement::createUnordered($items, $attributes, $itemAttributes);

        $this->items[] = $list;
        return $this;
    }

    /**
     * Fügt eine ungeordnete Liste hinzu
     *
     * @param array $items Listenelemente
     * @param array $attributes Attribute für das Listenelement
     * @param array $itemAttributes Attribute für die Listenelemente
     * @return $this Für Method Chaining
     */
    public function addUl(array $items, array $attributes = [], array $itemAttributes = []): self
    {
//        $this->items[] = ListElement::createUnordered($items, $attributes, $itemAttributes);
        return $this;
    }

    /**
     * Fügt eine geordnete Liste hinzu
     *
     * @param array $items Listenelemente
     * @param array $attributes Attribute für das Listenelement
     * @param array $itemAttributes Attribute für die Listenelemente
     * @return $this Für Method Chaining
     */
    public function addOl(array $items, array $attributes = [], array $itemAttributes = []): self
    {
//        $this->items[] = ListElement::createOrdered($items, $attributes, $itemAttributes);
        return $this;
    }

    /**
     * Fügt eine Beschreibungsliste hinzu
     *
     * @param array $items Array mit Schlüssel-Wert-Paaren (Term => Description)
     * @param array $attributes Attribute für die Liste
     * @param array $termAttributes Attribute für die Begriffe
     * @param array $descriptionAttributes Attribute für die Beschreibungen
     * @return $this Für Method Chaining
     */
    public function addDl(array $items, array $attributes = [], array $termAttributes = [], array $descriptionAttributes = []): self
    {
//        $this->items[] = ListElement::createDescription($items, $attributes, $termAttributes, $descriptionAttributes);
        return $this;
    }

    /**
     * Fügt einen Link hinzu
     *
     * @param ComponentInterface|MFragment|array|string|null $content Inhalt des Links
     * @param string $href URL des Links
     * @param array $attributes Attribute für das Element
     * @return $this Für Method Chaining
     */
    public function addLink(ComponentInterface|MFragment|array|string|null $content, string $href, array $attributes = []): self
    {
        $attributes['href'] = $href;
        $this->items[] = HTMLElement::create('a', $content, $attributes);
        return $this;
    }

    /**
     * Fügt einen Button hinzu
     *
     * @param ComponentInterface|MFragment|array|string|null $content Inhalt des Buttons
     * @param string $type Button-Typ (z.B. 'button', 'submit', 'reset')
     * @param array $attributes Attribute für das Element
     * @return $this Für Method Chaining
     */
    public function addButton(ComponentInterface|MFragment|array|string|null $content, string $type = 'button', array $attributes = []): self
    {
        $attributes['type'] = $type;
        $this->items[] = HTMLElement::create('button', $content, $attributes);
        return $this;
    }

    /**
     * Fügt ein Bild hinzu
     *
     * @param string $src Bild-URL
     * @param string $alt Alternativer Text
     * @param array $attributes Attribute für das Element
     * @return $this Für Method Chaining
     */
    public function addImage(string $src, string $alt = '', array $attributes = []): self
    {
        // Automatische Alt-Text Generierung wenn leer
        if (empty($alt)) {
            $alt = $this->generateAltTextFromSrc($src);
        }
        
        $attributes = array_merge(['src' => $src, 'alt' => $alt], $attributes);
        $this->items[] = HTMLElement::create('img', null, $attributes);
        return $this;
    }

    /**
     * Fügt ein dekoratives Bild hinzu (mit leerem Alt-Attribut)
     *
     * @param string $src Bild-URL
     * @param array $attributes Attribute für das Element
     * @return $this Für Method Chaining
     */
    public function addDecorativeImage(string $src, array $attributes = []): self
    {
        $attributes = array_merge(['src' => $src, 'alt' => '', 'role' => 'presentation'], $attributes);
        $this->items[] = HTMLElement::create('img', null, $attributes);
        return $this;
    }

    /**
     * Generiert automatisch Alt-Text basierend auf der Bildquelle
     *
     * @param string $src Bildquelle
     * @return string Generierter Alt-Text
     */
    private function generateAltTextFromSrc(string $src): string
    {
        // Extrahiere Dateiname ohne Pfad und Erweiterung
        $filename = pathinfo($src, PATHINFO_FILENAME);
        
        // Prüfe konfigurierte Icon-Mappings (falls vorhanden)
        $iconMappings = $this->getIconMappings();
        if (!empty($iconMappings) && isset($iconMappings[$filename])) {
            return $iconMappings[$filename];
        }
        
        // Generische Fallback-Logik
        return $this->generateGenericAltText($filename, $src);
    }

    /**
     * Holt konfigurierte Icon-Mappings aus REDAXO Config
     *
     * @return array Icon-Mappings
     */
    private function getIconMappings(): array
    {
        // Prüfe ob REDAXO verfügbar ist
        if (class_exists('rex_addon')) {
            $addon = \rex_addon::get('mfragment');
            if ($addon && $addon->isAvailable()) {
                return $addon->getConfig('icon_alt_mappings', []);
            }
        }
        
        return [];
    }

    /**
     * Generiert generischen Alt-Text aus Dateiname
     *
     * @param string $filename Dateiname ohne Erweiterung
     * @param string $src Vollständige Bildquelle
     * @return string Generierter Alt-Text
     */
    private function generateGenericAltText(string $filename, string $src): string
    {
        // Bereinige Dateinamen für lesbaren Alt-Text
        $altText = str_replace(['_', '-'], ' ', $filename);
        $altText = ucwords($altText);
        
        // Erkenne häufige Icon-Patterns
        if (str_contains($filename, 'arrow') || str_contains($filename, 'pfeil')) {
            $altText = $this->enhanceArrowAltText($altText);
        } elseif (str_contains($filename, 'mail') || str_contains($filename, 'email')) {
            $altText = str_replace(['Mail', 'Email'], 'E-Mail', $altText);
        } elseif (str_contains($filename, 'close') || str_contains($filename, 'schließen')) {
            $altText = 'Schließen';
        } elseif (str_contains($filename, 'search') || str_contains($filename, 'suche')) {
            $altText = 'Suchen';
        } elseif (str_contains($filename, 'phone') || str_contains($filename, 'call') || str_contains($filename, 'telefon')) {
            $altText = 'Telefon';
        }
        
        // Füge "Icon" hinzu wenn es sich um SVG handelt
        if (str_ends_with(strtolower($src), '.svg') && !str_contains(strtolower($altText), 'icon')) {
            $altText .= ' Icon';
        }
        
        return $altText;
    }

    /**
     * Verbessert Alt-Text für Pfeil-Icons
     *
     * @param string $altText Basis Alt-Text
     * @return string Verbesserter Alt-Text
     */
    private function enhanceArrowAltText(string $altText): string
    {
        if (str_contains($altText, 'Rechts') || str_contains($altText, 'Right')) {
            return 'Pfeil nach rechts';
        } elseif (str_contains($altText, 'Links') || str_contains($altText, 'Left')) {
            return 'Pfeil nach links';
        } elseif (str_contains($altText, 'Up') || str_contains($altText, 'Oben')) {
            return 'Pfeil nach oben';
        } elseif (str_contains($altText, 'Down') || str_contains($altText, 'Unten')) {
            return 'Pfeil nach unten';
        }
        
        return $altText;
    }

    /**
     * Fügt ein HTML-Fragment hinzu
     *
     * @param string $html HTML-Inhalt
     * @return $this Für Method Chaining
     */
    public function addHtml(string $html): self
    {
        if (!empty($html)) {
            $this->items[] = $html;
        }
        return $this;
    }

    /**
     * Fügt ein Fragment-Element hinzu
     *
     * @param string $element Name des Fragments
     * @param ComponentInterface|MFragment|array|string|null $content Inhalt des Fragments
     * @param array $config Konfiguration für das Fragment
     * @return $this Für Method Chaining
     */
    public function addFragment(string $element, ComponentInterface|MFragment|array|string|null $content, array $config = []): self
    {
        if ($content === null) return $this;

        $this->items[] = new MFragmentItem(false, $element, $content, $config, []);
        return $this;
    }

    /**
     * Fügt ein MFragment-Objekt hinzu
     *
     * @param MFragment $fragment Fragment-Objekt
     * @return $this Für Method Chaining
     */
    public function addMFragment(MFragment $fragment): self
    {
        if (!$fragment->isEmpty()) {
            $this->items[] = $fragment;
        }
        return $this;
    }

    /**
     * Fügt eine Komponente hinzu
     *
     * @param ComponentInterface $component Komponenten-Objekt
     * @return $this Für Method Chaining
     */
    public function addComponent(ComponentInterface $component): self
    {
        $this->items[] = $component;
        return $this;
    }

    /**
     * Fügt ein Section-Element hinzu (ohne automatischen Container)
     *
     * @param ComponentInterface|MFragment|array|string|null $content Inhalt der Section
     * @param array $attributes Attribute für das Element
     * @return $this Für Method Chaining
     */
    public function addSection(ComponentInterface|MFragment|array|string|null $content, array $attributes = []): self
    {
        if (!isset($attributes['class'])) {
            $attributes['class'] = 'section';
        }
        $this->items[] = HTMLElement::create('section', $content, $attributes);
        return $this;
    }

    /**
     * Fügt ein Container-Element hinzu
     *
     * @param ComponentInterface|MFragment|array|string|null $content Inhalt des Containers
     * @param array $attributes Attribute für das Element
     * @return $this Für Method Chaining
     */
    public function addContainer(ComponentInterface|MFragment|array|string|null $content, array $attributes = []): self
    {
        // Standardklasse hinzufügen, falls keine gesetzt ist
        if (!isset($attributes['class'])) {
            $attributes['class'] = 'container-xl';
        }
        $this->items[] = HTMLElement::create('div', $content, $attributes);
        return $this;
    }

    /**
     * Fügt ein Row-Element hinzu
     *
     * @param ComponentInterface|MFragment|array|string|null $content Inhalt der Row
     * @param array $attributes Attribute für das Element
     * @return $this Für Method Chaining
     */
    public function addRow(ComponentInterface|MFragment|array|string|null $content, array $attributes = []): self
    {
        // Standardklasse hinzufügen
        if (!isset($attributes['class'])) {
            $attributes['class'] = 'row';
        }
        $this->items[] = HTMLElement::create('div', $content, $attributes);
        return $this;
    }

    /**
     * Fügt ein Column-Element hinzu
     *
     * @param ComponentInterface|MFragment|array|string|null $content Inhalt der Spalte
     * @param array $attributes Attribute für das Element
     * @return $this Für Method Chaining
     */
    public function addCol(ComponentInterface|MFragment|array|string|null $content, array $attributes = []): self
    {
        // Standardklasse hinzufügen
        if (!isset($attributes['class'])) {
            $attributes['class'] = 'col';
        }
        $this->items[] = HTMLElement::create('div', $content, $attributes);
        return $this;
    }

    /**
     * Fügt ein Ribbon-Element hinzu
     *
     * @param ComponentInterface|MFragment|array|string|null $content Inhalt des Ribbons
     * @param array $attributes Attribute für das Element
     * @return $this Für Method Chaining
     */
    public function addRibbon(ComponentInterface|MFragment|array|string|null $content, array $attributes = []): self
    {
        if (!isset($attributes['class'])) {
            $attributes['class'] = 'ribbon';
        }
        $this->items[] = HTMLElement::create('div', $content, $attributes);
        return $this;
    }

    /**
     * Fügt ein Nav-Element hinzu
     *
     * @param ComponentInterface|MFragment|array|string|null $content Inhalt des Nav-Elements
     * @param array $attributes Attribute für das Element
     * @return $this Für Method Chaining
     */
    public function addNav(ComponentInterface|MFragment|array|string|null $content, array $attributes = []): self
    {
        $this->items[] = HTMLElement::create('nav', $content, $attributes);
        return $this;
    }

    /**
     * Fügt ein Header-Element hinzu
     *
     * @param ComponentInterface|MFragment|array|string|null $content Inhalt des Header-Elements
     * @param array $attributes Attribute für das Element
     * @return $this Für Method Chaining
     */
    public function addHeader(ComponentInterface|MFragment|array|string|null $content, array $attributes = []): self
    {
        $this->items[] = HTMLElement::create('header', $content, $attributes);
        return $this;
    }

    /**
     * Fügt ein Footer-Element hinzu
     *
     * @param ComponentInterface|MFragment|array|string|null $content Inhalt des Footer-Elements
     * @param array $attributes Attribute für das Element
     * @return $this Für Method Chaining
     */
    public function addFooter(ComponentInterface|MFragment|array|string|null $content, array $attributes = []): self
    {
        $this->items[] = HTMLElement::create('footer', $content, $attributes);
        return $this;
    }

    /**
     * Fügt ein Main-Element hinzu
     *
     * @param ComponentInterface|MFragment|array|string|null $content Inhalt des Main-Elements
     * @param array $attributes Attribute für das Element
     * @return $this Für Method Chaining
     */
    public function addMain(ComponentInterface|MFragment|array|string|null $content, array $attributes = []): self
    {
        $this->items[] = HTMLElement::create('main', $content, $attributes);
        return $this;
    }

    /**
     * Fügt ein Aside-Element hinzu
     *
     * @param ComponentInterface|MFragment|array|string|null $content Inhalt des Aside-Elements
     * @param array $attributes Attribute für das Element
     * @return $this Für Method Chaining
     */
    public function addAside(ComponentInterface|MFragment|array|string|null $content, array $attributes = []): self
    {
        $this->items[] = HTMLElement::create('aside', $content, $attributes);
        return $this;
    }

    /**
     * Fügt ein Article-Element hinzu
     *
     * @param ComponentInterface|MFragment|array|string|null $content Inhalt des Article-Elements
     * @param array $attributes Attribute für das Element
     * @return $this Für Method Chaining
     */
    public function addArticle(ComponentInterface|MFragment|array|string|null $content, array $attributes = []): self
    {
        $this->items[] = HTMLElement::create('article', $content, $attributes);
        return $this;
    }

    /**
     * Fügt ein Audio-Element hinzu
     *
     * @param string $src Audio-URL
     * @param bool $controls Ob Steuerelemente angezeigt werden sollen
     * @param array $attributes Attribute für das Element
     * @return $this Für Method Chaining
     */
    public function addAudio(string $src, bool $controls = true, array $attributes = []): self
    {
        $attributes['src'] = $src;
        if ($controls) {
            $attributes['controls'] = true;
        }

        $this->items[] = HTMLElement::create('audio', null, $attributes);
        return $this;
    }

    /**
     * Fügt ein Video-Element hinzu
     *
     * @param string $src Video-URL
     * @param bool $controls Ob Steuerelemente angezeigt werden sollen
     * @param array $attributes Attribute für das Element
     * @return $this Für Method Chaining
     */
    public function addVideo(string $src, bool $controls = true, array $attributes = []): self
    {
        $attributes['src'] = $src;
        if ($controls) {
            $attributes['controls'] = true;
        }

        $this->items[] = HTMLElement::create('video', null, $attributes);
        return $this;
    }

    /**
     * Fügt ein Blockquote-Element hinzu
     *
     * @param ComponentInterface|MFragment|array|string|null $content Inhalt des Blockquote-Elements
     * @param string $cite Zitierquelle
     * @param array $attributes Attribute für das Element
     * @return $this Für Method Chaining
     */
    public function addBlockquote(ComponentInterface|MFragment|array|string|null $content, string $cite = '', array $attributes = []): self
    {
        if (!empty($cite)) {
            $attributes['cite'] = $cite;
        }

        $this->items[] = HTMLElement::create('blockquote', $content, $attributes);
        return $this;
    }

    /**
     * Fügt ein Code-Element hinzu
     *
     * @param string $content Inhalt des Code-Elements
     * @param array $attributes Attribute für das Element
     * @return $this Für Method Chaining
     */
    public function addCode(string $content, array $attributes = []): self
    {
        $this->items[] = HTMLElement::create('code', $content, $attributes);
        return $this;
    }

    /**
     * Fügt ein Pre-Element hinzu
     *
     * @param string $content Inhalt des Pre-Elements
     * @param array $attributes Attribute für das Element
     * @return $this Für Method Chaining
     */
    public function addPre(string $content, array $attributes = []): self
    {
        $this->items[] = HTMLElement::create('pre', $content, $attributes);
        return $this;
    }

    /**
     * Fügt ein Hr-Element hinzu
     *
     * @param array $attributes Attribute für das Element
     * @return $this Für Method Chaining
     */
    public function addHr(array $attributes = []): self
    {
        $this->items[] = HTMLElement::create('hr', null, $attributes);
        return $this;
    }

    /**
     * Fügt eine Tabelle hinzu
     *
     * @param array $body Tabelleninhalt
     * @param array $header Tabellenkopf
     * @param array $footer Tabellenfuß
     * @param array $attributes Attribute für die Tabelle
     * @return $this Für Method Chaining
     */
    public function addTable(array $body, array $header = [], array $footer = [], array $attributes = []): self
    {
//        $this->items[] = Table::create($body, $header, $footer, $attributes);
        return $this;
    }

    /**
     * Fügt eine Figure hinzu
     *
     * @param Figure|rex_media|string $figure Figure-Komponente, REX Media Objekt oder Medienname
     * @param array $attributes Attribute für das Figure-Element (veraltet, verwende Figure-Objekt)
     * @param array $config Konfiguration für das Figure-Fragment (veraltet, verwende Figure-Objekt)
     * @return $this Für Method Chaining
     */
    public function addFigure($figure, array $attributes = [], array $config = []): self
    {
        // Option 1: Medienname oder rex_media -> Figure-Objekt erstellen
        if (is_string($figure) || $figure instanceof rex_media) {
            $figureComponent = Figure::factory()->setMedia($figure);

            // Legacy-Support: Attribute/Config übernehmen (deprecated)
            if (!empty($attributes)) {
                foreach ($attributes as $name => $value) {
                    $figureComponent->setAttribute($name, $value);
                }
            }

            if (!empty($config)) {
                // Legacy-Support für config-Aufbau
                if (isset($config['figure']['attributes']['class'])) {
                    foreach ((array)$config['figure']['attributes']['class'] as $class) {
                        $figureComponent->addFigureClass($class);
                    }
                }

                if (isset($config['media']['mediaManagerType'])) {
                    $figureComponent->setMediaManagerType($config['media']['mediaManagerType']);
                }

                if (isset($config['media']['lazyLoading'])) {
                    $figureComponent->enableLazyLoading($config['media']['lazyLoading']);
                }

                if (isset($config['lightbox'])) {
                    $figureComponent->enableLightbox(
                        true,
                        $config['lightboxClass'] ?? null,
                        $config['lightboxGallery'] ?? null
                    );
                }

                if (isset($config['link'])) {
                    $figureComponent->setLink($config['link']);
                }
            }

            $this->items[] = $figureComponent;
            return $this;
        }

        // Option 2: Figure-Komponente direkt übergeben
        if ($figure instanceof Figure) {
            $this->items[] = $figure;
            return $this;
        }

        return $this;
    }

    /**
     * Fügt ein Accordion hinzu (erbt von Collapse)
     *
     * @param array|null $items Elemente des Akkordeons
     * @param array $attributes Attribute für das Akkordeon-Wrapper-Element
     * @param array $config Konfiguration für das Accordion
     * @return $this Für Method Chaining
     */
    public function addAccordion(?array $items, array $attributes = [], array $config = []): self
    {
        if (!is_array($items) || empty($items)) return $this;

        // Nutze die Accordion-Komponente (erbt von Collapse)
        $accordion = \FriendsOfRedaxo\MFragment\Components\Bootstrap\Accordion::create();

        // Items hinzufügen
        $accordion->addItems($items);

        // Attribute setzen
        if (!empty($attributes)) {
            $accordion->setAttributes($attributes);
        }

        // Config übernehmen
        if (isset($config['icon'])) {
            $accordion->configureToggle($config['icon']);
        }

        if (isset($config['header'])) {
            $accordion->configureHeader(
                $config['header']['tag'] ?? 'h3',
                $config['header']['attributes'] ?? [],
                $config['header']['textTag'] ?? null,
                $config['header']['textClass'] ?? null
            );
        }

        $this->items[] = $accordion;
        return $this;
    }

    /**
     * Fügt ein Collapse-Element hinzu (Basis-Implementierung)
     *
     * @param array|null $items Elemente des Collapse
     * @param array $attributes Attribute für das Collapse-Wrapper-Element
     * @param array $config Konfiguration für das Collapse
     * @return $this Für Method Chaining
     */
    public function addCollapse(?array $items, array $attributes = [], array $config = []): self
    {
        if (!is_array($items) || empty($items)) return $this;

        // Nutze die Collapse-Komponente
        $collapse = \FriendsOfRedaxo\MFragment\Components\Bootstrap\Collapse::create(
            $config['multiple'] ?? true
        );

        // Items hinzufügen
        foreach ($items as $item) {
            if (!isset($item['header']) || !isset($item['content'])) continue;

            $collapse->addItem(
                $item['id'] ?? 'collapse-' . uniqid(),
                $item['header'],
                $item['content'],
                $item['show'] ?? false,
                $item['config']['trigger'] ?? [],
                $item['config']['collapse'] ?? [],
                $config['body'] ?? []
            );
        }

        // Attribute setzen
        if (!empty($attributes)) {
            $collapse->setAttributes($attributes);
        }

        // Config übernehmen
        if (isset($config['parent'])) {
            $collapse->setParent($config['parent']);
        }

        if (isset($config['transition'])) {
            $collapse->setTransition($config['transition']);
        }

        $this->items[] = $collapse;
        return $this;
    }

    /**
     * Fügt ein Tabs-Element hinzu
     *
     * @param array $tabs Tabs für das Tab-Element
     * @param array $config Konfiguration für das Tabs-Element
     * @param array $attributes Attribute für das Tabs-Element
     * @return $this Für Method Chaining
     */
    public function addTabs(array $tabs, array $config = [], array $attributes = []): self
    {
        $tabsComponent = Tabs::create();

        // Konfiguration setzen
        if (isset($config['type'])) $tabsComponent->setType($config['type']);
        if (isset($config['fill'])) $tabsComponent->setFill($config['fill']);
        if (isset($config['justified'])) $tabsComponent->setJustified($config['justified']);
        if (isset($config['position'])) $tabsComponent->setPosition($config['position']);
        if (isset($config['vertical'])) $tabsComponent->setVertical($config['vertical']);
        if (isset($config['fade'])) $tabsComponent->setFade($config['fade']);

        // Attribute setzen
        foreach ($attributes as $name => $value) {
            $tabsComponent->setAttribute($name, $value);
        }

        // Tabs hinzufügen
        foreach ($tabs as $tab) {
            if (isset($tab['title']) && isset($tab['content'])) {
                $tabsComponent->addTab(
                    $tab['title'],
                    $tab['content'],
                    $tab['active'] ?? false,
                    $tab['attributes'] ?? [],
                    $tab['titleAttributes'] ?? []
                );
            }
        }

        $this->items[] = $tabsComponent;
        return $this;
    }

    /**
     * Fügt eine Karte hinzu
     *
     * @param ComponentInterface|MFragment|array|string $card Card-Komponente oder Inhalt
     * @param array $attributes Attribute für das Card-Element
     * @param array $config Konfiguration für das Card-Fragment
     * @return $this Für Method Chaining
     */
    public function addCard($card, array $attributes = [], array $config = []): self
    {
        // Attribute in config integrieren
        if (!empty($attributes)) {

            if (!isset($config['card'])) {
                $config['card'] = [];
            }
            if (!isset($config['card']['attributes'])) {
                $config['card']['attributes'] = [];
            }
            $config['card']['attributes'] = array_merge($config['card']['attributes'], $attributes);
        }

        if (!empty($attributes['class'])) {
            $card->setClass($attributes['class']);
            unset($attributes['class']);
            if (!empty($attributes)) {
                $card->setAttributes($attributes);
            }
        }

        // Wenn eine Card-Komponente übergeben wurde
        if ($card instanceof Card) {
            if (!empty($config) && is_array($config)) {
                foreach ($config as $key => $value) {
                    $card->setConfig($key, $value);
                }
            }

            // Komponente direkt hinzufügen
            $this->items[] = $card;
            return $this;
        }

        // Wenn ein Array mit vordefinierter Struktur übergeben wurde
        if (is_array($card) && (
                isset($card['header']) ||
                isset($card['body']) ||
                isset($card['footer']) ||
                isset($card['image']) ||
                isset($card['ribbon'])
            )) {
            $this->addFragment('bootstrap/card', $card, $config);
            return $this;
        }

        // Sonst interpretieren wir den Inhalt als Body
        $this->addFragment('bootstrap/card', [
            'body' => ['content' => $card]
        ], $config);

        return $this;
    }

    /**
     * Fügt ein Karussell hinzu
     *
     * @param array $slides Slides für das Karussell
     * @param array $config Konfiguration für das Karussell
     * @param array $attributes Attribute für das Karussell-Element
     * @return $this Für Method Chaining
     */
    public function addCarousel(array $slides, array $config = [], array $attributes = []): self
    {
        $carousel = Carousel::create();

        // Konfiguration setzen
        if (isset($config['controls'])) $carousel->showControls($config['controls']);
        if (isset($config['indicators'])) $carousel->showIndicators($config['indicators']);
        if (isset($config['autoplay'])) $carousel->setAutoplay($config['autoplay'], $config['interval'] ?? 5000);
        if (isset($config['fade'])) $carousel->useFade($config['fade']);
        if (isset($config['captionPosition'])) $carousel->setCaptionPosition($config['captionPosition']);
        if (isset($config['height'])) $carousel->setHeight($config['height']);

        // Attribute setzen
        foreach ($attributes as $name => $value) {
            $carousel->setAttribute($name, $value);
        }

        // Slides hinzufügen
        foreach ($slides as $slide) {
            if (isset($slide['type']) && $slide['type'] === 'content' && isset($slide['content'])) {
                $carousel->addContentSlide($slide['content'], $slide['attributes'] ?? []);
            } else if (isset($slide['image'])) {
                $image = $slide['image'];
                $caption = $slide['caption'] ?? '';
                $slideAttributes = $slide['attributes'] ?? [];
                $carousel->addSlide($image, $caption, $slideAttributes);
            }
        }

        $this->items[] = $carousel;
        return $this;
    }

    /**
     * Fügt ein Modal-Fenster hinzu
     *
     * @param ComponentInterface|MFragment|array|string|null $content Inhalt des Modals
     * @param string|null $title Titel des Modals
     * @param ComponentInterface|string|MFragment|null $footer Footer-Inhalt des Modals
     * @param array $config Konfiguration für das Modal
     * @param array $attributes Attribute für das Modal-Element
     * @return $this Für Method Chaining
     */
    public function addModal(ComponentInterface|MFragment|array|string|null $content, ?string $title = null, $footer = null, array $config = [], array $attributes = []): self
    {
        $modal = Modal::create($content, $title, $footer);

        // Konfiguration setzen
        if (isset($config['size'])) $modal->setSize($config['size']);
        if (isset($config['position'])) $modal->setPosition($config['position']);
        if (isset($config['scrollable'])) $modal->setScrollable($config['scrollable']);
        if (isset($config['staticBackdrop'])) $modal->setStaticBackdrop($config['staticBackdrop']);
        if (isset($config['animation'])) $modal->setAnimation($config['animation']);
        if (isset($config['showCloseButton'])) $modal->showCloseButton($config['showCloseButton']);
        if (isset($config['openOnRender'])) $modal->setOpenOnRender($config['openOnRender']);

        // Close Button hinzufügen, wenn konfiguriert
        if (isset($config['closeButton']) && $config['closeButton']) {
            $closeText = $config['closeButtonText'] ?? 'Schließen';
            $closeClasses = $config['closeButtonClasses'] ?? ['btn', 'btn-secondary'];
            $modal->addCloseButton($closeText, $closeClasses);
        }

        // Confirm Button hinzufügen, wenn konfiguriert
        if (isset($config['confirmButton']) && $config['confirmButton']) {
            $confirmText = $config['confirmButtonText'] ?? 'Bestätigen';
            $confirmOnClick = $config['confirmButtonOnClick'] ?? null;
            $confirmClasses = $config['confirmButtonClasses'] ?? ['btn', 'btn-primary'];
            $modal->addConfirmButton($confirmText, $confirmOnClick, $confirmClasses);
        }

        // Trigger Button konfigurieren, wenn vorhanden
        if (isset($config['triggerButton'])) {
            $modal->setTriggerButton(
                $config['triggerButton']['text'] ?? 'Öffnen',
                $config['triggerButton']['classes'] ?? ['btn', 'btn-primary']
            );
        }

        // Attribute setzen
        foreach ($attributes as $name => $value) {
            $modal->setAttribute($name, $value);
        }

        $this->items[] = $modal;
        return $this;
    }

    /**
     * Fügt einen Badge hinzu
     *
     * @param string $text Badge-Text
     * @param string $variant Bootstrap-Variante (primary, secondary, success, danger, warning, info, light, dark)
     * @param array $config Badge-Konfiguration
     * @return $this Für Method Chaining
     */
    public function addBadge(string $text, string $variant = 'secondary', array $config = []): self
    {
        $badge = Badge::create($text, $variant);

        // Konfiguration anwenden
        if (isset($config['type'])) {
            $badge->setType($config['type']);
        }

        if (isset($config['pill']) && $config['pill']) {
            $badge->setType('pill');
        }

        if (isset($config['positioned'])) {
            $badge->setPositioned($config['positioned'], $config['position'] ?? null);
        }

        if (isset($config['icon'])) {
            $badge->setIcon($config['icon'], $config['iconAfter'] ?? false);
        }

        if (isset($config['dismissible'])) {
            $badge->setDismissible($config['dismissible']);
        }

        // Attribute setzen
        if (isset($config['attributes'])) {
            $badge->setAttributes($config['attributes']);
        }

        $this->items[] = $badge;
        return $this;
    }

    /**
     * Fügt einen Badge als Pill hinzu (Shortcut)
     *
     * @param string $text Badge-Text
     * @param string $variant Bootstrap-Variante
     * @param array $config Zusätzliche Konfiguration
     * @return $this Für Method Chaining
     */
    public function addBadgePill(string $text, string $variant = 'secondary', array $config = []): self
    {
        $config['pill'] = true;
        return $this->addBadge($text, $variant, $config);
    }

    /**
     * Fügt einen Counter-Badge hinzu (für Benachrichtigungen)
     *
     * @param int|string $count Anzahl oder Text
     * @param string $variant Bootstrap-Variante
     * @param bool $positioned Absolute Positionierung
     * @return $this Für Method Chaining
     */
    public function addBadgeCounter($count, string $variant = 'danger', bool $positioned = true): self
    {
        $this->items[] = Badge::counter($count, $variant, $positioned);
        return $this;
    }

    /**
     * Fügt einen Fortschrittsbalken hinzu
     *
     * @param int|float $value Fortschrittswert (0-100)
     * @param string $variant Bootstrap-Variante
     * @param array $config Progress-Konfiguration
     * @return $this Für Method Chaining
     */
    public function addProgress($value = 0, string $variant = 'primary', array $config = []): self
    {
        $progress = Progress::create($value, $variant);

        // Konfiguration anwenden
        if (isset($config['height'])) {
            $progress->setHeight($config['height']);
        }

        if (isset($config['showLabel'])) {
            $progress->showLabel($config['showLabel']);
        }

        if (isset($config['animated'])) {
            $progress->setAnimated($config['animated']);
        }

        if (isset($config['striped'])) {
            $progress->setStriped($config['striped']);
        }

        if (isset($config['stacked']) && $config['stacked']) {
            $progress->setStacked(true);

            // Zusätzliche Werte für gestapelten Progress
            if (isset($config['values']) && is_array($config['values'])) {
                foreach ($config['values'] as $valueData) {
                    if (isset($valueData['value'])) {
                        $progress->addValue(
                            $valueData['value'],
                            $valueData['variant'] ?? 'primary',
                            $valueData['label'] ?? null
                        );
                    }
                }
            }
        }

        // Attribute setzen
        if (isset($config['attributes'])) {
            $progress->setAttributes($config['attributes']);
        }

        $this->items[] = $progress;
        return $this;
    }

    /**
     * Fügt einen gestapelten Fortschrittsbalken hinzu (Shortcut)
     *
     * @param array $values Array mit Werten und Varianten
     * @param array $config Zusätzliche Konfiguration
     * @return $this Für Method Chaining
     */
    public function addProgressStacked(array $values, array $config = []): self
    {
        $this->items[] = Progress::stacked($values);

        // Zusätzliche Konfiguration
        if (!empty($config)) {
            $progress = end($this->items);
            if ($progress instanceof Progress) {
                if (isset($config['height'])) {
                    $progress->setHeight($config['height']);
                }

                if (isset($config['showLabel'])) {
                    $progress->showLabel($config['showLabel']);
                }

                if (isset($config['animated'])) {
                    $progress->setAnimated($config['animated']);
                }

                if (isset($config['striped'])) {
                    $progress->setStriped($config['striped']);
                }

                if (isset($config['attributes'])) {
                    $progress->setAttributes($config['attributes']);
                }
            }
        }

        return $this;
    }


# path: src/addons/mfragment/lib/MFragment/MFragmentElements.php (Ergänzung)

// Ergänzung für die MFragmentElements Klasse - neue Downloads-Methoden

    /**
     * Fügt eine Downloads-Sektion hinzu
     *
     * @param array $downloads Array von Downloads (rex_media, Arrays oder Strings)
     * @param string $title Titel der Downloads-Sektion
     * @param array $config Konfiguration für die Downloads
     * @return $this Für Method Chaining
     */
    public function addDownloads(array $downloads, string $title = 'Downloads', array $config = []): self
    {
        $component = Downloads::create($downloads)
            ->setTitle($title);

        // Konfiguration anwenden
        if (isset($config['listType'])) {
            $component->setListType($config['listType']);
        }

        if (isset($config['listAttributes'])) {
            $component->setListAttributes($config['listAttributes']);
        }

        if (isset($config['linkAttributes'])) {
            $component->setLinkAttributes($config['linkAttributes']);
        }

        if (isset($config['titleAttributes'])) {
            $component->setTitleAttributes($config['titleAttributes']);
        }

        if (isset($config['wrapperAttributes'])) {
            $component->setWrapperAttributes($config['wrapperAttributes']);
        }

        if (isset($config['hideTitle']) && $config['hideTitle']) {
            $component->hideTitle();
        }

        $this->items[] = $component;
        return $this;
    }

    /**
     * Fügt Downloads mit Icons hinzu
     *
     * @param array $downloads Array von Downloads
     * @param string $title Titel der Downloads-Sektion
     * @param array $config Konfiguration für die Downloads
     * @return $this Für Method Chaining
     */
    public function addDownloadsWithIcons(array $downloads, string $title = 'Downloads', array $config = []): self
    {
        $component = DownloadsWithIcons::createWithIcons($downloads)
            ->setTitle($title);

        // Basis-Konfiguration anwenden
        if (isset($config['listType'])) {
            $component->setListType($config['listType']);
        }

        if (isset($config['listAttributes'])) {
            $component->setListAttributes($config['listAttributes']);
        }

        if (isset($config['linkAttributes'])) {
            $component->setLinkAttributes($config['linkAttributes']);
        }

        if (isset($config['titleAttributes'])) {
            $component->setTitleAttributes($config['titleAttributes']);
        }

        if (isset($config['wrapperAttributes'])) {
            $component->setWrapperAttributes($config['wrapperAttributes']);
        }

        if (isset($config['hideTitle']) && $config['hideTitle']) {
            $component->hideTitle();
        }

        // Icon-spezifische Konfiguration
        if (isset($config['showIcons'])) {
            $component->showIcons($config['showIcons']);
        }

        if (isset($config['showFilesize'])) {
            $component->showFilesize($config['showFilesize']);
        }

        if (isset($config['iconStyle'])) {
            $component->setIconStyle($config['iconStyle']);
        }

        if (isset($config['customIcons'])) {
            $component->setCustomIcons($config['customIcons']);
        }

        $this->items[] = $component;
        return $this;
    }

    /**
     * Fügt Downloads aus Media-IDs hinzu (für Rückwärtskompatibilität)
     *
     * @param string $mediaIds Komma-getrennte Media-IDs
     * @param string $title Titel der Downloads-Sektion
     * @param array $config Konfiguration
     * @return $this Für Method Chaining
     */
    public function addDownloadsFromMediaIds(string $mediaIds, string $title = 'Downloads', array $config = []): self
    {
        // Entscheiden zwischen normalen Downloads und Icon-Downloads
        $withIcons = $config['withIcons'] ?? false;

        if ($withIcons) {
            $component = DownloadsWithIcons::fromMediaIds($mediaIds);
            unset($config['withIcons']); // Config-Key entfernen
            return $this->addDownloadsWithIcons($component->getDownloads(), $title, $config);
        } else {
            $component = Downloads::fromMediaIds($mediaIds);
            return $this->addDownloads($component->getDownloads(), $title, $config);
        }
    }

    /**
     * Gibt alle Elemente zurück
     *
     * @return array Alle Items (Strings, ComponentInterface, MFragmentItems, MFragment-Objekte)
     */
    public function getItems(): array
    {
        return $this->items;
    }

    /**
     * Prüft ob Elemente vorhanden sind
     *
     * @return bool
     */
    public function isEmpty(): bool
    {
        return empty($this->items);
    }
}