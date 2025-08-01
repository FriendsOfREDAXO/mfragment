# Datenfluss: Komponenten → Fragmente

## Überblick

Dieser Guide erklärt, wie Daten von einer Komponente zu einem Fragment fließen und wie die optimierte API ohne `getFragmentData()` funktioniert.

## Der Datenfluss

### 1. Komponente Erstellen & Konfigurieren

```php
$card = Card::factory()
    ->setHeader('Titel')
    ->setBody('Text')
    ->addClass('shadow')
    ->setAttribute('data-custom', 'value');
```

### 2. show() Aufruf

```php
$html = $card->show();
```

### 3. Interne Verarbeitung

#### 3.1 AbstractComponent.show()
```php
public function show(): string
{
    if (!empty($this->fragmentName)) {
        // Automatische Fragment-Daten-Generierung
        $fragmentData = $this->buildFragmentData();
        return RenderEngine::renderFragment($this->fragmentName, $fragmentData);
    }
    
    return RenderEngine::render($this->renderHtml());
}
```

#### 3.2 buildFragmentData()
```php
protected function buildFragmentData(): array
{
    $data = [];
    
    // Content abrufen
    if (method_exists($this, 'getContentForFragment')) {
        $data['content'] = $this->getContentForFragment();
    }
    
    // Config abrufen
    if (method_exists($this, 'getConfigForFragment')) {
        $data['config'] = $this->getConfigForFragment();
    }
    
    // Klassen und Attribute automatisch hinzufügen
    $componentKey = $this->getComponentKey(); // z.B. 'card'
    
    if ($componentKey) {
        $data['config'][$componentKey]['attributes']['class'] = $this->classes;
        $data['config'][$componentKey]['attributes'] = array_merge(
            $data['config'][$componentKey]['attributes'] ?? [],
            $this->attributes
        );
    }
    
    return $data;
}
```

### 4. Fragment erhält die Daten

Das Fragment bekommt die Daten über die Standard-REDAXO-API:

```php
// bootstrap/card.php
$content = $this->getVar('content', []);
$config = $this->getVar('config', []);
$attributes = $this->getVar('attributes', []);
```

## Beispiel: Card-Komponente

### Komponenten-Implementierung

```php
class Card extends AbstractComponent
{
    private array $sections = [
        'header' => null,
        'body' => null,
        'footer' => null
    ];
    
    // Content für Fragment bereitstellen
    protected function getContentForFragment()
    {
        return [
            'header' => ['content' => $this->sections['header']],
            'body' => ['content' => $this->sections['body']],
            'footer' => ['content' => $this->sections['footer']]
        ];
    }
    
    // Config für Fragment bereitstellen
    protected function getConfigForFragment(): array
    {
        return [
            'image_position' => 'top'
        ];
    }
    
    // Komponenten-Schlüssel für Config
    protected function getComponentKey(): ?string
    {
        return 'card';
    }
}
```

### Resultierende Fragment-Daten

```php
// Was das Fragment erhält:
[
    'content' => [
        'header' => ['content' => 'Titel'],
        'body' => ['content' => 'Text'],
        'footer' => ['content' => null]
    ],
    'config' => [
        'image_position' => 'top',
        'card' => [
            'attributes' => [
                'class' => ['card', 'shadow'],
                'data-custom' => 'value'
            ]
        ]
    ]
]
```

## Automatische Datenverarbeitung

### 1. Content-Generierung

Die `getContentForFragment()` Methode wird automatisch aufgerufen:

```php
// In der Komponente
protected function getContentForFragment()
{
    return $this->sections; // Gibt alle Sektionen zurück
}
```

### 2. Config-Generierung

Die `getConfigForFragment()` Methode wird automatisch aufgerufen:

```php
// In der Komponente
protected function getConfigForFragment(): array
{
    return [
        'viewType' => $this->viewType,
        'accordion' => $this->config['accordion']
    ];
}
```

### 3. Automatische Attribut-Integration

```php
// Klassen und Attribute werden automatisch in die Config integriert
$data['config']['card']['attributes'] = [
    'class' => ['card', 'shadow'], // Aus addClass()
    'data-custom' => 'value'       // Aus setAttribute()
];
```

## Best Practices

### 1. Implementiere die neuen Methoden

```php
class MyComponent extends AbstractComponent
{
    protected function getContentForFragment()
    {
        return $this->content;
    }
    
    protected function getConfigForFragment(): array
    {
        return $this->config;
    }
    
    protected function getComponentKey(): ?string
    {
        return 'myComponent';
    }
}
```

### 2. Nutze Fragment-Namen

```php
public function __construct()
{
    parent::__construct('bootstrap/myComponent');
}
```

### 3. Verwende RenderEngine

```php
// Fragment-Datei
echo RenderEngine::render($content);
```

## Migration von getFragmentData()

### Alt
```php
public function getFragmentData(): array
{
    return [
        'content' => $this->content,
        'config' => $this->config
    ];
}
```

### Neu
```php
protected function getContentForFragment()
{
    return $this->content;
}

protected function getConfigForFragment(): array
{
    return $this->config;
}
```

## Vorteile der neuen API

1. **Automatische Attribut-Integration**: Klassen und Attribute werden automatisch in die Config übernommen
2. **Trennung von Content und Config**: Klarere Struktur
3. **Rückwärtskompatibilität**: Alte `getFragmentData()` funktioniert weiterhin
4. **Performance**: Weniger redundanter Code
5. **Flexibilität**: Einfacheres Überschreiben spezifischer Methoden

## Debugging

Um zu sehen, welche Daten an ein Fragment weitergegeben werden:

```php
// In der Komponente
protected function getContentForFragment()
{
    $content = $this->sections;
    // Debug
    // var_dump($content);
    return $content;
}
```

Oder mit der MFragment Debug-Funktion:

```php
$mfragment = MFragment::factory()
    ->setDebug(true)
    ->addCard($card);
    
echo $mfragment->show(); // Zeigt Performance-Statistiken
```