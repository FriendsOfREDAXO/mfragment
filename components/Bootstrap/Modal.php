<?php

namespace FriendsOfRedaxo\MFragment\Components\Bootstrap;

use FriendsOfRedaxo\MFragment\Components\AbstractComponent;
use FriendsOfRedaxo\MFragment\Components\ComponentInterface;

/**
 * Komponente für modale Dialoge
 */
class Modal extends AbstractComponent
{
    /**
     * Inhalt des Modals
     *
     * @var string|ComponentInterface
     */
    protected $content;

    /**
     * Titel des Modals
     *
     * @var string|null
     */
    protected ?string $title = null;

    /**
     * Footer-Inhalt des Modals
     *
     * @var string|ComponentInterface|null
     */
    protected $footer = null;

    /**
     * Größe des Modals
     *
     * @var string
     */
    protected string $size = '';

    /**
     * Position des Modals (zentriert, seitlich, etc.)
     *
     * @var string
     */
    protected string $position = '';

    /**
     * Gibt an, ob der Modal-Dialog scrollbar sein soll
     *
     * @var bool
     */
    protected bool $scrollable = false;

    /**
     * Gibt an, ob der Backdrop des Modals statisch sein soll (schließt nicht bei Klick auf Backdrop)
     *
     * @var bool
     */
    protected bool $staticBackdrop = false;

    /**
     * Gibt an, ob der Modal-Dialog animiert sein soll
     *
     * @var bool
     */
    protected bool $animation = true;

    /**
     * Gibt an, ob der Close-Button im Header angezeigt werden soll
     *
     * @var bool
     */
    protected bool $showCloseButton = true;

    /**
     * Gibt an, ob der Modal-Dialog beim Aufruf der Methode show() geöffnet werden soll
     *
     * @var bool
     */
    protected bool $openOnRender = false;

    /**
     * ID des Buttons oder Links, der das Modal öffnet
     *
     * @var string|null
     */
    protected ?string $triggerId = null;

    /**
     * Text des generierten Trigger-Buttons, falls kein Trigger-ID angegeben wurde
     *
     * @var string|null
     */
    protected ?string $triggerText = null;

    /**
     * Klassen für den Trigger-Button
     *
     * @var array
     */
    protected array $triggerClasses = ['btn', 'btn-primary'];

    /**
     * Konstruktor
     *
     * @param string|ComponentInterface $content Inhalt des Modals
     * @param string|null $title Titel des Modals
     * @param string|ComponentInterface|null $footer Footer-Inhalt des Modals
     */
    public function __construct($content, ?string $title = null, $footer = null)
    {
        parent::__construct('');
        $this->content = $content;
        $this->title = $title;
        $this->footer = $footer;
        
        // Standard-Klassen setzen
        $this->addClass('modal');
        $this->addClass('fade');
        
        // Standard-Attribute setzen
        $this->setAttribute('tabindex', '-1');
        $this->setAttribute('aria-hidden', 'true');
    }

    /**
     * Factory-Methode
     *
     * @param string|ComponentInterface $content Inhalt des Modals
     * @param string|null $title Titel des Modals
     * @param string|ComponentInterface|null $footer Footer-Inhalt des Modals
     * @return static
     */
    public static function create($content, ?string $title = null, $footer = null): self
    {
        return static::factory()->setContent($content)->setTitle($title)->setFooter($footer);
    }

    /**
     * Setzt den Inhalt des Modals
     *
     * @param string|ComponentInterface $content Inhalt des Modals
     * @return $this Für Method Chaining
     */
    public function setContent($content): self
    {
        $this->content = $content;
        return $this;
    }

    /**
     * Setzt den Titel des Modals
     *
     * @param string|null $title Titel des Modals
     * @return $this Für Method Chaining
     */
    public function setTitle(?string $title): self
    {
        $this->title = $title;
        return $this;
    }

    /**
     * Setzt den Footer-Inhalt des Modals
     *
     * @param string|ComponentInterface|null $footer Footer-Inhalt des Modals
     * @return $this Für Method Chaining
     */
    public function setFooter($footer): self
    {
        $this->footer = $footer;
        return $this;
    }

    /**
     * Fügt einen Schließen-Button zum Footer hinzu
     *
     * @param string $text Text des Buttons
     * @param array $classes CSS-Klassen für den Button
     * @return $this Für Method Chaining
     */
    public function addCloseButton(string $text = 'Schließen', array $classes = ['btn', 'btn-secondary']): self
    {
        $closeButton = '<button type="button" class="' . implode(' ', $classes) . '" data-bs-dismiss="modal">' . $text . '</button>';
        
        if ($this->footer) {
            if (is_string($this->footer)) {
                $this->footer .= ' ' . $closeButton;
            } elseif ($this->footer instanceof ComponentInterface) {
                // Wenn der Footer eine Komponente ist, können wir nur einen neuen Footer setzen
                $this->footer = $this->footer->show() . ' ' . $closeButton;
            }
        } else {
            $this->footer = $closeButton;
        }
        
        return $this;
    }

    /**
     * Fügt einen Bestätigen-Button zum Footer hinzu
     *
     * @param string $text Text des Buttons
     * @param string|null $onclick JavaScript-Code für onClick-Event
     * @param array $classes CSS-Klassen für den Button
     * @return $this Für Method Chaining
     */
    public function addConfirmButton(string $text = 'Bestätigen', ?string $onclick = null, array $classes = ['btn', 'btn-primary']): self
    {
        $onclickAttr = $onclick ? ' onclick="' . htmlspecialchars($onclick, ENT_QUOTES, 'UTF-8') . '"' : '';
        $confirmButton = '<button type="button" class="' . implode(' ', $classes) . '"' . $onclickAttr . '>' . $text . '</button>';
        
        if ($this->footer) {
            if (is_string($this->footer)) {
                $this->footer .= ' ' . $confirmButton;
            } elseif ($this->footer instanceof ComponentInterface) {
                // Wenn der Footer eine Komponente ist, können wir nur einen neuen Footer setzen
                $this->footer = $this->footer->show() . ' ' . $confirmButton;
            }
        } else {
            $this->footer = $confirmButton;
        }
        
        return $this;
    }

    /**
     * Setzt die Größe des Modals
     *
     * @param string $size Größe des Modals (sm, lg, xl)
     * @return $this Für Method Chaining
     */
    public function setSize(string $size): self
    {
        $validSizes = ['sm', 'lg', 'xl'];
        
        if (in_array($size, $validSizes)) {
            // Alte Größenklasse entfernen, wenn vorhanden
            foreach ($validSizes as $validSize) {
                $this->removeClass('modal-' . $validSize);
            }
            
            $this->size = $size;
        }
        
        return $this;
    }

    /**
     * Setzt die Position des Modals
     *
     * @param string $position Position des Modals (centered, fullscreen, bottom, top-left, top-right, bottom-left, bottom-right)
     * @return $this Für Method Chaining
     */
    public function setPosition(string $position): self
    {
        $validPositions = ['centered', 'fullscreen', 'bottom', 'top-left', 'top-right', 'bottom-left', 'bottom-right'];
        
        if (in_array($position, $validPositions)) {
            $this->position = $position;
        }
        
        return $this;
    }

    /**
     * Setzt, ob der Modal-Dialog scrollbar sein soll
     *
     * @param bool $scrollable True, wenn der Modal-Dialog scrollbar sein soll
     * @return $this Für Method Chaining
     */
    public function setScrollable(bool $scrollable = true): self
    {
        $this->scrollable = $scrollable;
        return $this;
    }

    /**
     * Setzt, ob der Backdrop des Modals statisch sein soll
     *
     * @param bool $staticBackdrop True, wenn der Backdrop statisch sein soll
     * @return $this Für Method Chaining
     */
    public function setStaticBackdrop(bool $staticBackdrop = true): self
    {
        $this->staticBackdrop = $staticBackdrop;
        
        if ($staticBackdrop) {
            $this->setAttribute('data-bs-backdrop', 'static');
            $this->setAttribute('data-bs-keyboard', 'false');
        } else {
            $this->removeAttribute('data-bs-backdrop');
            $this->removeAttribute('data-bs-keyboard');
        }
        
        return $this;
    }

    /**
     * Setzt, ob der Modal-Dialog animiert sein soll
     *
     * @param bool $animation True, wenn der Modal-Dialog animiert sein soll
     * @return $this Für Method Chaining
     */
    public function setAnimation(bool $animation = true): self
    {
        $this->animation = $animation;
        
        if ($animation) {
            $this->addClass('fade');
        } else {
            $this->removeClass('fade');
        }
        
        return $this;
    }

    /**
     * Setzt, ob der Close-Button im Header angezeigt werden soll
     *
     * @param bool $show True, wenn der Close-Button angezeigt werden soll
     * @return $this Für Method Chaining
     */
    public function showCloseButton(bool $show = true): self
    {
        $this->showCloseButton = $show;
        return $this;
    }

    /**
     * Setzt, ob das Modal beim Aufruf der Methode show() geöffnet werden soll
     *
     * @param bool $open True, wenn das Modal geöffnet werden soll
     * @return $this Für Method Chaining
     */
    public function setOpenOnRender(bool $open = true): self
    {
        $this->openOnRender = $open;
        return $this;
    }

    /**
     * Setzt die ID des Buttons oder Links, der das Modal öffnet
     *
     * @param string|null $triggerId ID des Trigger-Elements
     * @return $this Für Method Chaining
     */
    public function setTriggerId(?string $triggerId): self
    {
        $this->triggerId = $triggerId;
        return $this;
    }

    /**
     * Generiert einen Button, der das Modal öffnet
     *
     * @param string $text Text des Buttons
     * @param array $classes CSS-Klassen für den Button
     * @return $this Für Method Chaining
     */
    public function setTriggerButton(string $text, array $classes = ['btn', 'btn-primary']): self
    {
        $this->triggerText = $text;
        $this->triggerClasses = $classes;
        return $this;
    }

    /**
     * Rendert das Modal
     *
     * @return string HTML-Code des Modals
     */
    protected function renderHtml(): string
    {
        // Eindeutige ID für das Modal generieren
        $id = $this->getAttribute('id');
        if (!$id) {
            $id = 'modal-' . uniqid();
            $this->setAttribute('id', $id);
        }
        
        // Dialog-Klassen und Content vorbereiten
        $dialogClasses = ['modal-dialog'];
        
        // Dialoggröße
        if ($this->size) {
            $dialogClasses[] = 'modal-' . $this->size;
        }
        
        // Dialogposition
        if ($this->position) {
            switch ($this->position) {
                case 'centered':
                    $dialogClasses[] = 'modal-dialog-centered';
                    break;
                case 'fullscreen':
                    $dialogClasses[] = 'modal-fullscreen';
                    break;
                case 'bottom':
                    $dialogClasses[] = 'modal-dialog-bottom';
                    break;
                case 'top-left':
                    $dialogClasses[] = 'modal-dialog-top-left';
                    break;
                case 'top-right':
                    $dialogClasses[] = 'modal-dialog-top-right';
                    break;
                case 'bottom-left':
                    $dialogClasses[] = 'modal-dialog-bottom-left';
                    break;
                case 'bottom-right':
                    $dialogClasses[] = 'modal-dialog-bottom-right';
                    break;
            }
        }
        
        // Scrollbar
        if ($this->scrollable) {
            $dialogClasses[] = 'modal-dialog-scrollable';
        }
        
        // Modal-HTML generieren
        $output = '<div' . $this->buildAttributesString() . '>' . PHP_EOL;
        $output .= '  <div class="' . implode(' ', $dialogClasses) . '">' . PHP_EOL;
        $output .= '    <div class="modal-content">' . PHP_EOL;
        
        // Header mit Titel
        if ($this->title || $this->showCloseButton) {
            $output .= '      <div class="modal-header">' . PHP_EOL;
            
            if ($this->title) {
                $output .= '        <h5 class="modal-title">' . $this->title . '</h5>' . PHP_EOL;
            }
            
            if ($this->showCloseButton) {
                $output .= '        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Schließen"></button>' . PHP_EOL;
            }
            
            $output .= '      </div>' . PHP_EOL;
        }
        
        // Body mit Inhalt
        $output .= '      <div class="modal-body">' . PHP_EOL;
        $output .= '        ' . $this->processContent($this->content) . PHP_EOL;
        $output .= '      </div>' . PHP_EOL;
        
        // Footer
        if ($this->footer) {
            $output .= '      <div class="modal-footer">' . PHP_EOL;
            $output .= '        ' . $this->processContent($this->footer) . PHP_EOL;
            $output .= '      </div>' . PHP_EOL;
        }
        
        $output .= '    </div>' . PHP_EOL;
        $output .= '  </div>' . PHP_EOL;
        $output .= '</div>' . PHP_EOL;
        
        // Trigger-Button generieren, wenn kein Trigger-ID angegeben wurde
        if (!$this->triggerId && $this->triggerText) {
            $triggerId = 'trigger-' . $id;
            $output = '<button type="button" class="' . implode(' ', $this->triggerClasses) . '" id="' . $triggerId . '" data-bs-toggle="modal" data-bs-target="#' . $id . '">' . $this->triggerText . '</button>' . PHP_EOL . $output;
            $this->triggerId = $triggerId;
        }
        
        // JavaScript für automatisches Öffnen
        if ($this->openOnRender) {
            $output .= '<script>
  document.addEventListener("DOMContentLoaded", function() {
    const modalElement = document.getElementById("' . $id . '");
    if (modalElement) {
      const modal = new bootstrap.Modal(modalElement);
      modal.show();
    }
  });
</script>' . PHP_EOL;
        }
        
        return $output;
    }

    /**
     * Verarbeitet Content verschiedener Typen
     *
     * @param mixed $content Zu verarbeitender Inhalt
     * @return string Verarbeiteter Inhalt als String
     */
    protected function processContent($content): string
    {
        if ($content instanceof ComponentInterface) {
            return $content->show();
        } elseif (is_string($content)) {
            return $content;
        } else {
            return '';
        }
    }

    /**
     * Gibt die Datenstruktur für das Fragment zurück
     * (Wird nicht verwendet, da kein Fragment-Aufruf)
     *
     * @return array Leeres Array
     */
    public function getFragmentData(): array
    {
        return [];
    }
}
