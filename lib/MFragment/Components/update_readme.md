# MFragment Komponenten ToDo Liste (Optimierte Version)

Dieses Dokument beschreibt die geplanten Erweiterungen des MFragment-Addons mit einem Fokus auf:
1. Architektur-Optimierung und Redundanz-Eliminierung
2. Implementierung fehlender HTML-Elemente und Komponenten
3. Performance-Verbesserungen und vereinheitlichte API

## Hintergrund

Wir optimieren das MFragment-Addon durch:
1. **RenderEngine** für zentrales Rendering (eliminiert redundante Processor-Instanziierungen)
2. **FragmentBase** für standardisierte Fragment-Verarbeitung
3. **getFragmentData() Elimination** durch automatische Fragment-Daten-Generierung
4. Konsistente Namespace-Struktur im `Core\` Bereich

## Priorität 1: Architektur-Optimierung (CRITICAL)

### Infrastruktur (sofort umsetzen)
- [x] **Namespace-Konsistenz**: Core\\ für interne Verarbeitung klären
- [ ] **RenderEngine**: Singleton für MFragmentProcessor implementieren
  ```php
  // path: src/addons/mfragment/lib/MFragment/Core/RenderEngine.php
  // namespace: FriendsOfRedaxo\MFragment\Core
  ```
- [ ] **FragmentBase**: Basis-Klasse für standardisierte Fragment-Verarbeitung
  ```php
  // path: src/addons/mfragment/lib/MFragment/Core/FragmentBase.php
  // namespace: FriendsOfRedaxo\MFragment\Core
  ```
- [ ] **AbstractComponent**: getFragmentData() durch buildFragmentData() ersetzen

### Performance-Optimierungen
- [ ] **Attribute-Caching**: In AbstractComponent implementieren
- [ ] **Fragment-Template**: Standardisierte Render-Pipeline
- [ ] **Code-Reduktion**: 30-50% weniger Code in Fragment-Dateien

## Priorität 2: Fehlende Basis-Komponenten

### HTML-Elemente (Standard-Komponenten)
- [ ] `ListElement`: Für ul, ol, dl Listen (renderHtml-basiert)
  ```php
  ListElement::createUnordered($items)
  ListElement::createOrdered($items)  
  ListElement::createDescription($items)
  ```
- [ ] `Table`: Für Tabellen mit Bootstrap-Integration (renderHtml-basiert)
  ```php
  Table::create($body, $header, $footer)
    ->setStriped(true)
    ->setResponsive(true)
  ```

### Helper-Komponenten
- [ ] `Badge`: Kleine Labels/Indikatoren (renderHtml-basiert)
- [ ] `Progress`: Fortschrittsbalken (renderHtml-basiert)
- [ ] `Alert`: Benachrichtigungsboxen (renderHtml-basiert)

## Priorität 3: MFragmentElements Erweiterung

### HTML-Elemente aktivieren (bereits auskommentiert)
- [ ] `addList()`: Mit ListElement-Komponente
- [ ] `addUl()`: Shortcut für ungeordnete Listen
- [ ] `addOl()`: Shortcut für geordnete Listen
- [ ] `addDl()`: Shortcut für Beschreibungslisten
- [ ] `addTable()`: Mit Table-Komponente

### Bootstrap-Komponenten hinzufügen
- [ ] `addAlert()`: Mit Alert-Komponente
- [ ] `addBadge()`: Mit Badge-Komponente
- [ ] `addProgress()`: Mit Progress-Komponente
- [ ] `addCollapse()`: Als Accordion-Variante (ohne Accordion-Gruppierung)

## Priorität 4: Optimierung bestehender Komponenten

### Bereits implementiert und optimierungsbedürftig
- [ ] **Accordion**: Auf neue Architektur umstellen
  - Collapse-Modus hinzufügen (independente Collapse-Elemente)
  - FragmentBase nutzen
  - getContentForFragment() statt getFragmentData()
- [ ] **Tabs**: Performance optimieren
  - RenderEngine verwenden
  - Fragment-Redundanzen eliminieren
- [ ] **Modal**: Redundanzen eliminieren
  - Fragment-Template standardisieren
- [ ] **Carousel**: Fragment-Verarbeitung vereinfachen
- [ ] **Card**: Best-Practice Beispiel für neue Architektur

### Fragment-Optimierung
- [ ] **bootstrap/accordion.php**: Auf FragmentBase umstellen
- [ ] **bootstrap/card.php**: Als Referenz-Implementierung optimieren
- [ ] **bootstrap/tabs.php**: Redundante Processor-Aufrufe eliminieren
- [ ] **bootstrap/modal.php**: Standard-Template anwenden
- [ ] **bootstrap/buttons.php**: Performance verbessern
- [ ] **default/figure.php**: Mit RenderEngine optimieren

## Priorität 5: Erweiterte Komponenten (OPTIONAL)

### Nur implementieren wenn wirklich benötigt
- [ ] `Tooltip`: Informations-Popup
- [ ] Erweiterte Table-Features (DataTables-Integration)
- [ ] Erweiterte Form-Komponenten

## Implementierungs-Guidelines (AKTUALISIERT)

### 1. Für renderHtml-basierte Komponenten
```php
class NewComponent extends AbstractComponent
{
    public function __construct() {
        parent::__construct(); // Kein Fragment!
        $this->addClass('component-class');
    }
    
    protected function renderHtml(): string {
        return '<div' . $this->buildAttributesString() . '>' . 
               $this->processContent($this->content) . 
               '</div>';
    }
}
```

### 2. Für Fragment-basierte Komponenten
```php
class NewComponent extends AbstractComponent
{
    public function __construct() {
        parent::__construct('bootstrap/new-component');
    }
    
    protected function getContentForFragment() {
        return $this->sections;
    }
    
    protected function getConfigForFragment(): array {
        return [
            'component' => [
                'attributes' => array_merge(
                    ['class' => $this->classes],
                    $this->attributes
                )
            ]
        ];
    }
}
```

### 3. Für Fragment-Dateien
```php
use FriendsOfRedaxo\MFragment\Core\FragmentBase;
use FriendsOfRedaxo\MFragment\Core\RenderEngine;

// Variante 1: Mit FragmentBase (empfohlen)
echo (new class($this) extends FragmentBase {
    protected function render(): string {
        $defaultConfig = [
            'wrapper' => ['tag' => 'div', 'attributes' => ['class' => ['container']]]
        ];
        
        return parent::render($defaultConfig, function($content, $config) {
            return $this->wrapContent($config['wrapper']['tag'], $content, $config['wrapper']);
        });
    }
})->render();

// Variante 2: Direkt mit RenderEngine
$content = $this->getVar('content', []);
$config = MFragmentHelper::mergeConfig($defaultConfig, $this->getVar('config', []));
echo RenderEngine::render($processedContent);
```

### 4. MFragmentElements Methoden
```php
public function addNewComponent($params): self
{
    $component = NewComponent::create($params);
    $this->items[] = $component;
    return $this;
}
```

## Roadmap

### Phase 1: Architektur-Optimierung (Woche 1-2)
1. RenderEngine implementieren
2. FragmentBase implementieren
3. AbstractComponent umstellen
4. Proof-of-Concept: Card-Komponente + Fragment optimieren

### Phase 2: Basis-Komponenten (Woche 3-4)
1. ListElement implementieren
2. Table implementieren
3. Alert, Badge, Progress implementieren
4. MFragmentElements um aktive + neue Methoden erweitern

### Phase 3: Bestehende Komponenten (Woche 5-6)
1. Accordion für Collapse-Modus erweitern
2. Alle major Fragmente auf FragmentBase umstellen
3. Performance-kritische Komponenten optimieren

### Phase 4: Cleanup & Finalisierung (Woche 7+)
1. Deprecated-Warnings für alte Methoden
2. Performance-Tests und Benchmarks
3. Dokumentation aktualisieren
4. Migration-Guide erstellen

## Erfolgs-Indikatoren

- ✓ 30-50% weniger Code in Fragment-Dateien
- ✓ 15-25% Performance-Verbesserung (Rendering-Zeit)
- ✓ Einheitliche API für alle Komponenten
- ✓ Keine redundanten Processor-Instanziierungen
- ✓ Konsistente Namespace-Struktur
- ✓ 100% Rückwärtskompatibilität
- ✓ Alle auskommentierten Features aktiv

## Migrations-Plan für Entwickler

### 1. Fragment-Migration
```php
// Vorher
$processor = new MFragmentProcessor();
echo $processor->process($content);

// Nachher  
echo RenderEngine::render($content);
```

### 2. Komponenten-Migration
```php
// Vorher
public function getFragmentData(): array {
    return ['content' => $this->sections];
}

// Nachher
protected function getContentForFragment() {
    return $this->sections;
}
```

### 3. Neue Komponenten hinzufügen
```php
// 1. Entscheide: Fragment oder renderHtml?
// 2. Nutze entsprechende Basis-Klasse
// 3. Implementiere minimal nötige Methoden
// 4. Teste mit RenderEngine
```

## Notizen

- **Priorität**: Erst Architektur optimieren, dann Features hinzufügen
- **Performance**: Jede neue Komponente sollte die optimierte Architektur nutzen
- **Tests**: Alte und neue Architektur parallel testen
- **Migration**: Schrittweise Umstellung mit Rückwärtskompatibilität
- **Dokumentation**: Beispiele für beide Rendering-Modi bereitstellen