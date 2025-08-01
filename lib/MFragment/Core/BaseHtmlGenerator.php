<?php
namespace FriendsOfRedaxo\MFragment\Core;

/**
 * BaseHtmlGenerator
 * 
 * Diese Klasse ist ein Wrapper für FORHtml (falls verfügbar) und stellt die Basis 
 * für die HTML-Generierung in MFragment dar. Funktioniert auch ohne FORHtml.
 */
class BaseHtmlGenerator
{
    protected $htmlBuilder = null;
    private bool $forHtmlAvailable = false;
    
    public function __construct()
    {
        // Prüfen ob FORHtml Addon verfügbar und aktiviert ist
        try {
            if (\rex_addon::get('forhtml')->isAvailable()) {
                $this->htmlBuilder = new \FriendsOfRedaxo\FORHtml\FORHtml();
                $this->forHtmlAvailable = true;
            }
        } catch (\Exception $e) {
            $this->forHtmlAvailable = false;
        }
    }
    
    /**
     * Magic method to forward calls to FORHtml (falls verfügbar)
     */
    public function __call($name, $arguments)
    {
        if ($this->forHtmlAvailable && method_exists($this->htmlBuilder, $name)) {
            return $this->htmlBuilder->$name(...$arguments);
        }
        throw new \Exception("Method $name does not exist or FORHtml is not available in " . get_class($this));
    }
    
    /**
     * Get the underlying FORHtml instance (falls verfügbar)
     */
    public function getBuilder()
    {
        if (!$this->forHtmlAvailable) {
            throw new \Exception("FORHtml is not available. Please install the forhtml addon.");
        }
        return $this->htmlBuilder;
    }
    
    /**
     * Prüft ob FORHtml verfügbar ist
     */
    public function isFORHtmlAvailable(): bool
    {
        return $this->forHtmlAvailable;
    }
    
    /**
     * Create HTML elements (mit Fallback)
     */
    public function element(string $tagName)
    {
        if ($this->forHtmlAvailable) {
            return $this->htmlBuilder->$tagName();
        }
        
        // Fallback: Einfache HTML-Element Klasse
        return new SimpleHtmlElement($tagName);
    }
    
    /**
     * Common HTML elements (mit Fallback)
     */
    public function div()
    {
        return $this->element('div');
    }
    
    public function span()
    {
        return $this->element('span');
    }
    
    public function p()
    {
        return $this->element('p');
    }
    
    public function a(string $href = '')
    {
        $a = $this->element('a');
        if ($href) {
            $a->setAttribute('href', $href);
        }
        return $a;
    }
    
    public function img(string $src = '', string $alt = '')
    {
        $img = $this->element('img');
        if ($src) {
            $img->setAttribute('src', $src);
        }
        if ($alt) {
            $img->setAttribute('alt', $alt);
        }
        return $img;
    }
    
    public function button(string $type = 'button')
    {
        $button = $this->element('button');
        $button->setAttribute('type', $type);
        return $button;
    }
    
    public function form(string $action = '', string $method = 'post')
    {
        $form = $this->element('form');
        if ($action) {
            $form->setAttribute('action', $action);
        }
        $form->setAttribute('method', $method);
        return $form;
    }
    
    public function input(string $type = 'text', string $name = '')
    {
        $input = $this->element('input');
        $input->setAttribute('type', $type);
        if ($name) {
            $input->setAttribute('name', $name);
        }
        return $input;
    }
}

/**
 * Einfache HTML-Element Klasse als Fallback für FORHtml
 */
class SimpleHtmlElement
{
    private string $tag;
    private array $attributes = [];
    private string $content = '';
    
    public function __construct(string $tag)
    {
        $this->tag = $tag;
    }
    
    public function setAttribute(string $key, string $value): self
    {
        $this->attributes[$key] = $value;
        return $this;
    }
    
    public function content(string $content): self
    {
        $this->content = $content;
        return $this;
    }
    
    public function __toString(): string
    {
        $attributes = '';
        if (!empty($this->attributes)) {
            $attrPairs = [];
            foreach ($this->attributes as $key => $value) {
                $attrPairs[] = htmlspecialchars($key) . '="' . htmlspecialchars($value) . '"';
            }
            $attributes = ' ' . implode(' ', $attrPairs);
        }
        
        // Selbstschließende Tags
        $voidElements = ['area', 'base', 'br', 'col', 'embed', 'hr', 'img', 'input', 'link', 'meta', 'param', 'source', 'track', 'wbr'];
        
        if (in_array(strtolower($this->tag), $voidElements)) {
            return "<{$this->tag}{$attributes}>";
        }
        
        return "<{$this->tag}{$attributes}>{$this->content}</{$this->tag}>";
    }
