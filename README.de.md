# MFragment - Strukturierte HTML-Generierung für REDAXO

[![REDAXO Version](https://img.shields.io/badge/REDAXO-%3E%3D5.10-red.svg)](https://redaxo.org)
[![PHP Version](https://img.shields.io/badge/PHP-%3E%3D7.4-blue.svg)](https://php.net)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

> **Programmatische HTML-Strukturen für moderne REDAXO-Websites**

MFragment ist ein REDAXO-Addon zur strukturierten HTML-Generierung mit komponentenorientierter Architektur. Es ermöglicht das programmatische Erstellen von HTML-Strukturen, responsiver Medienverwaltung und Bootstrap 5 Integration.

## Hauptfunktionen

### **Strukturierte HTML-Generierung**
- **Programmatische HTML-Erstellung** - HTML-Strukturen mit PHP-Code erstellen
- **Direktes HTML-Rendering** - Keine Template-Engine erforderlich
- **Bootstrap 5 Integration** - Umfasst Standard-Bootstrap-Komponenten
- **Method Chaining** - Fluent API-Design für verbesserte Entwicklererfahrung

### **Eigene Komponenten erstellen**
- **Erweiterbare Architektur** - Eigene Komponenten durch Vererbung von AbstractComponent
- **Integration in MFragment** - Alle MFragment-Werkzeuge stehen zur Verfügung
- **HTML-Element-Erstellung** - Beliebige HTML-Strukturen mit MFragment-Methoden erstellen
- **Modularer Aufbau** - Komponenten können in allen Kontexten verwendet werden

### **HTML-Struktur-Generierung**
**Wie MForm für Formulare, ist MFragment für HTML-Strukturen** - HTML-Layouts programmatisch erstellen:

- **Vollständige HTML-Abdeckung** - Generierung beliebiger HTML-Elemente, Attribute und Strukturen
- **Verschachtelte Komponenten** - Komplexe Layouts mit unbegrenzter Verschachtelungstiefe
- **Dynamische Inhaltsgenerierung** - HTML programmatisch basierend auf Daten generieren
- **Layout-Systeme** - Von einfachen Divs bis zu komplexen Grid-Systemen und Komponenten
- **Template-Alternative** - Statische Templates durch dynamische PHP-Strukturen ersetzen

### **Responsives Media-System**
- **360 Media Manager Typen** - Vollständiges responsives Bildsystem
- **4 Bildserien** - `small`, `half`, `full`, `hero` für jeden Anwendungsfall
- **Automatische WebP-Konvertierung** - 25-35% kleinere Dateien für bessere Performance
- **Bootstrap 5 Breakpoints** - Perfekte Integration mit modernen Grid-Systemen
- **Hero-Serie** - Vollbild-Bilder bis 1920px für moderne Websites

### **Performance-Eigenschaften**
- **Direktes HTML-Rendering** - Keine Template-Engine erforderlich
- **Performance-Monitoring** - Render-Zeiten messbar
- **Datenbankabfragen-Optimierung** - Request-lokale Zwischenspeicherung für Media Manager Types
- **Speicher-schonend** - Geringer Ressourcenverbrauch

### **Entwicklererfahrung**
- **Dokumentierte APIs** - Gut dokumentierte Schnittstellen mit Typ-Hints
- **Debug-Modus** - Detaillierte Entwicklungsinformationen
- **IDE-Unterstützung** - Vollständige Typ-Hints und Dokumentation
- **Erweiterbar** - Einfache Erstellung eigener Komponenten

## Installation

### Via REDAXO Installer
1. Gehe zu **System → Pakete**
2. Suche nach "MFragment"
3. Klicke **Installieren**

### Manuelle Installation
1. Lade die neueste Version von [GitHub](https://github.com/FriendsOfREDAXO/mfragment) herunter
2. Extrahiere nach `redaxo/src/addons/mfragment/`
3. Installiere über das REDAXO Backend

### Media Manager Typen (Empfohlen)
Installiere das umfassende responsive Media-System:

```sql
-- Import über REDAXO SQL Import
source install/responsive_complete_system.sql
```

Dies fügt **360 responsive Media Manager Typen** mit automatischer WebP-Konvertierung hinzu.

## Schnellstart

### Grundlegende Komponenten-Verwendung

```php
<?php
use FriendsOfRedaxo\MFragment\Components\Bootstrap\Card;
use FriendsOfRedaxo\MFragment\Components\Default\Figure;

// Erstelle eine Bootstrap Card mit responsivem Bild
$card = Card::factory()
    ->setHeader('Willkommen bei MFragment')
    ->setBody('Erstelle moderne Websites mit Komponenten-Architektur.')
    ->setImage('hero-image.jpg', 'full_16x9')
    ->addClass('shadow-sm');

echo $card->show();
```

### Responsive Image Helper

```php
<?php
use FriendsOfRedaxo\MFragment\Components\Default\Figure;

// Generiere responsives picture Element
$responsiveBild = Figure::factory()
    ->setMedia('hero-background.jpg')
    ->setMediaManagerType('hero_16x9')  // Nutze Hero-Serie für Vollbild
    ->enableAutoResponsive()
    ->addClass('hero-bg');

echo $responsiveBild->show();
```

### Erweiterte Komponenten-Beispiele

```php
<?php
use FriendsOfRedaxo\MFragment\Components\Bootstrap\Carousel;
use FriendsOfRedaxo\MFragment\Components\Default\Figure;

$carousel = Carousel::factory('hero-carousel')
    ->addSlide(
        Figure::factory()
            ->setMedia('slide1.jpg')
            ->setMediaManagerType('hero_21x9')
            ->setCaption('Moderne Web-Entwicklung')
            ->addClass('carousel-image')
    )
    ->addSlide(
        Figure::factory()
            ->setMedia('slide2.jpg')
            ->setMediaManagerType('hero_21x9')
            ->setCaption('Responsive Design')
    )
    ->setControls(true)
    ->setIndicators(true)
    ->setAutoplay(5000);

echo $carousel->show();
```

## Verfügbare Komponenten

### Bootstrap 5 Komponenten
- **Card** - Inhaltskarten mit Bildern, Headern und Aktionen
- **Carousel** - Bild- und Inhalts-Slider
- **Modal** - Overlay-Dialoge und Lightboxen
- **Accordion** - Zusammenklappbare Inhaltsabschnitte
- **Tabs** - Tab-Navigation für Inhalte
- **Alert** - Benachrichtigungen und Meldungen
- **Badge** - Status-Indikatoren und Labels
- **Progress** - Fortschrittsbalken und Ladeindikatoren
- **Collapse** - Ausklappbare Inhaltsbereiche

### Standard-Komponenten
- **Figure** - Bilder mit Bildunterschriften und responsivem Verhalten
- **HTMLElement** - Generische HTML-Elemente mit Attribut-Management
- **ListElement** - Geordnete und ungeordnete Listen
- **Table** - Datentabellen mit responsiven Features

## Responsives Media-System

### Überblick der Bildserien

| Serie | Breakpoints | Anwendung | Beispiele |
|-------|-------------|-----------|-----------|
| **small** | 320-768px | Thumbnails, Icons | Avatare, kleine Vorschaubilder |
| **half** | 320-1400px | Inhaltsbilder | Artikel-Bilder, Galerien |
| **full** | 320-1400px | Große Inhalte | Hero-Bereiche, Hauptbilder |
| **hero** | 768-1920px | Vollbild-Bereiche | Header, Landing Pages |

### Unterstützte Seitenverhältnisse
- **1:1** - Quadratische Bilder (Avatare, Thumbnails)
- **4:3** - Standard-Fotos (Inhaltsbilder)
- **16:9** - Video-Format (Hero-Bereiche, Medien)
- **21:9** - Kinoformat (Vollbild-Header)
- **3:2** - Fotografie-Standard
- **5:2** - Breite Banner

### Verwendungsbeispiele

```php
// Hero-Header mit Video-Seitenverhältnis
rex_media_manager::getUrl('hero_16x9_max_1920', 'header-bg.jpg')

// Inhaltsbild für Artikel
rex_media_manager::getUrl('half_4x3_768', 'article-image.jpg')

// Kleines Thumbnail
rex_media_manager::getUrl('small_1x1_320', 'avatar.jpg')

// Vollbild-Kinoformat
rex_media_manager::getUrl('hero_21x9_max_1920', 'cinema-bg.jpg')
```

## Eigene Komponenten erstellen

### Grundprinzip

MFragment ermöglicht es Ihnen, **beliebige HTML-Strukturen** mit den integrierten Mitteln zu erstellen. Sie können eigene Komponenten entwickeln, die sich nahtlos in das System integrieren und alle MFragment-Features nutzen.

### Einfache eigene Komponente

```php
<?php
namespace App\Components;

use FriendsOfRedaxo\MFragment\Components\AbstractComponent;

class MyComponent extends AbstractComponent
{
    protected string $title = '';
    protected string $content = '';
    
    public function setTitle(string $title): self
    {
        $this->title = $title;
        return $this;
    }
    
    public function setContent(string $content): self
    {
        $this->content = $content;
        return $this;
    }
    
    protected function renderHtml(): string
    {
        return '<div' . $this->buildAttributesString() . '>
            <h2>' . htmlspecialchars($this->title) . '</h2>
            <div class="content">' . $this->content . '</div>
        </div>';
    }
}
```

### Erweiterte Komponente mit verschachtelten Elementen

```php
<?php
namespace App\Components;

use FriendsOfRedaxo\MFragment\Components\AbstractComponent;
use FriendsOfRedaxo\MFragment\Components\Default\HTMLElement;
use FriendsOfRedaxo\MFragment\Components\Default\Figure;

class ProductCard extends AbstractComponent
{
    private string $productName = '';
    private string $price = '';
    private string $imageUrl = '';
    private array $features = [];
    
    public function setProductName(string $name): self
    {
        $this->productName = $name;
        return $this;
    }
    
    public function setPrice(string $price): self
    {
        $this->price = $price;
        return $this;
    }
    
    public function setImage(string $imageUrl): self
    {
        $this->imageUrl = $imageUrl;
        return $this;
    }
    
    public function addFeature(string $label, string $value): self
    {
        $this->features[] = ['label' => $label, 'value' => $value];
        return $this;
    }
    
    protected function renderHtml(): string
    {
        // Use other MFragment components
        $image = Figure::factory()
            ->setMedia($this->imageUrl)
            ->setMediaManagerType('half_4x3')
            ->enableLazyLoading()
            ->addClass('product-image');
            
        $features = '';
        foreach ($this->features as $feature) {
            $features .= '<li><strong>' . htmlspecialchars($feature['label']) . ':</strong> ' . htmlspecialchars($feature['value']) . '</li>';
        }
        
        return '<div' . $this->buildAttributesString() . '>
            ' . $image->show() . '
            <div class="product-info">
                <h3>' . htmlspecialchars($this->productName) . '</h3>
                <div class="price">' . htmlspecialchars($this->price) . '</div>
                ' . ($features ? '<ul class="features">' . $features . '</ul>' : '') . '
            </div>
        </div>';
    }
}
```

### Komponente mit MFragment Container

```php
<?php
namespace App\Components;

use FriendsOfRedaxo\MFragment;
use FriendsOfRedaxo\MFragment\Components\AbstractComponent;
use FriendsOfRedaxo\MFragment\Components\Bootstrap\Card;
use FriendsOfRedaxo\MFragment\Components\Default\HTMLElement;

class Dashboard extends AbstractComponent
{
    private array $cards = [];
    
    public function addCard(string $title, string $content, string $icon = ''): self
    {
        $this->cards[] = [
            'title' => $title,
            'content' => $content,
            'icon' => $icon
        ];
        return $this;
    }
    
    protected function renderHtml(): string
    {
        $mfragment = MFragment::factory();
        
        // Container for dashboard
        $container = HTMLElement::factory('div')
            ->addClass('dashboard-grid');
            
        // Add each card as Bootstrap Card
        foreach ($this->cards as $card) {
            $cardComponent = Card::factory()
                ->setHeader($card['title'])
                ->setBody($card['content'])
                ->addClass('dashboard-card');
                
            if ($card['icon']) {
                $cardComponent->prependContent('<i class="' . $card['icon'] . '"></i>');
            }
            
            $mfragment->addComponent($cardComponent);
        }
        
        $container->setContent($mfragment->show());
        
        return '<div' . $this->buildAttributesString() . '>' . 
               $container->show() . 
               '</div>';
    }
}
```

### Komponente verwenden

```php
// Simple usage
$myComponent = MyComponent::factory()
    ->setTitle('My Title')
    ->setContent('My Content')
    ->addClass('custom-style');

echo $myComponent->show();

// Advanced product card
$productCard = ProductCard::factory()
    ->setProductName('Gaming Laptop')
    ->setPrice('€ 1,299.00')
    ->setImage('laptop.jpg')
    ->addFeature('Processor', 'Intel Core i7')
    ->addFeature('RAM', '16 GB DDR4')
    ->addFeature('Graphics', 'NVIDIA RTX 3060')
    ->addClass('product-card shadow');

echo $productCard->show();

// Dashboard with multiple cards
$dashboard = Dashboard::factory()
    ->addCard('Users', '1,234 active users', 'fas fa-users')
    ->addCard('Revenue', '€ 45,678.90', 'fas fa-chart-line')
    ->addCard('Orders', '89 new orders', 'fas fa-shopping-cart')
    ->addClass('admin-dashboard');

echo $dashboard->show();
```

### Integration in MFragment

Eigene Komponenten können in allen MFragment-Kontexten verwendet werden:

```php
$mfragment = MFragment::factory()
    ->addComponent($myComponent)
    ->addCard(Card::factory()->setHeader('Standard Card'))
    ->addComponent($productCard)
    ->addDiv('Additional content');

echo $mfragment->show();
```

## HTML-Strukturen erstellen

**MFragment ist für HTML, was MForm für Formulare ist** - HTML-Layouts programmatisch erstellen:

### Komplexes Layout-Beispiel
```php
// Erstelle ein vollständiges Artikel-Layout
$article = MFragment::factory()
    ->addDiv(
        MFragment::factory()
            ->addHeading(1, 'Artikel-Titel', ['class' => 'display-4'])
            ->addParagraph('Veröffentlicht am ' . date('j. F Y'), ['class' => 'text-muted'])
            ->addClass('article-header'),
        ['class' => 'container mb-4']
    )
    ->addDiv(
        MFragment::factory()
            ->addDiv(
                MFragment::factory()
                    ->addParagraph('Artikel-Einleitung...')
                    ->addImage('/media/hero-image.jpg', 'Hero-Bild', ['class' => 'img-fluid rounded'])
                    ->addParagraph('Hauptinhalt des Artikels...'),
                ['class' => 'col-lg-8']
            )
            ->addDiv(
                MFragment::factory()
                    ->addHeading(3, 'Verwandte Artikel')
                    ->addList(['Artikel 1', 'Artikel 2', 'Artikel 3'], 'ul', ['class' => 'list-unstyled'])
                    ->addButton('Abonnieren', 'button', ['class' => 'btn btn-primary']),
                ['class' => 'col-lg-4']
            ),
        ['class' => 'container']
    );

echo $article->show();
```

### Dynamisches Navigationsmenü
```php
// Erstelle Navigation aus Datenbankdaten
$navigation = MFragment::factory()->addClass('navbar-nav');

foreach ($menuItems as $item) {
    $link = MFragment::factory()
        ->addLink($item['title'], $item['url'], [
            'class' => 'nav-link' . ($item['active'] ? ' active' : ''),
            'aria-current' => $item['active'] ? 'page' : null
        ]);
    
    $navigation->addDiv($link, ['class' => 'nav-item']);
}

echo $navigation->show();
```

### Formular mit Validierungsanzeige
```php
// Komplexe Formularstruktur mit dynamischer Fehlerbehandlung
$form = MFragment::factory()
    ->addTagElement('form', 
        MFragment::factory()
            ->addDiv(
                MFragment::factory()
                    ->addTagElement('label', 'E-Mail-Adresse', ['for' => 'email', 'class' => 'form-label'])
                    ->addTagElement('input', null, [
                        'type' => 'email',
                        'class' => 'form-control' . ($hasEmailError ? ' is-invalid' : ''),
                        'id' => 'email',
                        'name' => 'email'
                    ])
                    ->addDiv($emailError ?? '', ['class' => 'invalid-feedback']),
                ['class' => 'mb-3']
            )
            ->addDiv(
                MFragment::factory()
                    ->addButton('Senden', 'submit', ['class' => 'btn btn-primary'])
                    ->addButton('Abbrechen', 'button', ['class' => 'btn btn-secondary ms-2']),
                ['class' => 'd-flex justify-content-end']
            ),
        ['method' => 'post', 'action' => '/submit']
    );

echo $form->show();
```

### Datenbasierte Komponentenlisten
```php
// Generiere Strukturen basierend auf Daten
$productGrid = MFragment::factory()->addClass('row g-4');

foreach ($products as $product) {
    $card = MFragment::factory()
        ->addDiv(
            MFragment::factory()
                ->addDiv(
                    MFragment::factory()
                        ->addImage($product['image'], $product['title'], ['class' => 'card-img-top'])
                        ->addDiv(
                            MFragment::factory()
                                ->addHeading(5, $product['title'], ['class' => 'card-title'])
                                ->addParagraph($product['description'], ['class' => 'card-text'])
                                ->addDiv(
                                    MFragment::factory()
                                        ->addSpan($product['price'], ['class' => 'h5 text-primary'])
                                        ->addButton('In Warenkorb', 'button', [
                                            'class' => 'btn btn-outline-primary btn-sm ms-2',
                                            'data-product-id' => $product['id']
                                        ]),
                                    ['class' => 'd-flex justify-content-between align-items-center']
                                ),
                            ['class' => 'card-body']
                        ),
                    ['class' => 'card h-100']
                ),
            ['class' => 'col-md-6 col-lg-4']
        );
    
    $productGrid->addComponent($card);
}

echo $productGrid->show();
```

### API-Referenz

Alle Komponenten erben diese Methoden:

### Basis-Methoden für alle Komponenten

Alle Komponenten erben diese Methoden:

```php
// Attribut-Management
->setAttribute(string $name, mixed $value)
->addClass(string $class)
->setId(string $id)
->setData(string $key, mixed $value)

// Inhalt-Management  
->setContent(string $content)
->appendContent(string $content)
->prependContent(string $content)

// Rendering
->show(): string
->__toString(): string
```

### Responsive Image Helpers

```php
// Generiere srcset für responsive Bilder
generateSrcset(string $mediaFile, string $baseType): string

// Generiere sizes-Attribut
generateSizesForType(string $baseType): string

// Generiere vollständiges picture Element
generateResponsivePicture(string $mediaFile, array $options): string
```

## Erweiterte Konfiguration

### Eigene Komponenten erstellen und ablegen

MFragment bietet mehrere Möglichkeiten, eigene Komponenten zu organisieren:

#### 1. Projekt-Komponenten (Empfohlen)
**Verzeichnis:** `src/components/`  
**Namespace:** Frei wählbar (z.B. `App\Components\`, `MyProject\Components\`)

```
src/components/
├── Cards/
│   ├── ProductCard.php      -> App\Components\Cards\ProductCard
│   └── NewsCard.php         -> MyProject\Components\Cards\NewsCard
├── Navigation/
│   ├── MainMenu.php         -> App\Components\Navigation\MainMenu
│   └── Breadcrumb.php       -> YourNamespace\Components\Navigation\Breadcrumb
└── Layout/
    ├── Hero.php             -> App\Components\Layout\Hero
    └── Footer.php           -> CustomNamespace\Components\Layout\Footer
```

#### 2. Theme-Komponenten (mit Theme-Addon)
**Verzeichnis:** `src/addons/theme/components/` oder `src/addons/theme/private/components/`  
**Namespace:** Frei wählbar (z.B. `Theme\Components\`, `MyTheme\Components\`)

```
src/addons/theme/components/
├── Sections/
│   └── HeroSection.php      -> Theme\Components\Sections\HeroSection
└── Widgets/
    └── ContactWidget.php    -> MyTheme\Components\Widgets\ContactWidget
```

#### 3. Addon-Komponenten (für Addon-Entwickler)
**Verzeichnis:** `src/addons/{addon_name}/components/`  
**Namespace:** Frei wählbar entsprechend Ihrem Addon-Namespace

```
src/addons/myproject/components/
├── Custom/
│   └── SpecialComponent.php -> MyProject\Components\Custom\SpecialComponent
```

### Komponente erstellen - Schritt für Schritt

#### 1. Datei erstellen
```php
<?php
// Datei: src/components/Cards/ProductCard.php
namespace YourNamespace\Components\Cards;

use FriendsOfRedaxo\MFragment\Components\AbstractComponent;

class ProductCard extends AbstractComponent
{
    private string $title = '';
    private string $price = '';
    
    public function setTitle(string $title): self
    {
        $this->title = $title;
        return $this;
    }
    
    public function setPrice(string $price): self
    {
        $this->price = $price;
        return $this;
    }
    
    protected function renderHtml(): string
    {
        return '<div' . $this->buildAttributesString() . '>
            <h3>' . htmlspecialchars($this->title) . '</h3>
            <span class="price">' . htmlspecialchars($this->price) . '</span>
        </div>';
    }
}
```

#### 2. Komponente verwenden
```php
<?php
use YourNamespace\Components\Cards\ProductCard;

// Direkte Nutzung
$card = ProductCard::factory()
    ->setTitle('Gaming Laptop')
    ->setPrice('€ 1,299.00')
    ->addClass('product-card');

echo $card->show();

// In MFragment Container
$container = MFragment::factory()
    ->addComponent($card)
    ->addClass('product-grid');
```

### Automatisches Laden

MFragment lädt Komponenten automatisch, wenn sie korrekt platziert sind:

```php
// Diese Verzeichnisse werden automatisch gescannt:
src/components/                         -> Ihr gewählter Namespace
theme_addon_path/components/            -> Ihr Theme-Namespace
theme_addon_path/private/components/    -> Ihr Theme-Namespace
src/addons/mfragment/components/        -> FriendsOfRedaxo\MFragment\Components\*
```

**Wichtig:** 
- Der Namespace ist frei wählbar
- Die Namespace-Struktur muss der Verzeichnisstruktur entsprechen
- Composer-Autoload oder entsprechende Konfiguration erforderlich

## Debugging

### Debug-Modus

Debug-Ausgabe für die Entwicklung aktivieren:

```php
// Im Development-Environment
\FriendsOfRedaxo\MFragment\Core\RenderEngine::enableDebug();

// Komponenten geben Debug-Informationen aus
$card = Card::factory()->setHeader('Debug Card')->show();
// Ausgabe: <!-- MFragment Debug: Card rendered in 0.5ms -->
```

### Performance-Optimierung

```php
// Performance-Monitoring im Development aktivieren
if (rex::isDebugMode()) {
    \FriendsOfRedaxo\MFragment\Core\RenderEngine::enableDebug();
}

// Performance-Statistiken abrufen
$stats = \FriendsOfRedaxo\MFragment\Core\RenderEngine::getStats();
echo "Render-Aufrufe: " . $stats['renderCalls'];
echo "Gesamtzeit: " . $stats['processingTime'] . "ms";
```

### Performance-Monitoring

```php
// Detaillierte Performance-Statistiken abrufen
$engine = \FriendsOfRedaxo\MFragment\Core\RenderEngine::getInstance();
$stats = $engine->getDetailedStats();

foreach ($stats['components'] as $component => $data) {
    echo "{$component}: {$data['count']} Renders, {$data['time']}ms gesamt\n";
}
```

### Media Manager Tests

```php
// Test der responsive Bild-Generierung
$srcset = generateSrcset('test.jpg', 'hero_16x9');
assertNotEmpty($srcset);
assertStringContains('hero_16x9_768', $srcset);
```

## Optionale Abhängigkeiten
- **FOR Html** - Erweiterte HTML-Generierung (automatisch erkannt)
- **Media Manager** - Für responsive Bildfunktionalität

## Lizenz

Dieses Projekt ist unter der MIT-Lizenz lizenziert - siehe die [LICENSE](LICENSE)-Datei für Details.

## Support

- **Dokumentation**: [https://github.com/FriendsOfREDAXO/mfragment/wiki](https://github.com/FriendsOfREDAXO/mfragment/wiki)
- **Issues**: [https://github.com/FriendsOfREDAXO/mfragment/issues](https://github.com/FriendsOfREDAXO/mfragment/issues)  
- **Community**: [REDAXO Slack](https://redaxo.org/slack/)

## Credits

**MFragment** wird entwickelt und gepflegt von [Friends Of REDAXO](https://github.com/FriendsOfREDAXO).
