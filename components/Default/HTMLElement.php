<?php

namespace FriendsOfRedaxo\MFragment\Components\Default;

use FriendsOfRedaxo\MFragment\Components\AbstractComponent;

/**
 * Komponente für einfache HTML-Elemente
 *
 * Diese Komponente ermöglicht die einfache Erstellung von generischen HTML-Elementen
 * mit beliebigen Tags, Attributen und Inhalten.
 */
class HTMLElement extends AbstractComponent
{
    /**
     * HTML-Tag der Komponente
     */
    protected string $tag = 'div';

    /**
     * Inhalt des Elements
     */
    protected mixed $content = null;

    /**
     * Selbstschließende Tags
     */
    protected array $selfClosingTags = [
        'area', 'base', 'br', 'col', 'embed', 'hr', 'img',
        'input', 'link', 'meta', 'param', 'source', 'track', 'wbr'
    ];

    /**
     * Konstruktor
     *
     * @param string $tag HTML-Tag
     * @param mixed $content Inhalt des Elements
     * @param array $attributes HTML-Attribute
     */
    public function __construct(string $tag = 'div', $content = null, array $attributes = [])
    {
        parent::__construct('');
        $this->tag = $tag;
        $this->content = $content;
        $this->attributes = $attributes;
    }

    /**
     * Factory-Methode
     *
     * @param string $tag HTML-Tag
     * @param mixed $content Inhalt des Elements
     * @param array $attributes HTML-Attribute
     * @return static
     */
    public static function create(string $tag, $content = null, array $attributes = []): self
    {
        return static::factory()->setTag($tag)->setContent($content)->setAttributes($attributes);
    }

    /**
     * Setzt den HTML-Tag
     *
     * @param string $tag HTML-Tag
     * @return $this Für Method Chaining
     */
    public function setTag(string $tag): self
    {
        $this->tag = $tag;
        return $this;
    }

    /**
     * Gibt den HTML-Tag zurück
     *
     * @return string HTML-Tag
     */
    public function getTag(): string
    {
        return $this->tag;
    }

    /**
     * Setzt den Inhalt des Elements
     *
     * @param mixed $content Inhalt des Elements
     * @return $this Für Method Chaining
     */
    public function setContent($content): self
    {
        $this->content = $content;
        return $this;
    }

    /**
     * Gibt den Inhalt des Elements zurück
     *
     * @return mixed Inhalt des Elements
     */
    public function getContent()
    {
        return $this->content;
    }

    /**
     * Fügt Inhalt zum bestehenden Inhalt hinzu
     *
     * @param mixed $content Hinzuzufügender Inhalt
     * @return $this Für Method Chaining
     */
    public function addContent($content): self
    {
        if ($this->content === null) {
            $this->content = $content;
        } elseif (is_array($this->content)) {
            $this->content[] = $content;
        } else {
            $this->content = [$this->content, $content];
        }
        return $this;
    }

    /**
     * Prüft, ob das Element ein selbstschließendes Tag ist
     *
     * @return bool True, wenn das Element ein selbstschließendes Tag ist
     */
    public function isSelfClosing(): bool
    {
        return in_array(strtolower($this->tag), $this->selfClosingTags);
    }

    /**
     * Rendert das HTML-Element
     *
     * @return string HTML-Code des Elements
     */
    protected function renderHtml(): string
    {
        $attributesStr = $this->buildAttributesString();

        if ($this->isSelfClosing()) {
            return "<{$this->tag}{$attributesStr}>";
        }

        $content = $this->processContent($this->content);

        return "<{$this->tag}{$attributesStr}>{$content}</{$this->tag}>";
    }

    /**
     * Gibt die Datenstruktur für das Fragment zurück
     * (Wird nicht verwendet, da kein Fragment genutzt wird)
     *
     * @return array Leeres Array, da kein Fragment verwendet wird
     */
    public function getFragmentData(): array
    {
        return [];
    }
}