# MFragment

MFragment ist eine flexible und leistungsfähige Bibliothek zur Erstellung von strukturiertem HTML-Content in REDAXO-Projekten. Sie ermöglicht es Entwicklern, komplexe Layouts und Komponenten einfach und effizient zu erstellen.

## Funktionen

- Einfache Erstellung von HTML-Strukturen
- Unterstützung für verschachtelte Elemente und Fragmente
- Flexible Konfigurationsmöglichkeiten
- Wiederverwendbare Komponenten

## Verwendung

### Einfache Elemente erstellen

```php
use FriendsOfRedaxo\MFragment;

$mfragment = MFragment::factory();
$mfragment->addTagElement('div', 'Inhalt', ['class' => ['my-class']]);
echo $mfragment->show();
```

### Anlage komplexerer Inhaltsstrukturen

```php
$mfragment = MFragment::factory();
$mfragment->addSection(
    MFragment::factory()
        ->addTagElement('h1', 'Überschrift')
        ->addTagElement('p', 'Beschreibung')
        ->addFragmentElement('bootstrap/buttons', [
            'content' => [
                ['text' => 'Mehr erfahren', 'link' => ['id' => 1]],
                ['text' => 'Kontakt', 'link' => ['id' => 2]]
            ]
        ])
);
echo $mfragment->show();
```

### Verwendung des Figure Fragments

```php
$mfragment = MFragment::factory();
$mfragment->addFragmentElement('bootstrap/figure', [
    'media' => rex_media::get('bild.jpg'),
    'alt' => 'Beschreibung',
    'caption' => [
        'title' => 'Bildtitel',
        'description' => 'Bildbeschreibung',
        'author' => 'Author',
        'copyright' => 'Copyright',
    ]
]);
echo $mfragment->show();
```

## Konfiguration

Konfigurationen werden in einem oder mehrerer `config`-Arrays übergeben:

```php
$mfragment->addSection($content, [
        'attributes' => ['class' => ['my-section']]
    ], [
        'attributes' => ['class' => ['container']]
    ]
);
```

## Verfügbare Methoden

- `addTagElement(string $tag, $content, array $attributes = [])`
- `addFragmentElement(string $element, array|string $content, array $config = [])`
- `addSection($content, array|bool $sectionConfig = [], array|bool $containerConfig = [])`
- `addColumn($content, array $config = [])`
- `addColumns(MFragment $columns, array $config = [])`
- `addImages(array $images, array $config = [])`
- `addCard($header, $body, $footer, array $config = [], array $headerConfig = [], array $bodyConfig = [], array $footerConfig = [])`
- `addAccordion(array $items, array $config = [])`

## Lizenz

MFragment ist unter der MIT-Lizenz lizenziert.
```
