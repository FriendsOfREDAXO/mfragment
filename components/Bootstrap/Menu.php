<?php
# path: src/addons/mfragment/components/Bootstrap/Menu.php
namespace FriendsOfRedaxo\MFragment\Components\Bootstrap;

use FriendsOfRedaxo\MFragment\Components\AbstractComponent;
use rex_string;

/**
 * Bootstrap Menu Component
 * 
 * Moderne Menu-Komponente die das bootstrap/menu Fragment ersetzt.
 * Unterstützt Navigation-Items mit verschachtelten Menüs, externen Links
 * und umfangreiche Konfigurationsmöglichkeiten.
 */
class Menu extends AbstractComponent
{
    /**
     * Menu-Items
     */
    private array $items = [];
    
    /**
     * Menu-Konfiguration
     */
    private array $config = [];
    
    /**
     * Wrapper-Tag (div oder ul)
     */
    private string $wrapperTag = 'ul';
    
    /**
     * Item-Tag (div oder li)
     */
    private string $itemTag = 'li';

    /**
     * Setzt die Menu-Items
     *
     * @param array $items Navigation-Items
     * @return $this
     */
    public function setItems(array $items): self
    {
        $this->items = array_filter($items, function($item) {
            return is_array($item) && (!isset($item['visible']) || $item['visible'] !== false);
        });
        return $this;
    }

    /**
     * Fügt ein Menu-Item hinzu
     *
     * @param array $item Navigation-Item
     * @return $this
     */
    public function addItem(array $item): self
    {
        if (is_array($item) && (!isset($item['visible']) || $item['visible'] !== false)) {
            $this->items[] = $item;
        }
        return $this;
    }

    /**
     * Setzt die Menu-Konfiguration
     *
     * @param array $config Konfiguration
     * @return $this
     */
    public function setConfig(array $config): self
    {
        $this->config = $config;
        return $this;
    }

    /**
     * Setzt den Menu-Typ (div oder list)
     *
     * @param string $type 'div' oder 'list'/'ul'
     * @return $this
     */
    public function setType(string $type): self
    {
        if ($type === 'list' || $type === 'ul') {
            $this->wrapperTag = 'ul';
            $this->itemTag = 'li';
        } else {
            $this->wrapperTag = 'div';
            $this->itemTag = 'div';
        }
        return $this;
    }

    /**
     * Setzt Wrapper-Klassen
     *
     * @param string $class CSS-Klassen für Wrapper
     * @return $this
     */
    public function setWrapperClass(string $class): self
    {
        $this->config['class']['wrapper'] = $class;
        return $this;
    }

    /**
     * Prüft ob URL extern ist
     */
    private function isExternalUrl(string $url): bool
    {
        if (empty($url) || $url === '#') {
            return false;
        }
        
        $parsedUrl = parse_url($url);
        if (!isset($parsedUrl['host'])) {
            return false;
        }
        
        $currentHost = $_SERVER['HTTP_HOST'] ?? '';
        return strcasecmp($parsedUrl['host'], $currentHost) !== 0;
    }

    /**
     * Holt Yrewrite Redirect URL falls vorhanden
     */
    private function getYrewriteRedirectUrl(array $item): ?string
    {
        if (isset($item['catObject']) && $item['catObject'] instanceof \rex_category) {
            $article = $item['catObject'];
            if ($article->getValue('yrewrite_url_type') === 'REDIRECTION_EXTERNAL') {
                $redirectUrl = $article->getValue('yrewrite_redirection');
                if (!empty($redirectUrl)) {
                    return $redirectUrl;
                }
            }
        }
        
        if (isset($item['catId']) && is_numeric($item['catId'])) {
            $article = \rex_article::get($item['catId']);
            if ($article && $article->getValue('yrewrite_url_type') === 'REDIRECTION_EXTERNAL') {
                $redirectUrl = $article->getValue('yrewrite_redirection');
                if (!empty($redirectUrl)) {
                    return $redirectUrl;
                }
            }
        }
        
        return null;
    }

    /**
     * Rendert ein einzelnes Menu-Item
     */
    private function renderMenuItem(array $item, int $count, int $totalItems): string
    {
        // URL und Name ermitteln
        $url = $item['url'] ?? '#';
        $externalRedirectUrl = $this->getYrewriteRedirectUrl($item);
        $isYrewriteRedirect = false;
        
        if ($externalRedirectUrl) {
            $url = $externalRedirectUrl;
            $isYrewriteRedirect = true;
        }
        
        $name = $item['name'] ?? $item['catName'] ?? '';
        if (empty($name) && isset($item['catObject']) && $item['catObject'] instanceof \rex_category) {
            $name = $item['catObject']->getValue('name');
        }

        // Externe URL prüfen
        $isExternal = $this->isExternalUrl($url);
        
        // CSS-Klassen
        $linkClass = $this->config['class']['link'] ?? 'nav-link';
        $itemClass = $this->config['class']['item'] ?? 'nav-item';
        $textClass = $this->config['class']['text'] ?? 'nav-link-title';

        // Attribute
        $linkAttributes = $item['attributes']['link'] ?? [];
        $itemAttributes = $item['attributes']['item'] ?? [];
        $textAttributes = $item['attributes']['text'] ?? [];

        // Externe Links und Redirects
        if ($isExternal || $isYrewriteRedirect) {
            $linkAttributes['target'] = '_blank';
            $linkAttributes['rel'] = 'noopener noreferrer';
        }

        // Item ID
        if (isset($item['id'])) {
            $itemAttributes['id'] = $item['id'];
        }

        // Kinder-Menü
        $hasChildren = isset($item['hasChildren']) && !empty($item['children']);
        if ($hasChildren) {
            $linkClass .= ' ' . ($this->config['hasChild']['class']['link'] ?? 'hasChild');
            $itemClass .= ' ' . ($this->config['hasChild']['class']['item'] ?? 'hasChild');
            
            if (isset($this->config['hasChild']['attributes']['link'])) {
                $linkAttributes = array_merge($linkAttributes, $this->config['hasChild']['attributes']['link']);
            }
        }

        // Erste/Letzte Item-Klassen
        if ($count === 1) {
            $linkClass .= ' first-link-child';
            $itemClass .= ' first-child';
        }
        if ($count === $totalItems) {
            $linkClass .= ' last-link-child';
            $itemClass .= ' last-child';
        }

        // Aktiv/Current Status
        if (isset($item['active']) && $item['active']) {
            $linkClass .= ' ' . ($this->config['active']['class']['link'] ?? 'active');
            $itemClass .= ' ' . ($this->config['active']['class']['item'] ?? 'active');
        }
        
        if (isset($item['current']) && $item['current']) {
            $linkClass .= ' ' . ($this->config['current']['class']['link'] ?? 'current');
            $itemClass .= ' ' . ($this->config['current']['class']['item'] ?? 'current');
        }

        // Fix Klassen
        $linkClass .= ' ed0';
        $itemClass .= ' ed0';

        // Legend-Behandlung
        if (!empty($item['legend'])) {
            $name = $item['legend'];
            unset($url);
            $linkClass = '';
        }

        // HTML rendern
        $html = "<{$this->itemTag} class=\"{$itemClass}\"" . rex_string::buildAttributes($itemAttributes) . ">";
        
        if (isset($url)) {
            $html .= "<a class=\"{$linkClass}\" href=\"{$url}\"" . rex_string::buildAttributes($linkAttributes) . ">";
        } elseif (!empty($linkClass)) {
            $html .= "<span class=\"{$linkClass}\">";
        }
        
        $html .= "<span class=\"{$textClass}\"" . rex_string::buildAttributes($textAttributes) . ">{$name}</span>";
        
        if (isset($url)) {
            $html .= "</a>";
        } elseif (!empty($linkClass)) {
            $html .= "</span>";
        }

        // Kinder-Menü rekursiv rendern
        if ($hasChildren) {
            $childConfig = $this->config['childrenConfig'] ?? [];
            $childConfig['items'] = $item['children'];
            
            $childMenu = self::factory()
                ->setItems($item['children'])
                ->setConfig($childConfig)
                ->setType($this->wrapperTag === 'ul' ? 'list' : 'div');

            $html .= $childMenu->show();
        }
        
        $html .= "</{$this->itemTag}>";
        
        return $html;
    }

    /**
     * Rendert die Menu-Komponente als HTML
     */
    protected function renderHtml(): string
    {
        if (empty($this->items)) {
            return '';
        }

        // Wrapper-Konfiguration
        $wrapperClass = $this->config['class']['wrapper'] ?? 'navbar-nav';
        $wrapperAttributes = $this->config['attributes']['wrapper'] ?? [];
        
        // Menu-Items rendern
        $itemsHtml = '';
        $count = 0;
        $totalItems = count($this->items);
        
        foreach ($this->items as $item) {
            $count++;
            
            // Fragment-Items (für Rückwärtskompatibilität)
            if (isset($item['fragment'])) {
                // Legacy Fragment-Aufruf - sollte zu Component migriert werden
                $itemsHtml .= "<!-- TODO: Migrate fragment '{$item['fragment']}' to Component -->";
                continue;
            }
            
            $itemsHtml .= $this->renderMenuItem($item, $count, $totalItems);
        }

        // Wrapper-HTML
        $wrapperAttributesString = rex_string::buildAttributes($wrapperAttributes);
        
        return "<{$this->wrapperTag} class=\"{$wrapperClass}\"{$wrapperAttributesString}>" . 
               $itemsHtml . 
               "</{$this->wrapperTag}>";
    }
}
