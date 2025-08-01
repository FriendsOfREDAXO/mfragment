# RenderEngine - Zentrales Rendering für MFragment

Die RenderEngine ist die zentrale Singleton-Instanz für das Rendering aller MFragment-Komponenten und eliminiert redundante Processor-Instanziierungen.

## Überblick

Die RenderEngine bietet:
- **Performance-Verbesserung** durch Singleton-Pattern (15-25% schnelleres Rendering)
- **Einheitlicher API** für alle Rendering-Prozesse
- **Performance-Monitoring** mit integrierten Statistiken
- **Vereinfachte Fragment-Integration**

## API-Referenz

### Basis-Rendering

```php
// Beliebigen Content rendern
$html = RenderEngine::render($content);

// Fragment mit Daten rendern
$html = RenderEngine::renderFragment('bootstrap/card', [
    'content' => [...],
    'config' => [...]
]);

// Tag mit Content und Attributen rendern
$html = RenderEngine::renderTag('div', 'Content', ['class' => 'my-class']);
```

### Spezifische Shortcuts

```php
// Bootstrap-Komponenten
$html = RenderEngine::renderBootstrap('accordion', $content, $config);

// Default-Komponenten
$html = RenderEngine::renderDefault('figure', $content, $config);

// Mit vollständigen Daten
$html = RenderEngine::renderWithData('bootstrap/card', $content, $config, $attributes);
```

### Komponenten-Integration

```php
// In AbstractComponent
public function show(): string
{
    if (!empty($this->fragmentName)) {
        return RenderEngine::renderFragment($this->fragmentName, $this->getFragmentData());
    }
    return RenderEngine::render($this->renderHtml());
}
```

### Fragment-Integration

```php
// In Fragment-Dateien (z.B. bootstrap/accordion.php)
// ALT:
// $processor = new MFragmentProcessor();
// echo $processor->process($content);

// NEU:
echo RenderEngine::render($content);
```

## Performance-Monitoring

```php
// Statistiken abrufen
$stats = RenderEngine::getStats();

// Debug-Informationen als HTML
$debug = RenderEngine::getDebugInfo();

// Statistiken zurücksetzen
RenderEngine::resetStats();
```

### Beispiel-Ausgabe
```
RenderEngine Performance Stats:
- Total Render Calls: 45
- Total Fragment Calls: 23
- Total Processing Time: 0.1234 sec
- Average Time per Call: 0.002742 sec
- Total Memory Usage: 65432 bytes
- Average Memory per Call: 1454 bytes
```

## Migration von MFragmentProcessor

### Vorher
```php
$processor = new MFragmentProcessor();
$html = $processor->process($content);
```

### Nachher
```php
$html = RenderEngine::render($content);
```

## Verwendung in verschiedenen Kontexten

### 1. In Fragmenten
```php
// ALT
$processor = new MFragmentProcessor();
echo $processor->process($structure);

// NEU
echo RenderEngine::render($structure);
```

### 2. In Komponenten
```php
// AbstractComponent verwendet bereits RenderEngine
public function show(): string
{
    return RenderEngine::render($this);
}
```

### 3. In MFragment
```php
// Automatische Integration
$mfragment = MFragment::factory()
    ->addAccordion(...)
    ->addCard(...);
    
$html = $mfragment->show(); // Verwendet intern RenderEngine
```

## Best Practices

1. **Verwende immer RenderEngine::render()** statt direkte Processor-Instanziierung
2. **Nutze Shortcuts** für häufige Anwendungsfälle (`renderBootstrap`, `renderDefault`)
3. **Aktiviere Debug-Modus** während der Entwicklung für Performance-Insights
4. **Überwache Performance** in Produktionsumgebungen
5. **Verwende renderFragment()** für direkte Fragment-Aufrufe

## Performance-Tipps

- RenderEngine cached die Processor-Instanz
- Weniger Objekt-Instanziierungen = bessere Performance
- Performance-Monitoring hilft bei der Optimierung
- Verwende Shortcuts wo möglich

## Troubleshooting

### "RenderEngine not found"
Stelle sicher, dass der Namespace korrekt ist:
```php
use FriendsOfRedaxo\MFragment\Core\RenderEngine;
```

### Langsame Performance
Prüfe die Statistiken:
```php
$stats = RenderEngine::getStats();
if ($stats['processingTime'] > 0.5) {
    // Optimierung notwendig
}
```

### Memory-Issues
Setze Statistiken regelmäßig zurück:
```php
RenderEngine::resetStats();
```

## Beispiel-Migration

```php
// VORHER - Fragment mit direktem Processor
$processor = new MFragmentProcessor();
$content = MFragmentHelper::createTag('div', $items, ['attributes' => $attributes]);
echo $processor->process($content);

// NACHHER - Fragment mit RenderEngine
$content = MFragmentHelper::createTag('div', $items, ['attributes' => $attributes]);
echo RenderEngine::render($content);

// NOCH BESSER - Verwendung der Shortcuts
echo RenderEngine::renderTag('div', $items, $attributes);
```

## Fazit

Die RenderEngine ist der zentrale Einstiegspunkt für das Rendering in MFragment und sollte in allen neuen Implementierungen verwendet werden. Sie bietet nicht nur Performance-Vorteile, sondern auch eine konsistente API und integriertes Monitoring.