# MFragment Addon - Version 1.2.0-beta

## Entwicklungsstand: Produktionsreif (Phase 2)

Das MFragment Addon für REDAXO ist ein fortschrittliches Fragment-System zur Erstellung von wiederverwendbaren UI-Komponenten. Das Addon befindet sich aktuell in **Phase 2** der Entwicklung und ist **85% fertiggestellt**.

## ✅ Aktuelle Features

### Core System
- ✅ **RenderEngine** - Optimierte Rendering-Engine mit Performance-Monitoring
- ✅ **Factory Pattern** - Saubere Objekt-Erstellung
- ✅ **FORHtml Integration** - Optional mit intelligentem Fallback
- ✅ **Performance-Stats** - Eingebaute Performance-Überwachung
- ✅ **Debug-Modus** - Detaillierte Debug-Informationen
- ✅ **Method Chaining** - Flüssige API

### Komponenten-System
- ✅ **ComponentInterface** - Standardisierte Komponenten-API
- ✅ **AbstractComponent** - Basis-Komponente mit Standard-Funktionalität
- ✅ **Bootstrap Components** - Badge-Komponente implementiert
- ✅ **Default Components** - Figure, HTMLElement, ListElement, Table
- ✅ **Fragment-System** - Template-basierte Fragmente

### HTML Generation
- ✅ **BaseHtmlGenerator** - FORHtml-Wrapper mit Fallback
- ✅ **parseHtml()** - HTML-Element-Erstellung
- ✅ **SimpleHtmlElement** - Native HTML-Fallback
- ✅ **REDAXO-kompatibel** - Proper addon availability checking

### UI/Backend Integration
- ✅ **MForm Inputs** - Bootstrap/UIKit Form-Felder
- ✅ **SVG Icon Sets** - Umfangreiches Icon-System für Backend
- ✅ **Fragment Templates** - Bootstrap/UIKit/Default Fragmente
- ✅ **Custom Inputs** - Spezielle Input-Felder für REDAXO Backend

## 🔧 **Primäre Entwicklungsprinzipien**

### 1. **Architektur-Entscheidungsmatrix**

| Anforderung | Lösung | Grund |
|------------|---------|-------|
| HTML-Tag mit Attributen | `parseHtml()` mit HTMLElement | Direkt, schnell |
| Bootstrap-Komponente | Fragment-basiert | Flexibilität & Wiederverwendung |
| Komplexe Verschachtelung | Component-basiert | Wartbarkeit |
| Einfache Liste/Tabelle | `renderHtml()` | Performance |

### 2. **API-Pattern Entscheidungsbaum**

```
Neue Komponente entwickeln?
└─ Einfache HTML-Struktur?
   ├─ JA → renderHtml() verwenden
   │  └─ HTMLElement als Basis
   └─ NEIN → Fragment verwenden
      ├─ Bootstrap? → renderBootstrap()
      ├─ Default? → renderDefault()
      └─ Custom → renderFragment()
```

## 🛠️ **Entwicklungs-Workflow**

### **Schritt 1: Analyse & Planung**

```markdown
**Vor jeder Entwicklung klären:**
1. Ist es eine neue Komponente oder Migration?
2. Welcher Rendering-Modus ist optimal?
3. Welche bestehenden Patterns kann ich nutzen?
4. Muss es rückwärtskompatibel sein?
```

### **Schritt 2: Implementierung**

#### **A) Neue Fragment-basierte Komponente**

```php
// src/addons/mfragment/lib/MFragment/Components/Bootstrap/NewComponent.php
class NewComponent extends AbstractComponent
{
    public function __construct()
    {
        parent::__construct('bootstrap/new-component');
    }
    
    protected function getContentForFragment()
    {
        return $this->sections;
    }
    
    protected function getConfigForFragment(): array
    {
        return $this->config;
    }
    
    protected function getComponentKey(): ?string
    {
        return 'newComponent';
    }
}
```

#### **B) Neue renderHtml-basierte Komponente**

```php
// src/addons/mfragment/lib/MFragment/Components/Default/SimpleElement.php
class SimpleElement extends AbstractComponent
{
    public function __construct()
    {
        parent::__construct(); // Kein Fragment!
    }
    
    protected function renderHtml(): string
    {
        return '<div' . $this->buildAttributesString() . '>' . 
               $this->processContent($this->content) . 
               '</div>';
    }
}
```

#### **C) Fragment-Datei erstellen/optimieren**

```php
// src/addons/mfragment/fragments/bootstrap/new-component.php
use FriendsOfRedaxo\MFragment\Core\RenderEngine;
use FriendsOfRedaxo\MFragment\Helper\MFragmentHelper;

$content = $this->getVar('content', []);
$config = $this->getVar('config', []);

// Verarbeitung...
$structure = MFragmentHelper::createTag('div', $processedContent, ['attributes' => $attributes]);

// RenderEngine verwenden
echo RenderEngine::render($structure);
```

### **Schritt 3: Integration in MFragmentElements**

```php
// src/addons/mfragment/lib/MFragment/MFragmentElements.php

public function addNewComponent($params): self
{
    if ($params instanceof NewComponent) {
        $this->items[] = $params;
    } else {
        $component = NewComponent::create($params);
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

// NOCH BESSER
echo RenderEngine::renderBootstrap('component', $content, $config);
```

## 🔄 **Migration-Workflow**

### **Bestehende Komponente migrieren:**

```markdown
1. **Analyse**
   - Fragment oder renderHtml Komponente?
   - Welche Daten werden verwendet?
   - Gibt es Tests?

2. **Backup erstellen**
   - Originaldateien sichern
   - Tests dokumentieren

3. **Schrittweise Migration**
   - Neue Methoden hinzufügen
   - getFragmentData() beibehalten (deprecated)
   - RenderEngine in Fragmenten einbauen

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

**Pfad**: `src/addons/mfragment/lib/MFragment/Components/.../ComponentName.php`
**Rendering**: [Fragment-basiert|renderHtml]
**Version**: 1.1.0+

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
// Alt
$fragment = new MFragmentItem(...);

// Neu  
$component = ComponentName::create(...);
```
```

## 🎨 **Pattern-Bibliothek**

### **Häufige Patterns:**

```php
// 1. Einfacher Tag mit Inhalt
RenderEngine::renderTag('div', $content, ['class' => 'wrapper']);

// 2. Bootstrap-Komponente
RenderEngine::renderBootstrap('accordion', $items, $config);

// 3. Komplexe Struktur
$structure = MFragmentHelper::createTag('section', [
    MFragmentHelper::createTag('h2', $title),
    MFragmentHelper::createTag('div', $content, ['class' => 'content'])
]);
echo RenderEngine::render($structure);

// 4. Fragment-Einbindung
$fragment = MFragmentHelper::createFragment('bootstrap/card', [
    'content' => $cardContent,
    'config' => $cardConfig
]);
echo RenderEngine::render($fragment);

// 5. Config zusammenführen
$mergedConfig = MFragmentHelper::mergeConfig($defaultConfig, $userConfig);
```

## 🔍 **Debugging-Guide**

### **Performance prüfen:**

```php
MFragment::factory()
    ->setDebug(true)
    ->addComponent($component)
    ->show(); // Zeigt Debug-Info

// Oder direkt:
echo RenderEngine::getDebugInfo();
```

### **Fragment-Daten inspizieren:**

```php
// In Fragment-Dateien
var_dump($this->getVar('content'));
var_dump($this->getVar('config'));
die();
```

### **Komponenten-Daten prüfen:**

```php
// In Komponenten
protected function getContentForFragment()
{
    $content = $this->sections;
    // var_dump($content); // Auskommentiert für Debug
    return $content;
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
  - Alle alten Methoden funktionieren?
  - getFragmentData() gibt deprecation warning?

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