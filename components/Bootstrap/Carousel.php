<?php

namespace FriendsOfRedaxo\MFragment\Components\Bootstrap;

use FriendsOfRedaxo\MFragment\Components\AbstractComponent;
use FriendsOfRedaxo\MFragment\Components\ComponentInterface;
use rex_media;

/**
 * Komponente für ein Bildkarussell
 */
class Carousel extends AbstractComponent
{
    /**
     * Slides des Karussells
     *
     * @var array
     */
    protected array $slides = [];

    /**
     * Konfiguration des Karussells
     *
     * @var array
     */
    protected array $config = [
        'controls' => true,
        'indicators' => true,
        'autoplay' => false,
        'interval' => 5000,
        'fade' => false,
        'keyboard' => true,
        'pause' => 'hover',
        'wrap' => true,
        'touch' => true,
        'captionPosition' => 'bottom', // bottom, top, left, right, overlay
        'height' => 'auto', // auto, ratio-16x9, ratio-4x3, etc.
    ];

    /**
     * Konstruktor
     */
    public function __construct()
    {
        parent::__construct('');
        $this->addClass('carousel slide');
    }

    /**
     * Factory-Methode
     *
     * @return static
     */
    public static function create(): self
    {
        return static::factory();
    }

    /**
     * Fügt eine Slide mit Bild hinzu
     *
     * @param string|rex_media $image Bild oder rex_media-Objekt
     * @param string $caption Beschriftung des Bildes (optional)
     * @param array $attributes Zusätzliche Attribute für das Bild
     * @return $this Für Method Chaining
     */
    public function addSlide($image, string $caption = '', array $attributes = []): self
    {
        // Wenn ein Medienname übergeben wurde
        if (is_string($image)) {
            $media = rex_media::get($image);
            if ($media) {
                $image = $media;
            }
        }

        $slide = [
            'type' => 'image',
            'media' => $image,
            'caption' => $caption,
            'attributes' => $attributes,
            'active' => empty($this->slides), // Erste Slide ist aktiv
        ];

        $this->slides[] = $slide;
        return $this;
    }

    /**
     * Fügt eine Slide mit HTML-Inhalt hinzu
     *
     * @param string|ComponentInterface $content HTML-Inhalt oder Komponente
     * @param array $attributes Zusätzliche Attribute für die Slide
     * @return $this Für Method Chaining
     */
    public function addContentSlide($content, array $attributes = []): self
    {
        $slide = [
            'type' => 'content',
            'content' => $content,
            'attributes' => $attributes,
            'active' => empty($this->slides), // Erste Slide ist aktiv
        ];

        $this->slides[] = $slide;
        return $this;
    }

    /**
     * Setzt ob Steuerelemente angezeigt werden sollen
     *
     * @param bool $show True, wenn Steuerelemente angezeigt werden sollen
     * @return $this Für Method Chaining
     */
    public function showControls(bool $show = true): self
    {
        $this->config['controls'] = $show;
        return $this;
    }

    /**
     * Setzt ob Indikatoren angezeigt werden sollen
     *
     * @param bool $show True, wenn Indikatoren angezeigt werden sollen
     * @return $this Für Method Chaining
     */
    public function showIndicators(bool $show = true): self
    {
        $this->config['indicators'] = $show;
        return $this;
    }

    /**
     * Setzt ob das Karussell automatisch abgespielt werden soll
     *
     * @param bool $autoplay True, wenn das Karussell automatisch abgespielt werden soll
     * @param int $interval Intervall in Millisekunden zwischen den Slides
     * @return $this Für Method Chaining
     */
    public function setAutoplay(bool $autoplay = true, int $interval = 5000): self
    {
        $this->config['autoplay'] = $autoplay;
        $this->config['interval'] = $interval;
        return $this;
    }

    /**
     * Setzt ob Fade-Effekt verwendet werden soll
     *
     * @param bool $fade True, wenn Fade-Effekt verwendet werden soll
     * @return $this Für Method Chaining
     */
    public function useFade(bool $fade = true): self
    {
        $this->config['fade'] = $fade;
        if ($fade) {
            $this->addClass('carousel-fade');
        } else {
            $this->removeClass('carousel-fade');
        }
        return $this;
    }

    /**
     * Setzt die Position der Beschriftung
     *
     * @param string $position Position der Beschriftung (bottom, top, left, right, overlay)
     * @return $this Für Method Chaining
     */
    public function setCaptionPosition(string $position): self
    {
        if (in_array($position, ['bottom', 'top', 'left', 'right', 'overlay'])) {
            $this->config['captionPosition'] = $position;
        }
        return $this;
    }

    /**
     * Setzt die Höhe des Karussells
     *
     * @param string $height Höhe des Karussells (auto, ratio-16x9, ratio-4x3, etc.)
     * @return $this Für Method Chaining
     */
    public function setHeight(string $height): self
    {
        $this->config['height'] = $height;
        return $this;
    }

    /**
     * Rendert das Karussell
     *
     * @return string HTML-Code des Karussells
     */
    protected function renderHtml(): string
    {
        if (empty($this->slides)) {
            return '<!-- Empty carousel -->';
        }

        $id = $this->getAttribute('id', 'carousel-' . uniqid());
        $this->setAttribute('id', $id);

        if ($this->config['autoplay']) {
            $this->setAttribute('data-bs-ride', 'carousel');
            $this->setAttribute('data-bs-interval', $this->config['interval']);
        }

        if (!$this->config['keyboard']) {
            $this->setAttribute('data-bs-keyboard', 'false');
        }

        if ($this->config['pause'] !== 'hover') {
            $this->setAttribute('data-bs-pause', $this->config['pause']);
        }

        if (!$this->config['wrap']) {
            $this->setAttribute('data-bs-wrap', 'false');
        }

        if (!$this->config['touch']) {
            $this->setAttribute('data-bs-touch', 'false');
        }

        // Height/Ratio-Klasse hinzufügen
        if ($this->config['height'] !== 'auto' && strpos($this->config['height'], 'ratio-') === 0) {
            $this->addClass($this->config['height']);
        }

        $output = '<div' . $this->buildAttributesString() . '>' . PHP_EOL;

        // Indikatoren
        if ($this->config['indicators'] && count($this->slides) > 1) {
            $output .= '  <div class="carousel-indicators">' . PHP_EOL;
            foreach ($this->slides as $index => $slide) {
                $active = $slide['active'] ? ' class="active"' : '';
                $output .= '    <button type="button" data-bs-target="#' . $id . '" data-bs-slide-to="' . $index . '"' . $active . ' aria-label="Slide ' . ($index + 1) . '"></button>' . PHP_EOL;
            }
            $output .= '  </div>' . PHP_EOL;
        }

        // Slides
        $output .= '  <div class="carousel-inner">' . PHP_EOL;
        foreach ($this->slides as $slide) {
            $active = $slide['active'] ? ' active' : '';
            $slideAttributes = isset($slide['attributes']) ? $this->buildAttributesString($slide['attributes']) : '';
            
            $output .= '    <div class="carousel-item' . $active . '"' . $slideAttributes . '>' . PHP_EOL;
            
            if ($slide['type'] === 'image') {
                // Bild-Slide
                $imgAttributes = ['class' => 'd-block w-100'];
                
                if ($slide['media'] instanceof rex_media) {
                    $imgAttributes['src'] = $slide['media']->getUrl();
                    $imgAttributes['alt'] = $slide['media']->getTitle() ?: 'Slide Image';
                } else {
                    $imgAttributes['src'] = $slide['media'];
                    $imgAttributes['alt'] = 'Slide Image';
                }
                
                $output .= '      <img ' . $this->buildAttributesString($imgAttributes) . '>' . PHP_EOL;
                
                // Caption
                if (!empty($slide['caption'])) {
                    $captionClass = 'carousel-caption';
                    
                    // Positionierung der Caption
                    if ($this->config['captionPosition'] !== 'bottom') {
                        $captionClass .= ' caption-' . $this->config['captionPosition'];
                    }
                    
                    $output .= '      <div class="' . $captionClass . '">' . PHP_EOL;
                    $output .= '        ' . $slide['caption'] . PHP_EOL;
                    $output .= '      </div>' . PHP_EOL;
                }
            } else {
                // Content-Slide
                $output .= $this->processContent($slide['content']);
            }
            
            $output .= '    </div>' . PHP_EOL;
        }
        $output .= '  </div>' . PHP_EOL;

        // Steuerelemente
        if ($this->config['controls'] && count($this->slides) > 1) {
            $output .= '  <button class="carousel-control-prev" type="button" data-bs-target="#' . $id . '" data-bs-slide="prev">' . PHP_EOL;
            $output .= '    <span class="carousel-control-prev-icon" aria-hidden="true"></span>' . PHP_EOL;
            $output .= '    <span class="visually-hidden">Zurück</span>' . PHP_EOL;
            $output .= '  </button>' . PHP_EOL;
            $output .= '  <button class="carousel-control-next" type="button" data-bs-target="#' . $id . '" data-bs-slide="next">' . PHP_EOL;
            $output .= '    <span class="carousel-control-next-icon" aria-hidden="true"></span>' . PHP_EOL;
            $output .= '    <span class="visually-hidden">Weiter</span>' . PHP_EOL;
            $output .= '  </button>' . PHP_EOL;
        }

        $output .= '</div>';

        return $output;
    }

    /**
     * Verarbeitet verschiedene Content-Typen zu HTML
     *
     * @param mixed $content Zu verarbeitender Content
     * @return string Verarbeiteter Content
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

}
