# MFragment Addon - Version 2.0.0

Das MFragment Addon für REDAXO ist ein modernes Component-System zur Erstellung von wiederverwendbaren UI-Komponenten. Version 2.0 konzentriert sich vollständig auf Komponenten mit direkter HTML-Renderung für optimale Performance.

## Installation

**Responsive Media Types** (empfohlen):
```sql
source install/responsive_mediatypes.sql  -- 48 responsive Types
```

## Features

- **RenderEngine** - Optimierte Rendering-Engine mit Performance-Monitoring
- **Component Architecture** - Moderne Komponenten-basierte Architektur
- **Factory Pattern** - Saubere Objekt-Erstellung mit Fluent API
- **Bootstrap Components** - Card, Accordion, Tabs, Modal, Carousel, Alert, Badge, Progress, Collapse
- **Default Components** - Figure, HTMLElement, ListElement, Table
- **Pure HTML Rendering** - Direkte HTML-Ausgabe ohne Template-Overhead

## Hauptkomponenten

### Figure Component
```php
use FriendsOfRedaxo\MFragment\Components\Default\Figure;

$figure = Figure::factory()
    ->setMedia('image.jpg')
    ->setMediaManagerType('half')
    ->enableAutoResponsive()
    ->setAlt('Beschreibender Alt-Text')
    ->enableLazyLoading()
    ->setCover()
    ->setRatio('16x9');

echo $figure->show();
```

#### Figure Features:
- **Responsive Images** - Automatische Srcset-Generierung
- **Media Manager Integration** - Vollständige REDAXO Media Manager Unterstützung
- **Lazy Loading** - Performance-optimiertes Laden
- **Cover/Background Images** - BG-Cover Funktionalität
- **Accessibility** - Vollständige Barrierefreiheit

### Bootstrap Components

#### Card Component
```php
use FriendsOfRedaxo\MFragment\Components\Bootstrap\Card;

$card = Card::factory()
    ->setHeader('Titel')
    ->setBody('Inhalt')
    ->setFooter('Footer')
    ->addClass('shadow');

echo $card->show();
```

### Default Components

#### HTMLElement
```php
use FriendsOfRedaxo\MFragment\Components\Default\HTMLElement;

$element = HTMLElement::factory('div')
    ->setContent('Inhalt')
    ->addClass('custom-class')
    ->setAttribute('id', 'unique-id');

echo $element->show();
```

## Container System

```php
use FriendsOfRedaxo\MFragment;

$mfragment = MFragment::factory()
    ->addCard($card)
    ->addFigure($figure)
    ->addDiv($content, ['class' => 'wrapper']);

echo $mfragment->show();
```

## Responsive Images

### Automatische Responsive Images
```php
$figure = Figure::factory()
    ->setMedia('image.jpg')
    ->setMediaManagerType('half')
    ->enableAutoResponsive()
    ->optimizeForContainer('col-6');
```

### Media Manager Types
- Standard: `small`, `half`, `full`
- Ratio-spezifisch: `1x1`, `4x3`, `16x9`, `21x9`, `3x2`, `5x4`

## Migration von v1.0

### Fragment-basiert zu Komponenten-basiert
```php
// Alt (v1.x Fragment-basiert)
$fragment = new MFragmentItem('bootstrap/card', $data);

// Neu (v2.0 Component-basiert)  
$card = Card::factory()
    ->setHeader($data['header'])
    ->setBody($data['body']);
```

## Debugging

```php
// Debug-Modus aktivieren
$mfragment = MFragment::factory()
    ->setDebug(true)
    ->addComponent($component);

// Performance-Stats abrufen
$stats = RenderEngine::getStats();
```

## Best Practices

### Fluent API nutzen
```php
$figure = Figure::factory()
    ->setMedia($media)
    ->setMediaManagerType('half')
    ->enableLazyLoading()
    ->setCover()
    ->setRatio('16x9')
    ->addClass('custom-figure');
```

### 2. Container-Optimierung
```php
$figure = Figure::factory()
    ->setMedia($media)
    ->optimizeForContainer('col-6', '16x9'); // Automatische Optimierung
```

### 3. Accessibility berücksichtigen
```php
$figure = Figure::factory()
    ->setMedia($media)
    ->setAlt('Beschreibender Alt-Text')
    ->setDecorative(false) // Nicht dekorativ
    ->enableNoScriptFallback();
```

### 4. Performance optimieren
```php
$figure = Figure::factory()
    ->setMedia($media)
    ->enableLazyLoading(true) // Für Bilder außerhalb des Viewports
    ->setHeroBanner('Hero-Beschreibung'); // Für Hero-Bilder (kein Lazy Loading)
```

## Code-Standards

### Namespaces
- Bootstrap Components: `FriendsOfRedaxo\MFragment\Components\Bootstrap\`
- Default Components: `FriendsOfRedaxo\MFragment\Components\Default\`
- Custom Components: `FriendsOfRedaxo\MFragment\Components\Custom\`

### Dateistruktur
```
src/addons/mfragment/
├── components/
│   ├── Bootstrap/          # Bootstrap-spezifische Komponenten
│   ├── Default/            # Standard-Komponenten
│   └── Custom/             # Projekt-spezifische Komponenten
├── lib/                    # Core-Klassen
├── inputs/                 # MForm Input-Helpers
└── README.md              # Diese Dokumentation
```

## Qualitätssicherung

### Performance-Benchmark
```php
RenderEngine::resetStats();
// ... Code ausführen ...
$stats = RenderEngine::getStats();
// Verbesserung von mindestens 5% erwarten
```

### Rückwärtskompatibilität
- Alle Komponenten-Methoden funktionieren
- RenderEngine für externe Fragment-Nutzung verfügbar
- Bestehende Module unverändert nutzbar

## Support und Entwicklung

- **Version**: 2.0.0+
- **REDAXO**: 5.x kompatibel
- **PHP**: 8.0+ erforderlich
- **Bootstrap**: 5.x optimiert
