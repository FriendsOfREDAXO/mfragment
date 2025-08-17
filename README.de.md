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

#### Hero-Section mit Card-Grid

```php
<?php
use FriendsOfRedaxo\MFragment\Components\Bootstrap\Card;
use FriendsOfRedaxo\MFragment\Components\Bootstrap\Carousel;
use FriendsOfRedaxo\MFragment\Components\Default\Figure;
use FriendsOfRedaxo\MFragment;

// Hero-Carousel mit responsiven Bildern
$heroCarousel = Carousel::factory('hero-carousel')
    ->addSlide(
        Figure::factory()
            ->setMedia('slide1.jpg')
            ->setMediaManagerType('hero_21x9')
            ->setCaption('Moderne Web-Entwicklung mit MFragment')
            ->addClass('carousel-image')
    )
    ->addSlide(
        Figure::factory()
            ->setMedia('slide2.jpg')
            ->setMediaManagerType('hero_21x9')  
            ->setCaption('Responsive Design für alle Geräte')
    )
    ->setControls(true)
    ->setIndicators(true)
    ->setAutoplay(5000)
    ->addClass('hero-section');

// Service-Cards Grid
$servicesGrid = MFragment::factory()
    ->addDiv(
        MFragment::factory()
            ->addDiv(
                Card::factory()
                    ->setImage('service-webdev.jpg', 'full_4x3')
                    ->setHeader('Web-Entwicklung')
                    ->setBody('Moderne Websites mit REDAXO und MFragment - performant, wartbar und zukunftssicher.')
                    ->setFooter('
                        <a href="/services/webdev" class="btn btn-primary">Mehr erfahren</a>
                    ')
                    ->addClass('h-100'),
                ['class' => 'col-lg-4 mb-4']
            )
            ->addDiv(
                Card::factory()
                    ->setImage('service-design.jpg', 'full_4x3') 
                    ->setHeader('Responsive Design')
                    ->setBody('Optimale Darstellung auf allen Endgeräten - von Smartphone bis Desktop.')
                    ->setFooter('
                        <a href="/services/design" class="btn btn-primary">Portfolio ansehen</a>
                    ')
                    ->addClass('h-100'),
                ['class' => 'col-lg-4 mb-4']
            )
            ->addDiv(
                Card::factory()
                    ->setImage('service-support.jpg', 'full_4x3')
                    ->setHeader('Support & Wartung')
                    ->setBody('Kontinuierliche Betreuung und Updates für Ihre REDAXO-Installation.')
                    ->setFooter('
                        <a href="/services/support" class="btn btn-primary">Kontakt</a>
                    ')
                    ->addClass('h-100'),
                ['class' => 'col-lg-4 mb-4']
            ),
        ['class' => 'row']
    );

// Komplette Seiten-Section zusammenbauen
$heroSection = MFragment::factory()
    ->addDiv($heroCarousel, ['class' => 'hero-wrapper mb-5'])
    ->addDiv(
        MFragment::factory()
            ->addHeading(2, 'Unsere Services', ['class' => 'text-center mb-5'])
            ->addFragment($servicesGrid),
        ['class' => 'container']
    );

echo $heroSection->show();
```

#### Interaktive FAQ-Section mit Accordion

```php
<?php
use FriendsOfRedaxo\MFragment\Components\Bootstrap\Accordion;
use FriendsOfRedaxo\MFragment;

$faqData = [
    [
        'question' => 'Was ist MFragment und warum sollte ich es verwenden?',
        'answer' => 'MFragment ist ein REDAXO-Addon für strukturierte HTML-Generierung. Es ermöglicht die programmatische Erstellung von HTML-Elementen mit einer komponentenorientierten Architektur, ähnlich wie MForm für Formulare arbeitet.',
    ],
    [
        'question' => 'Wie unterscheidet sich MFragment von normalen Templates?',
        'answer' => 'Statt statischer Templates ermöglicht MFragment dynamische HTML-Generierung direkt in PHP. Dadurch können Sie komplexe Layouts programmgesteuert erstellen, Inhalte bedingt einbinden und wiederverwendbare Komponenten entwickeln.',
    ],
    [
        'question' => 'Welche Vorteile bietet das responsive Media-System?',
        'answer' => 'Das Media-System bietet 360 vordefinierte Media Manager Typen mit automatischer WebP-Konvertierung. Es unterstützt 4 Bildserien (small, half, full, hero) und verschiedene Seitenverhältnisse für optimale Performance auf allen Geräten.',
    ]
];

$faqAccordion = Accordion::factory('faq-accordion');
foreach ($faqData as $index => $item) {
    $faqAccordion->addItem(
        $item['question'],
        MFragment::factory()
            ->addParagraph($item['answer'])
            ->addDiv(
                '<small class="text-muted">Weitere Fragen? <a href="/kontakt">Kontaktieren Sie uns</a></small>',
                ['class' => 'mt-3']
            )
    );
}

$faqSection = MFragment::factory()
    ->addDiv(
        MFragment::factory()
            ->addHeading(2, 'Häufig gestellte Fragen', ['class' => 'text-center mb-5'])
            ->addDiv($faqAccordion, ['class' => 'col-lg-8 mx-auto']),
        ['class' => 'container py-5']
    );

echo $faqSection->show();
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
use FriendsOfRedaxo\MFragment;

/**
 * Testimonial-Komponente für Kundenbewertungen
 */
class Testimonial extends AbstractComponent
{
    private string $quote = '';
    private string $author = '';
    private string $position = '';
    private string $company = '';
    private string $avatar = '';
    private int $rating = 5;

    public function setQuote(string $quote): self
    {
        $this->quote = $quote;
        return $this;
    }

    public function setAuthor(string $author): self
    {
        $this->author = $author;
        return $this;
    }

    public function setPosition(string $position): self
    {
        $this->position = $position;
        return $this;
    }

    public function setCompany(string $company): self
    {
        $this->company = $company;
        return $this;
    }

    public function setAvatar(string $avatar): self
    {
        $this->avatar = $avatar;
        return $this;
    }

    public function setRating(int $rating): self
    {
        $this->rating = max(1, min(5, $rating));
        return $this;
    }

    protected function renderHtml(): string
    {
        // Avatar-Bild mit responsive Media Manager
        $avatarImg = '';
        if ($this->avatar) {
            $avatarImg = '<img src="' . rex_media_manager::getUrl('small_1x1_160', $this->avatar) . '" 
                              alt="' . htmlspecialchars($this->author) . '" 
                              class="testimonial-avatar rounded-circle">';
        }

        // Sterne-Rating generieren
        $stars = '';
        for ($i = 1; $i <= 5; $i++) {
            $starClass = $i <= $this->rating ? 'star-filled' : 'star-empty';
            $stars .= '<i class="star ' . $starClass . '">★</i>';
        }

        $attributesStr = $this->buildAttributesString();

        return '
        <div class="testimonial' . ($this->hasClass('testimonial') ? '' : ' testimonial') . '"' . $attributesStr . '>
            <div class="testimonial-content">
                <blockquote class="testimonial-quote">
                    "' . htmlspecialchars($this->quote) . '"
                </blockquote>
                <div class="testimonial-rating">' . $stars . '</div>
            </div>
            <div class="testimonial-author">
                ' . $avatarImg . '
                <div class="author-info">
                    <h4 class="author-name">' . htmlspecialchars($this->author) . '</h4>
                    ' . ($this->position ? '<p class="author-position">' . htmlspecialchars($this->position) . '</p>' : '') . '
                    ' . ($this->company ? '<p class="author-company">' . htmlspecialchars($this->company) . '</p>' : '') . '
                </div>
            </div>
        </div>';
    }
}

// Verwendung der Testimonial-Komponente
$testimonial = Testimonial::factory()
    ->setQuote('MFragment hat unsere Entwicklungszeit um 40% reduziert und die Code-Qualität erheblich verbessert.')
    ->setAuthor('Maria Müller')
    ->setPosition('Lead Developer')
    ->setCompany('Digital Innovations GmbH')
    ->setAvatar('maria-mueller.jpg')
    ->setRating(5)
    ->addClass('featured-testimonial shadow-lg');

echo $testimonial->show();
```

### Erweiterte Komponente mit verschachtelten Elementen

```php
<?php
namespace App\Components;

use FriendsOfRedaxo\MFragment\Components\AbstractComponent;
use FriendsOfRedaxo\MFragment\Components\Bootstrap\Badge;
use FriendsOfRedaxo\MFragment\Components\Default\Figure;

/**
 * Produkt-Karte für E-Commerce mit komplexer Struktur
 */
class ProductCard extends AbstractComponent
{
    private string $title = '';
    private string $description = '';
    private float $price = 0.0;
    private float $oldPrice = 0.0;
    private string $image = '';
    private array $badges = [];
    private array $features = [];
    private bool $inStock = true;
    private string $ctaText = 'In den Warenkorb';

    public function setTitle(string $title): self
    {
        $this->title = $title;
        return $this;
    }

    public function setDescription(string $description): self
    {
        $this->description = $description;
        return $this;
    }

    public function setPrice(float $price): self
    {
        $this->price = $price;
        return $this;
    }

    public function setOldPrice(float $oldPrice): self
    {
        $this->oldPrice = $oldPrice;
        return $this;
    }

    public function setImage(string $image): self
    {
        $this->image = $image;
        return $this;
    }

    public function addBadge(string $text, string $type = 'primary'): self
    {
        $this->badges[] = ['text' => $text, 'type' => $type];
        return $this;
    }

    public function addFeature(string $feature): self
    {
        $this->features[] = $feature;
        return $this;
    }

    public function setInStock(bool $inStock): self
    {
        $this->inStock = $inStock;
        return $this;
    }

    public function setCtaText(string $ctaText): self
    {
        $this->ctaText = $ctaText;
        return $this;
    }

    protected function renderHtml(): string
    {
        // Produkt-Bild mit Lazy Loading
        $productImage = '';
        if ($this->image) {
            $productImage = Figure::factory()
                ->setMedia($this->image)
                ->setMediaManagerType('full_4x3')
                ->setAlt($this->title)
                ->addClass('product-image w-100')
                ->show();
        }

        // Badges rendern
        $badgesHtml = '';
        foreach ($this->badges as $badge) {
            $badgesHtml .= Badge::factory()
                ->setText($badge['text'])
                ->setType($badge['type'])
                ->addClass('me-1 mb-1')
                ->show();
        }

        // Features-Liste
        $featuresHtml = '';
        if (!empty($this->features)) {
            $features = '';
            foreach ($this->features as $feature) {
                $features .= '<li>' . htmlspecialchars($feature) . '</li>';
            }
            $featuresHtml = '<ul class="product-features list-unstyled small text-muted">' . $features . '</ul>';
        }

        // Preis-Bereich
        $priceHtml = '';
        if ($this->oldPrice > $this->price) {
            $discount = round((($this->oldPrice - $this->price) / $this->oldPrice) * 100);
            $priceHtml = '
                <div class="price-wrapper">
                    <span class="current-price text-success fw-bold">' . number_format($this->price, 2) . ' €</span>
                    <span class="old-price text-muted text-decoration-line-through ms-2">' . number_format($this->oldPrice, 2) . ' €</span>
                    <span class="discount-badge badge bg-danger ms-2">-' . $discount . '%</span>
                </div>';
        } else {
            $priceHtml = '<div class="price text-success fw-bold">' . number_format($this->price, 2) . ' €</div>';
        }

        // CTA-Button
        $ctaButton = '';
        if ($this->inStock) {
            $ctaButton = '<button type="button" class="btn btn-primary w-100">' . htmlspecialchars($this->ctaText) . '</button>';
        } else {
            $ctaButton = '<button type="button" class="btn btn-outline-secondary w-100" disabled>Nicht verfügbar</button>';
        }

        $attributesStr = $this->buildAttributesString();

        return '
        <div class="product-card card h-100' . ($this->inStock ? '' : ' out-of-stock') . '"' . $attributesStr . '>
            <div class="position-relative">
                ' . $productImage . '
                ' . ($badgesHtml ? '<div class="product-badges position-absolute top-0 start-0 m-2">' . $badgesHtml . '</div>' : '') . '
            </div>
            <div class="card-body d-flex flex-column">
                <h5 class="card-title">' . htmlspecialchars($this->title) . '</h5>
                <p class="card-text flex-grow-1">' . htmlspecialchars($this->description) . '</p>
                ' . $featuresHtml . '
                <div class="mt-auto">
                    ' . $priceHtml . '
                    <div class="mt-3">
                        ' . $ctaButton . '
                    </div>
                </div>
            </div>
        </div>';
    }
}

// Verwendung der ProductCard-Komponente
$product = ProductCard::factory()
    ->setTitle('MacBook Pro 16" M3 Max')
    ->setDescription('Professioneller Laptop für kreative Workflows und Entwicklung.')
    ->setPrice(2799.00)
    ->setOldPrice(2999.00)
    ->setImage('macbook-pro-16.jpg')
    ->addBadge('Neu', 'success')
    ->addBadge('Bestseller', 'warning')
    ->addFeature('M3 Max Chip')
    ->addFeature('32GB RAM')
    ->addFeature('1TB SSD')
    ->addFeature('Retina Display')
    ->setInStock(true)
    ->addClass('product-featured shadow-sm')
    ->setAttribute('data-product-id', '12345');

echo $product->show();
```

### Integration eigener Komponenten

Eigene Komponenten können problemlos mit Standard-MFragment-Elementen kombiniert werden:

```php
<?php
use FriendsOfRedaxo\MFragment;
use FriendsOfRedaxo\MFragment\Components\Bootstrap\Card;

// Kombiniere eigene Komponenten mit Standard-Komponenten
$productGrid = MFragment::factory()
    ->addDiv(
        MFragment::factory()
            ->addDiv(
                ProductCard::factory()
                    ->setTitle('Gaming Setup')
                    ->setDescription('Komplettes Gaming-Setup für Profis')
                    ->setPrice(1899.00)
                    ->setImage('gaming-setup.jpg')
                    ->addBadge('Gaming', 'danger')
                    ->setInStock(true),
                ['class' => 'col-lg-4 mb-4']
            )
            ->addDiv(
                Card::factory()
                    ->setHeader('Service-Paket')
                    ->setBody('Installation und 2 Jahre Garantie inklusive')
                    ->setFooter('<a href="/service" class="btn btn-outline-primary">Mehr Info</a>')
                    ->addClass('h-100'),
                ['class' => 'col-lg-4 mb-4']
            )
            ->addDiv(
                Testimonial::factory()
                    ->setQuote('Hervorragende Qualität und super Service!')
                    ->setAuthor('Peter Schmidt')
                    ->setRating(5)
                    ->setAvatar('peter.jpg'),
                ['class' => 'col-lg-4 mb-4']
            ),
        ['class' => 'row']
    );

echo $productGrid->show();
```

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

### Entwickler-Debugging-Workflow

```php
<?php
// debug.php - Debugging-Hilfe für eigene Komponenten

use FriendsOfRedaxo\MFragment\Core\RenderEngine;
use FriendsOfRedaxo\MFragment\Components\Bootstrap\Card;
use App\Components\ProductCard;

// Debug aktivieren
if (rex::isDebugMode()) {
    RenderEngine::enableDebug();
}

// Teste verschiedene Komponenten
$components = [
    'Standard Card' => Card::factory()->setHeader('Test Card')->setBody('Test Content'),
    'Product Card' => ProductCard::factory()->setTitle('Test Product')->setPrice('€99.99'),
    'Complex Layout' => MFragment::factory()
        ->addDiv(
            Card::factory()->setHeader('Nested Test'),
            ['class' => 'col-md-6']
        )
];

foreach ($components as $name => $component) {
    echo "<h3>{$name}</h3>";
    $startTime = microtime(true);
    
    $output = $component->show();
    
    $renderTime = round((microtime(true) - $startTime) * 1000, 2);
    echo "<p><small>Render-Zeit: {$renderTime}ms</small></p>";
    echo $output;
    echo "<hr>";
}

// Gesamtstatistiken
$stats = RenderEngine::getStats();
echo "<h3>Performance-Übersicht</h3>";
echo "<ul>";
echo "<li>Gesamte Render-Aufrufe: " . $stats['renderCalls'] . "</li>";
echo "<li>Gesamte Render-Zeit: " . $stats['processingTime'] . "ms</li>";
echo "<li>Ø Render-Zeit: " . round($stats['processingTime'] / max($stats['renderCalls'], 1), 2) . "ms</li>";
echo "</ul>";
```

### Media Manager Tests und Validierung

```php
<?php
// media_debug.php - Teste responsive Media System

// Prüfe ob alle Media Manager Typen verfügbar sind
function validateMediaTypes(): array
{
    $requiredTypes = [
        'small_1x1_320', 'small_4x3_320', 'small_16x9_320',
        'half_1x1_768', 'half_4x3_768', 'half_16x9_768',
        'full_1x1_1200', 'full_4x3_1200', 'full_16x9_1200',
        'hero_16x9_1400', 'hero_21x9_1920'
    ];
    
    $available = [];
    $missing = [];
    
    foreach ($requiredTypes as $type) {
        if (rex_sql::factory()->getArray('SELECT id FROM ' . rex::getTable('media_manager_type') . ' WHERE name = ?', [$type])) {
            $available[] = $type;
        } else {
            $missing[] = $type;
        }
    }
    
    return compact('available', 'missing');
}

// Test responsive Bild-Generierung
function testResponsiveImages(string $mediaFile): void
{
    $types = ['small', 'half', 'full', 'hero'];
    
    echo "<h3>Responsive Image Test: {$mediaFile}</h3>";
    
    foreach ($types as $baseType) {
        echo "<h4>{$baseType} Serie</h4>";
        
        if (function_exists('generateSrcset')) {
            $srcset = generateSrcset($mediaFile, $baseType);
            echo "<p><strong>Srcset:</strong> " . htmlspecialchars($srcset) . "</p>";
            
            $sizes = generateSizesForType($baseType);
            echo "<p><strong>Sizes:</strong> " . htmlspecialchars($sizes) . "</p>";
        }
        
        // Teste einzelne Größen
        $breakpoints = [320, 576, 768, 992, 1200, 1400];
        foreach ($breakpoints as $bp) {
            $typeName = "{$baseType}_16x9_{$bp}";
            if (rex_media_manager::getUrl($typeName, $mediaFile)) {
                echo "<span class='badge bg-success'>{$typeName} ✓</span> ";
            }
        }
        echo "<br><br>";
    }
}

// Führe Tests aus
$validation = validateMediaTypes();
echo "<h2>Media Manager Validierung</h2>";
echo "<p><strong>Verfügbare Types:</strong> " . count($validation['available']) . " von " . (count($validation['available']) + count($validation['missing'])) . "</p>";

if (!empty($validation['missing'])) {
    echo "<div class='alert alert-warning'>";
    echo "<strong>Fehlende Types:</strong> " . implode(', ', $validation['missing']);
    echo "<br><em>Führen Sie das SQL-Schema aus: install/responsive_complete_system.sql</em>";
    echo "</div>";
}

// Teste mit einer Beispiel-Datei
if ($media = rex_media::get('beispiel.jpg')) {
    testResponsiveImages('beispiel.jpg');
}
```
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
