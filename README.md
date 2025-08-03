# MFragment Addon - Version 2.0.0

## Entwicklungsstand: Modernisiert - Component-First Architecture

Das MFragment Addon für REDAXO ist ein modernes Component-System zur Erstellung von wiederverwendbaren UI-Komponenten. Version 2.0 konzentriert sich vollständig auf Komponenten mit direkter HTML-Renderung für optimale Performance.

### SQL-Installation (install/ Verzeichnis)

**Responsive Media Types** (empfohlen):
```sql
source install/responsive_mediatypes.sql  -- 48 responsive Types
```

## Aktuelle Features

### Core System
- **RenderEngine** - Optimierte Rendering-Engine mit Performance-Monitoring
- **Component Architecture** - Moderne Komponenten-basierte Architektur
- **Factory Pattern** - Saubere Objekt-Erstellung mit Fluent API
- **Performance-Stats** - Eingebaute Performance-Überwachung
- **Debug-Modus** - Detaillierte Debug-Informationen
- **Method Chaining** - Flüssige API für alle Komponenten

### Komponenten-System
- **ComponentInterface** - Standardisierte Komponenten-API
- **AbstractComponent** - Optimierte Basis-Komponente mit direktem HTML-Rendering
- **Bootstrap Components** - Card, Accordion, Tabs, Modal, Carousel, Alert, Badge, Progress, Collapse
- **Default Components** - Figure, HTMLElement, ListElement, Table
- **Pure HTML Rendering** - Keine Fragment-Abhängigkeiten mehr

### HTML Generation  
- **BaseHtmlGenerator** - FORHtml-Wrapper mit intelligentem Fallback
- **FORHtml Integration** - Optional mit intelligentem Fallback auf native HTML
- **Direct Rendering** - Direkte HTML-Ausgabe ohne Template-Overhead

## Version 2.0 Änderungen

### Entfernt in v2.0:
- Fragment-Dateien und Template-System
- UIKit-Unterstützung (Fokus auf Bootstrap)
- Fragment-Registry aus boot.php
- Alte getFragmentData() API

### Neu in v2.0:
- Pure Component Architecture
- 100% Direct HTML Rendering
- Optimierte Performance ohne Template-Overhead
- Vereinfachte API ohne Fragment-Komplexität

## Hauptkomponenten

### Figure Component
Die Figure-Komponente ist die Kernkomponente für Bilddarstellung mit umfangreichen Features:

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
- **Flexible Aspect Ratios** - Standard-Typen nutzen flexibles Verhältnis
- **Specific Ratios** - 1x1, 4x3, 16x9, 21x9, 3x2, 5x4 mit exakten Dimensionen
- **Lazy Loading** - Performance-optimiertes Laden
- **Cover/Background Images** - BG-Cover Funktionalität
- **Accessibility** - Vollständige Barrierefreiheit
- **Lightbox Support** - Integration mit Lightbox-Systemen
- **SVG Support** - Spezielle Behandlung für SVG-Dateien

#### Media Manager Types:
- Standard-Typen: `small`, `half`, `full` (flexibles Verhältnis)
- Legacy-Typen: `content_small`, `content_half`, `content_full` (flexibles Verhältnis)
- Ratio-spezifische Typen: `1x1`, `4x3`, `16x9`, `21x9`, `3x2`, `5x4`

### Bootstrap Components

#### Card Component
```php
use FriendsOfRedaxo\MFragment\Components\Bootstrap\Card;

$card = Card::factory()
    ->setHeader('Titel')
    ->setBody('Inhalt')
    ->setFooter('Footer')
    ->addClass('shadow')
    ->setAttribute('data-custom', 'value');

echo $card->show();
```

#### Weitere Bootstrap Components
- **Accordion** - Erweiterbarer Inhalt
- **Tabs** - Tab-Navigation
- **Modal** - Popup-Dialoge
- **Carousel** - Bild-Slider
- **Alert** - Benachrichtigungen
- **Badge** - Status-Kennzeichnungen
- **Progress** - Fortschrittsbalken
- **Collapse** - Ein-/Ausklappbare Bereiche

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

#### ListElement
```php
use FriendsOfRedaxo\MFragment\Components\Default\ListElement;

$list = ListElement::factory('ul')
    ->addItem('Erstes Element')
    ->addItem('Zweites Element')
    ->addClass('custom-list');

echo $list->show();
```

#### Table
```php
use FriendsOfRedaxo\MFragment\Components\Default\Table;

$table = Table::factory()
    ->setHeaders(['Name', 'Email', 'Status'])
    ->addRow(['Max Mustermann', 'max@example.com', 'Aktiv'])
    ->addRow(['Jane Doe', 'jane@example.com', 'Inaktiv'])
    ->addClass('table-striped');

echo $table->show();
```

## MFragment Container System

```php
use FriendsOfRedaxo\MFragment;

$mfragment = MFragment::factory()
    ->setDebug(true)  // Optional: Debug-Modus
    ->addCard($card)
    ->addFigure($figure)
    ->addDiv($content, ['class' => 'wrapper'])
    ->addSection($section, $sectionConfig);

echo $mfragment->show();
```

## API-Pattern

```
Komponente erstellen?
└─ Einfache HTML-Struktur?
   ├─ JA → HTMLElement verwenden
   │  └─ HTMLElement als Basis
   └─ NEIN → Komplexe Komponente
      ├─ Bootstrap? → Card, Modal, etc.
      ├─ Default? → Figure, Table, etc.
      └─ Custom → extend AbstractComponent
```

### Entwicklungs-Workflow

#### Neue renderHtml-basierte Komponente
```php
// src/addons/mfragment/components/Custom/NewComponent.php
class NewComponent extends AbstractComponent
{
    public function __construct()
    {
        parent::__construct();
        $this->addClass('new-component');
    }
    
    protected function renderHtml(): string
    {
        return '<div' . $this->buildAttributesString() . '>' . 
               $this->processContent($this->content) . 
               '</div>';
    }
}
```

## Performance-Optimierung

### Direkte Komponenten-Nutzung (Optimal)
```php
$component = Card::factory()
    ->setContent($content)
    ->addClass('custom-card');
echo $component->show();
```

### RenderEngine für Legacy-Kompatibilität
```php
echo RenderEngine::render($content);
```

## Accessibility Features

### Figure Component Accessibility
```php
$figure = Figure::factory()
    ->setMedia('image.jpg')
    ->setAlt('Beschreibender Alt-Text')
    ->setAriaLabel('Zusätzliche Beschreibung')
    ->setRole('img')
    ->enableNoScriptFallback()
    ->setDecorative(false); // oder true für dekorative Bilder
```

### Semantische HTML-Struktur
```php
$section = HTMLElement::factory('section')
    ->setAttribute('aria-labelledby', 'section-title')
    ->setContent([
        HTMLElement::factory('h2')
            ->setAttribute('id', 'section-title')
            ->setContent('Abschnittstitel'),
        HTMLElement::factory('div')
            ->setContent('Abschnittsinhalt')
    ]);
```

## Responsive Images System

### Automatische Responsive Images
```php
$figure = Figure::factory()
    ->setMedia('image.jpg')
    ->setMediaManagerType('half')
    ->enableAutoResponsive()  // Nutzt project/boot.php oder Fallback
    ->optimizeForContainer('col-6'); // Optimiert für Bootstrap Grid
```

### Projekt-Integration mit project/boot.php
```php
// In project/boot.php verfügbare Funktionen:
// - generateSrcset($filename, $baseType)
// - generateSizesForType($baseType)
// - getResponsiveImageData($filename, $baseType, $containerType)
```

### Eingebaute Fallback-Funktionalität
```php
$figure = Figure::factory()
    ->setMedia('image.jpg')
    ->setMediaManagerType('half')
    ->forceBuiltinResponsive(true); // Keine project/boot.php Abhängigkeit
```

## Debugging

### Performance Monitoring
```php
MFragment::factory()
    ->setDebug(true)
    ->addComponent($component)
    ->show(); // Zeigt Debug-Info

// Oder direkt:
$stats = RenderEngine::getStats();
var_dump($stats);
```

### Component Debug
```php
// In Komponenten
protected function renderHtml(): string
{
    $output = $this->buildMyHtml();
    // var_dump($output); // Auskommentiert für Debug
    return $output;
}
```

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

### Alte getFragmentData() API
```php
// Alt
public function getFragmentData(): array
{
    return [
        'content' => $this->content,
        'config' => $this->config
    ];
}

// Neu - falls Fragment-Kompatibilität benötigt
protected function getContentForFragment()
{
    return $this->content;
}

protected function getConfigForFragment(): array
{
    return $this->config;
}
```

## Best Practices

### 1. Fluent API nutzen
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

**Letztes Update**: Basierend auf aktueller Codebase mit flexiblen Aspect Ratios und optimierter Figure-Komponente
        return '<div' . $this->buildAttributesString() . '>' . 
               $this->processContent($this->content) . 
               '</div>';
    }
}
```

#### **B) Erweiterte Komponente mit komplexer Logik**

```php
// src/addons/mfragment/components/Default/AdvancedElement.php
class AdvancedElement extends AbstractComponent
{
    protected array $sections = [];
    
    public function __construct()
    {
        parent::__construct();
    }
    
    public function addSection(string $title, string $content): self
    {
        $this->sections[] = ['title' => $title, 'content' => $content];
        return $this;
    }
    
    protected function renderHtml(): string
    {
        $output = '<div' . $this->buildAttributesString() . '>';
        foreach ($this->sections as $section) {
            $output .= '<div class="section">';
            $output .= '<h3>' . htmlspecialchars($section['title']) . '</h3>';
            $output .= '<div class="content">' . $section['content'] . '</div>';
            $output .= '</div>';
        }
        $output .= '</div>';
        return $output;
    }
}
```

### **Schritt 3: Integration in MFragmentElements**

```php
// src/addons/mfragment/lib/MFragment/MFragmentElements.php

public function addNewComponent($params): self
{
    if ($params instanceof NewComponent) {
        $this->items[] = $params;
    } else {
        $component = NewComponent::factory()
            ->setContent($params);
        $this->items[] = $component;
    }
    return $this;
}
```

### **Schritt 4: Testing & Validierung**

```php
// Entwickler-Test
$mfragment = MFragment::factory()
    ->setDebug(true)
    ->addNewComponent($params);

$html = $mfragment->show();
// Performance-Stats überprüfen
var_dump(RenderEngine::getStats());
```

## 📝 **Code-Standards Checkliste**

### **Vor jedem Commit:**

- [ ] Namespace korrekt: `FriendsOfRedaxo\MFragment\Components\...`
- [ ] Klassen/Methoden/Properties auf Englisch
- [ ] Kommentare auf Deutsch
- [ ] Dateipfad als Kommentar: `# path: src/addons/mfragment/...`
- [ ] Factory-Pattern verwendet
- [ ] TODOs nicht übersetzt
- [ ] Template-Variablen `{{ }}` unverändert
- [ ] RenderEngine statt direkter Processor

### **Performance-Optimierung:**

```php
// SCHLECHT
$processor = new MFragmentProcessor();
echo $processor->process($content);

// GUT
echo RenderEngine::render($content);

// NOCH BESSER - Direkt in Komponenten
$component = Card::factory()
    ->setContent($content)
    ->addClass('custom-card');
echo $component->show();
```

## 🔄 **Migration-Workflow**

### **Bestehende Komponente migrieren:**

```markdown
1. **Analyse**
   - Welche Daten werden verwendet?
   - Wie komplex ist die HTML-Struktur?
   - Gibt es Tests?

2. **Backup erstellen**
   - Originaldateien sichern
   - Tests dokumentieren

3. **Schrittweise Migration**
   - renderHtml() Methode implementieren
   - Alte Methoden als deprecated markieren
   - RenderEngine für finale Ausgabe nutzen

4. **Validierung**
   - Gleiche Ausgabe wie vorher?
   - Performance-Verbesserung messbar?
   - Alle Tests grün?

5. **Dokumentation**
   - Migration in CHANGELOG.md
   - Beispiele aktualisieren
```

## 📚 **Dokumentations-Template**

### **Für jede neue Komponente:**

```markdown
## ComponentName

**Pfad**: `src/addons/mfragment/components/.../ComponentName.php`
**Rendering**: Pure HTML (renderHtml)
**Version**: 2.0.0+

### Verwendung

```php
$component = ComponentName::create()
    ->setAttribute('class', 'custom-class')
    ->setContent($content);

echo $component->show();
```

### API-Referenz

- `setContent($content)`: Setzt den Inhalt
- `setConfig($key, $value)`: Konfiguration setzen

### Migration von v1.0

```php
// Alt (v1.x Fragment-basiert)
$fragment = new MFragmentItem(...);

// Neu (v2.0 Component-basiert)
$component = ComponentName::factory(...);
```
```

## 🎨 **Pattern-Bibliothek**

### **Häufige Patterns:**

```php
// 1. Einfacher Tag mit Inhalt
echo HTMLElement::factory('div')
    ->setContent($content)
    ->addClass('wrapper')
    ->show();

// 2. Bootstrap-Komponente
echo Card::factory()
    ->setHeader($title)
    ->setBody($content)
    ->addClass('shadow')
    ->show();

// 3. Komplexe Struktur mit verschachtelten Komponenten
$section = HTMLElement::factory('section')
    ->addClass('content-section');

$section->setContent([
    HTMLElement::factory('h2')->setContent($title)->show(),
    HTMLElement::factory('div')->addClass('content')->setContent($content)->show()
]);

echo $section->show();

// 4. Liste von Items
echo ListElement::factory('ul')
    ->addItem('Erstes Element')
    ->addItem('Zweites Element')
    ->addClass('custom-list')
    ->show();

// 5. RenderEngine für Legacy-Kompatibilität (falls externe Fragmente)
echo RenderEngine::render($legacyStructure);
```

## 🔍 **Debugging-Guide**

### **Performance prüfen:**

```php
MFragment::factory()
    ->setDebug(true)
    ->addComponent($component)
    ->show(); // Zeigt Debug-Info

// Oder direkt:
echo RenderEngine::getStats();
```

### **Komponenten-Daten prüfen:**

```php
// In Komponenten
protected function renderHtml(): string
{
    $output = $this->buildMyHtml();
    // var_dump($output); // Auskommentiert für Debug
    return $output;
}
```

## 📊 **Qualitätssicherung**

### **Vor Release:**

1. **Performance-Benchmark**
   ```php
   RenderEngine::resetStats();
   // ... Code ausführen ...
   $stats = RenderEngine::getStats();
   // Verbesserung von mindestens 5% erwarten
   ```

2. **Rückwärtskompatibilität**
  - Alle Komponenten-Methoden funktionieren?
  - RenderEngine für externe Fragment-Nutzung verfügbar?

3. **Dokumentation**
  - README aktualisiert?
  - CHANGELOG.md Eintrag?
  - Migration-Beispiele vorhanden?

## 🚀 **Prioritäten-Matrix**

| Aufgabe | Priorität | Aufwand | Auswirkung |
|---------|-----------|---------|------------|
| ListElement implementieren | Hoch | Niedrig | Hoch |
| Migration-Guide schreiben | Hoch | Mittel | Hoch |
| Tabs migrieren | Mittel | Mittel | Mittel |
| Table implementieren | Mittel | Hoch | Mittel |
| Badge implementieren | Niedrig | Niedrig | Niedrig |

## 📋 **Täglicher Arbeitsflow**

```markdown
1. **Morgen** (30 min)
   - Prioritätenliste überprüfen
   - Performance-Ziele definieren
   - Code-Review-Notizen durchgehen

2. **Entwicklung** (Core-Zeit)
   - Ein Feature pro Session
   - Test-First-Ansatz
   - Dokumentation parallel

3. **Abends** (15 min)
   - Commits aufräumen
   - Fortschritt dokumentieren
   - Nächste Schritte planen
```

## 💡 **Erfolgskriterien**

- ✅ Keine redundanten Processor-Instanziierungen
- ✅ Einheitliche API für ähnliche Komponenten
- ✅ Mindestens 5% Performance-Verbesserung
- ✅ 100% Rückwärtskompatibilität
- ✅ Vollständige Dokumentation
- ✅ Praxistaugliche Beispiele

---

**Letztes Update**: Aktuelle Version basierend auf Phase 1 Optimierungen
**Nächster Milestone**: Vollständige Phase 2 Implementierung