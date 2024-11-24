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

    public function addTagElement(string $tag, MFragment|array|string $content, array $attributes = []): self
    {
        $this->items[] = new MFragmentItem($tag, false, $content, $this->getConfig($attributes), $this->getAttributes($attributes));
        return $this;
    }

    public function addFragmentElement(string $element, MFragment|array|string|null $content, array $config = []): self
    {
        if ($content === null) return $this;
        $this->items[] = new MFragmentItem(false, $element, $content, $this->getConfig($config), $this->getAttributes($config));
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

    public function addSection(MFragment|array|string $content, array $config = []): self
    {
        if ($content instanceof MFragment) {
            $content = $content->items;
        }
        $this->addFragmentElement("bootstrap/section", $content, $config);
        return $this;
    }

    public function addColumn($content, array $config = []): self
    {
        $defaultConfig = [
            'size' => 12,
            'attributes' => [
                'class' => ['col'],
            ],
        ];

        $columnConfig = array_merge($defaultConfig, $config);

        if (isset($columnConfig['size'])) {
            $columnConfig['attributes']['class'][] = 'col-' . $columnConfig['size'];
        }

        $this->items[] = new MFragmentItem('div', false, $content, $columnConfig, $columnConfig['attributes']);

        return $this;
    }

    /**
     * Add multiple columns using the columns fragment
     *
     * @param MFragment $columns MFragment containing columns
     * @param array $config Configuration for the column wrapper (row)
     * @return $this
     */
    public function addColumns(MFragment $columns, array $config = []): self
    {
        $columnItems = array_map(function(MFragmentItem $item) {
            return [
                'content' => $item->content,
                'config' => array_merge($item->config, ['attributes' => $item->attributes])
            ];
        }, $columns->items);

        $this->addFragmentElement('bootstrap/columns', [
            'columns' => $columnItems,
            'config' => [
                'wrapper' => $config,
                'column' => [] // Default column config, can be overridden per column
            ]
        ]);

        return $this;
    }

    public function addImages(array $images, array $config = []): self
    {
        return $this->addFragmentElement('bootstrap/images', $images, $config);
    }

    public function addCard(MFragment|array|string $header = null, MFragment|array|string $body = null, MFragment|array|string $footer = null, array $config = []): self
    {
        $this->addFragmentElement(
            "bootstrap/card",
            [
                'header' => ['content' => $header],
                'body' => ['content' => $body],
                'footer' => ['content' => $footer],
            ],
            $config
        );
        return $this;
    }

    public function addAccordion(?array $items, array $config = []): self
    {
        if (!is_array($items)) return $this;

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
            "bootstrap/accordion",
            $processedItems,
            $config
        );
        return $this;
    }

    public function getItems(): array
    {
        return $this->items;
    }
}