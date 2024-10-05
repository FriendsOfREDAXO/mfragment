<?php
/**
 * User: joachimdoerr
 * Date: 04.10.24
 * Time: 12:15
 */

namespace FriendsOfRedaxo\MFragment;

use FriendsOfRedaxo\MFragment;
use FriendsOfRedaxo\MFragment\DTO\MFragmentItem;
use FriendsOfRedaxo\MFragment\Helper\MFragmentHelper;

abstract class MFragmentElements
{
    /** @var MFragmentItem[] */
    public array $items = [];
    private string $theme = 'bootstrap';

    public function addTagElement(string $tag, array|string $content, array $attributes = []): self
    {
        $this->items[] = new MFragmentItem($tag, false, $content, $this->getConfig($attributes), $this->getAttributes($attributes));
        return $this;
    }

    public function addFragmentElement(string $element, array|string $content, array $config = []): self
    {
        $this->items[] = new MFragmentItem(false, "{$this->theme}/$element", $content, $this->getConfig($config), $this->getAttributes($config));
        return $this;
    }

    private function getAttributes(array $arr): array
    {
        if (isset($arr['attributes'])) {
            return $arr['attributes'];
        }
        return $arr;
    }

    private function getConfig(array $arr): array
    {
        if (isset($arr['attributes'])) {
            unset($arr['attributes']);
        }
        return $arr;
    }

    public function addSection(MFragment|array|string $content, array|bool $sectionConfig = [], array|bool $containerConfig = []): self
    {
        $config = [];
        if (is_array($sectionConfig)) {
            $config['showSection'] = true;
            $config['section'] = $sectionConfig;
        } else {
            $config['showSection'] = $sectionConfig;
        }
        if (is_array($containerConfig)) {
            $config['showContainer'] = true;
            $config['container'] = $containerConfig;
        } else {
            $config['showContainer'] = $containerConfig;
        }
        if ($content instanceof MFragment) {
            $content = $content->items;
        }
        $this->addFragmentElement("section", $content, $config);
        return $this;
    }

    public function addCard(MFragment|array|string $header = null, MFragment|array|string $body = null, MFragment|array|string $footer = null, array $config = [], $headerConfig = [], array $bodyConfig = [], array $footerConfig = []): self
    {
        $this->addFragmentElement(
            "card",
            [
                'header' => array_merge(['content' => $header], $headerConfig),
                'body' => array_merge(['content' => $body], $bodyConfig),
                'footer' => array_merge(['content' => $footer], $footerConfig),
            ],
            [
                'card' => $config,
                'header' => $headerConfig,
                'body' => $bodyConfig,
                'footer' => $footerConfig,
            ]
        );
        return $this;
    }

    public function addAccordion(array $items, array $config = []): self
    {
        $processedItems = [];
        foreach ($items as $item) {
            $processedItems[] = [
                'header' => $item['header'] ?? '',
                'content' => $item['content'] ?? '',
                'config' => $item['config'] ?? [],
                'show' => $item['show'] ?? false
            ];
        }
        $this->addFragmentElement(
            "accordion",
            $processedItems,
            $config
        );
        return $this;
    }

    public function setTheme(string $theme): self
    {
        $this->theme = $theme;
        return $this;
    }

    public function getItems(): array
    {
        return $this->items;
    }
}