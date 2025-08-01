<?php

namespace FriendsOfRedaxo\MFragment\Components\Bootstrap;

use FriendsOfRedaxo\MFragment\Components\AbstractComponent;
use FriendsOfRedaxo\MFragment\Components\ComponentInterface;

/**
 * Optimierte Alert-Komponente ohne getFragmentData()
 */
class Alert extends AbstractComponent
{
    /**
     * Inhalt-Sektionen
     */
    private array $sections = [
        'content' => null,
        'heading' => null,
        'icon' => null
    ];

    /**
     * Konfiguration der Sektionen
     */
    private array $sectionConfig = [];

    /**
     * Standard-Klassen für Sektionen
     */
    private array $defaultClasses = [
        'content' => [],
        'heading' => ['alert-heading'],
        'icon' => ['alert-icon']
    ];

    /**
     * Konfigurationseigenschaften
     */
    private array $config = [
        'type' => 'primary',        // primary, secondary, success, danger, warning, info, light, dark
        'dismissible' => false,     // Ob der Alert schließbar ist
        'autoHide' => false,        // Ob der Alert automatisch ausgeblendet wird
        'autoHideDelay' => 5000     // Verzögerung für Auto-Hide (in ms)
    ];

    /**
     * Konstruktor
     *
     * @param string|null $content Inhalt der Alert-Nachricht
     * @param string $type Typ der Alert-Nachricht
     */
    public function __construct($content = null, string $type = 'primary')
    {
        

        // Standard-Klassen
        $this->addClass('alert');
        $this->addClass('alert-' . $type);
        $this->config['type'] = $type;

        // Standard-Attribute
        $this->setAttribute('role', 'alert');

        // Sektionen initialisieren
        if ($content !== null) {
            $this->sections['content'] = $content;
        }

        // Sektionsconfig initialisieren
        foreach (array_keys($this->sections) as $section) {
            $this->sectionConfig[$section] = [
                'classes' => [],
                'attributes' => []
            ];
        }
    }

    /**
     * Factory-Methode
     *
     * @return static
     */
    public static function create($content = null, string $type = 'primary'): self
    {
        return static::factory()->setContent($content)->setType($type);
    }

    /**
     * Factory-Methoden für spezifische Alert-Typen
     */

    /**
     * Erzeugt ein Success-Alert
     *
     * @param string|null $content Inhalt des Alerts
     * @return static
     */
    public static function success($content = null): self
    {
        return static::create($content, 'success');
    }

    /**
     * Erzeugt ein Danger-Alert
     *
     * @param string|null $content Inhalt des Alerts
     * @return static
     */
    public static function danger($content = null): self
    {
        return static::create($content, 'danger');
    }

    /**
     * Erzeugt ein Warning-Alert
     *
     * @param string|null $content Inhalt des Alerts
     * @return static
     */
    public static function warning($content = null): self
    {
        return static::create($content, 'warning');
    }

    /**
     * Erzeugt ein Info-Alert
     *
     * @param string|null $content Inhalt des Alerts
     * @return static
     */
    public static function info($content = null): self
    {
        return static::create($content, 'info');
    }

    /**
     * Allgemeine Methode zum Setzen einer Sektion
     *
     * @param string $section Name der Sektion (content, heading, icon)
     * @param mixed $content Inhalt der Sektion
     * @param array $attributes Attribute für die Sektion
     * @return $this
     */
    public function setSection(string $section, $content, array $attributes = []): self
    {
        if (!isset($this->sections[$section])) {
            return $this;
        }

        $this->sections[$section] = $content;

        // Klassen aus Attributen extrahieren und zur sectionConfig hinzufügen
        if (isset($attributes['class'])) {
            $classes = $attributes['class'];
            unset($attributes['class']);

            if (is_string($classes)) {
                $classes = explode(' ', $classes);
            }

            $this->sectionConfig[$section]['classes'] = array_filter($classes);
        }

        // Restliche Attribute setzen
        foreach ($attributes as $name => $value) {
            $this->sectionConfig[$section]['attributes'][$name] = $value;
        }

        return $this;
    }

    /**
     * Setzt eine Konfigurationsoption
     *
     * @param string $key Konfigurationsschlüssel
     * @param mixed $value Konfigurationswert
     * @return $this
     */
    public function setConfig(string $key, $value): self
    {
        $this->config[$key] = $value;

        // Bestimmte Konfigurationen haben Auswirkungen auf Klassen
        if ($key === 'type') {
            $this->updateTypeClass($value);
        } elseif ($key === 'dismissible') {
            $this->updateDismissibleClass($value);
        }

        return $this;
    }

    /**
     * Hilfsmethode zum Aktualisieren der Typ-Klasse
     */
    private function updateTypeClass(string $type): void
    {
        $validTypes = ['primary', 'secondary', 'success', 'danger', 'warning', 'info', 'light', 'dark'];

        if (in_array($type, $validTypes)) {
            // Alte Typ-Klasse entfernen
            foreach ($validTypes as $validType) {
                $this->removeClass('alert-' . $validType);
            }

            // Neue Typ-Klasse hinzufügen
            $this->addClass('alert-' . $type);
        }
    }

    /**
     * Hilfsmethode zum Aktualisieren der Dismissible-Klasse
     */
    private function updateDismissibleClass(bool $dismissible): void
    {
        if ($dismissible) {
            $this->addClass('alert-dismissible');
            $this->addClass('fade');
            $this->addClass('show');
        } else {
            $this->removeClass('alert-dismissible');
            $this->removeClass('fade');
            $this->removeClass('show');
        }
    }

    /**
     * Setzt den Alert-Typ
     *
     * @param string $type Alert-Typ (primary, secondary, success, danger, warning, info, light, dark)
     * @return $this
     */
    public function setType(string $type): self
    {
        return $this->setConfig('type', $type);
    }

    /**
     * Setzt, ob der Alert schließbar ist
     *
     * @param bool $dismissible True, wenn der Alert schließbar sein soll
     * @return $this
     */
    public function setDismissible(bool $dismissible = true): self
    {
        return $this->setConfig('dismissible', $dismissible);
    }

    /**
     * Setzt, ob der Alert automatisch ausgeblendet werden soll
     *
     * @param bool $autoHide True, wenn der Alert automatisch ausgeblendet werden soll
     * @param int $delay Verzögerung in Millisekunden
     * @return $this
     */
    public function setAutoHide(bool $autoHide = true, int $delay = 5000): self
    {
        $this->setConfig('autoHide', $autoHide);
        $this->setConfig('autoHideDelay', $delay);

        if ($autoHide) {
            // Schließbar machen, damit das Ausblenden funktioniert
            $this->setDismissible(true);
        }

        return $this;
    }

    /**
     * Methodenspezifische Sektionseinstellungen
     */

    /**
     * Setzt den Inhalt des Alerts
     *
     * @param mixed $content Inhalt des Alerts
     * @param array $attributes Attribute für den Inhalt
     * @return $this
     */
    public function setContent($content, array $attributes = []): self
    {
        return $this->setSection('content', $content, $attributes);
    }

    /**
     * Setzt die Überschrift des Alerts
     *
     * @param string $heading Überschrift des Alerts
     * @param array $attributes Attribute für die Überschrift
     * @return $this
     */
    public function setHeading(string $heading, array $attributes = []): self
    {
        return $this->setSection('heading', $heading, $attributes);
    }

    /**
     * Setzt das Icon des Alerts
     *
     * @param string $icon Icon-HTML oder CSS-Klasse
     * @param array $attributes Attribute für das Icon
     * @return $this
     */
    public function setIcon(string $icon, array $attributes = []): self
    {
        return $this->setSection('icon', $icon, $attributes);
    }

    /**
     * Methoden für Klassen und Attribute der Sektionen
     */

    /**
     * Fügt eine Klasse zu einer Sektion hinzu
     *
     * @param string $section Name der Sektion
     * @param string|array $class CSS-Klasse oder Array von Klassen
     * @return $this
     */
    public function addSectionClass(string $section, $class): self
    {
        if (!isset($this->sectionConfig[$section])) {
            return $this;
        }

        if (is_array($class)) {
            foreach ($class as $c) {
                $this->addSectionClass($section, $c);
            }
            return $this;
        }

        if (is_string($class) && !empty($class) && !in_array($class, $this->sectionConfig[$section]['classes'])) {
            $this->sectionConfig[$section]['classes'][] = $class;
        }

        return $this;
    }

    /**
     * Setzt ein Attribut für eine Sektion
     *
     * @param string $section Name der Sektion
     * @param string $name Name des Attributs
     * @param mixed $value Wert des Attributs
     * @return $this
     */
    public function setSectionAttribute(string $section, string $name, $value): self
    {
        if (!isset($this->sectionConfig[$section])) {
            return $this;
        }

        $this->sectionConfig[$section]['attributes'][$name] = $value;
        return $this;
    }

    /**
     * Überschreibt getComponentKey für korrekte Config-Generierung
     */
    protected function getComponentKey(): ?string
    {
        return 'alert';
    }

    /**
     * Implementiert getContentForFragment für optimierte Datengenerierung
     */
    protected function getContentForFragment()
    {
        return $this->sections;
    }

    /**
     * Implementiert getConfigForFragment für optimierte Konfiguration
     */
    protected function getConfigForFragment(): array
    {
        return [
            'config' => $this->config,
            'sectionConfig' => $this->sectionConfig,
            'defaultClasses' => $this->defaultClasses
        ];
    }

    /**
     * Rendert das Alert direkt (kein Fragment)
     *
     * @return string HTML des Alerts
     */
    protected function renderHtml(): string
    {
        $output = '<div' . $this->buildAttributesString() . '>' . PHP_EOL;

        // Close Button für schließbare Alerts
        if ($this->config['dismissible']) {
            $output .= '  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Schließen"></button>' . PHP_EOL;
        }

        // Icon
        if ($this->sections['icon'] !== null) {
            $icon = $this->sections['icon'];
            $iconClasses = array_merge(
                $this->defaultClasses['icon'],
                $this->sectionConfig['icon']['classes']
            );

            // Wenn Icon eine CSS-Klasse ist und kein HTML
            if (strpos($icon, '<') === false) {
                $output .= '  <i class="' . $icon . ' ' . implode(' ', $iconClasses) . '"></i>' . PHP_EOL;
            } else {
                // Wenn Icon bereits HTML ist
                $output .= '  ' . $icon . PHP_EOL;
            }
        }

        // Überschrift
        if ($this->sections['heading'] !== null) {
            $headingClasses = array_merge(
                $this->defaultClasses['heading'],
                $this->sectionConfig['heading']['classes']
            );
            $headingAttributes = $this->sectionConfig['heading']['attributes'];
            $headingAttributes['class'] = implode(' ', $headingClasses);

            $attributesStr = $this->buildAttributesString($headingAttributes);
            $output .= '  <h4' . $attributesStr . '>' . $this->sections['heading'] . '</h4>' . PHP_EOL;
        }

        // Inhalt
        if ($this->sections['content'] !== null) {
            $content = $this->processContent($this->sections['content']);
            $output .= '  ' . $content . PHP_EOL;
        }

        $output .= '</div>';

        // JavaScript für Auto-Hide
        if ($this->config['autoHide']) {
            $id = $this->getAttribute('id');

            // Wenn keine ID gesetzt wurde, generieren wir eine
            if (!$id) {
                $id = 'alert-' . uniqid();
                $this->setAttribute('id', $id);

                // Update attributesStr with new id
                $output = str_replace('<div', '<div id="' . $id . '"', $output);
            }

            $output .= PHP_EOL . '<script>
  document.addEventListener("DOMContentLoaded", function() {
    const alert = document.getElementById("' . $id . '");
    if (alert) {
      setTimeout(function() {
        const bsAlert = new bootstrap.Alert(alert);
        bsAlert.close();
      }, ' . $this->config['autoHideDelay'] . ');
    }
  });
</script>';
        }

        return $output;
    }
}