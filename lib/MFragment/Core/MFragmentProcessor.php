<?php
# path: src/addons/mfragment/lib/MFragment/Core/MFragmentProcessor.php
namespace FriendsOfRedaxo\MFragment\Core;

use FriendsOfRedaxo\MFragment;
use FriendsOfRedaxo\MFragment\Components\ComponentInterface;
use FriendsOfRedaxo\MFragment\DTO\MFragmentItem;

class MFragmentProcessor
{
    private int $maxRecursionDepth;
    private int $currentDepth = 0;

    public function __construct(int $maxRecursionDepth = 100)
    {
        $this->maxRecursionDepth = $maxRecursionDepth;
    }

    public function process($content): string
    {
        $this->currentDepth = 0;
        return $this->processInternal($content);
    }

    public function parse($content): string
    {
        return $this->process($content);
    }

    private function processInternal($content): string
    {
        if ($this->currentDepth >= $this->maxRecursionDepth) {
            return '<!-- Max recursion depth reached -->';
        }

        $this->currentDepth++;
        $output = $this->renderContent($content);
        $this->currentDepth--;

        return $output;
    }

    /**
     * Zentrale Methode zum Rendern verschiedener Content-Typen
     */
    private function renderContent($content): string
    {
        return match(true) {
            $content instanceof ComponentInterface => $content->show(),
            $content instanceof MFragment => $this->processMFragmentItems($content->getItems()),
            is_array($content) => $this->processArray($content),
            $content instanceof MFragmentItem => $this->processMFragmentItem($content),
            is_string($content) => $content,
            default => ''
        };
    }

    private function processMFragmentItems(array $items): string
    {
        return implode('', array_map([$this, 'processInternal'], $items));
    }

    private function processArray(array $content): string
    {
        // If the content is a single item (not a list of items), wrap it in an array
        if (isset($content['tag']) || isset($content['fragment'])) {
            $content = [$content];
        }

        $output = '';
        foreach ($content as $item) {
            if (!is_array($item)) {
                $output .= $this->renderContent($item);
                continue;
            }

            if (isset($item['fragment'])) {
                $output .= MFragment::parse($item['fragment'], $item);
            } elseif (isset($item['tag'])) {
                $output .= $this->processTag($item);
            } elseif (isset($item['content'])) {
                $output .= $this->renderContent($item['content']);
            }
        }

        return $output;
    }

    private function processMFragmentItem(MFragmentItem $item): string
    {
        if ($item->fragment) {
            return MFragment::parse($item->fragment, [
                'content' => $item->content,
                'config' => $item->config,
                'attributes' => $item->attributes,
            ]);
        }

        if ($item->tag) {
            return $this->processTag([
                'tag' => $item->tag,
                'content' => $item->content,
                'config' => $item->config,
                'attributes' => $item->attributes
            ]);
        }

        return $this->renderContent($item->content);
    }

    private function processTag(array $item): string
    {
        $tag = $item['tag'];
        $attributes = array_merge(($item['attributes'] ?? []), ((isset($item['config']['attributes'])) ? $item['config']['attributes'] : []));
        $attributes = (count($attributes) > 0) ? $this->buildAttributes($attributes) : '';
        $content = isset($item['content']) ? $this->renderContent($item['content']) : '';

        if ($tag === 'contentOnly') {
            return $content;
        }

        $selfClosingTags = ['area', 'base', 'br', 'col', 'embed', 'hr', 'img', 'input', 'link', 'meta', 'param', 'source', 'track', 'wbr'];

        if (in_array($tag, $selfClosingTags)) {
            return "<{$tag}{$attributes}>";
        }

        return "<{$tag}{$attributes}>{$content}</{$tag}>";
    }

    private function buildAttributes(array $attributes): string
    {
        $output = [];

        foreach ($attributes as $key => $value) {
            if ($value === null || $value === false) {
                continue;
            }

            if ($value === true) {
                $output[] = $key;
                continue;
            }

            if (is_array($value)) {
                $processedValue = ($key === 'class')
                    ? $this->processClassArray($value)
                    : $this->processArrayValue($value);

                $output[] = $key . '="' . htmlspecialchars($processedValue, ENT_QUOTES, 'UTF-8') . '"';
                continue;
            }

            // Handle JSON-like strings
            if (is_string($value) && str_starts_with($value, '{') && str_ends_with($value, '}')) {
                $output[] = $key . "='" . $value . "'";
            } else {
                $output[] = $key . '="' . htmlspecialchars($value, ENT_QUOTES, 'UTF-8') . '"';
            }
        }

        return $output ? ' ' . implode(' ', $output) : '';
    }

    private function processClassArray(array $value): string
    {
        $allClasses = [];

        foreach ($value as $key => $val) {
            // Handle nested arrays
            if (is_array($val)) {
                foreach ($val as $subVal) {
                    if (is_string($subVal) && !in_array($subVal, $allClasses)) {
                        $allClasses[] = $subVal;
                    }
                }
                continue;
            }

            // Handle normal values
            if (is_string($val) && !in_array($val, $allClasses)) {
                $allClasses[] = $val;
            }
        }

        return implode(' ', array_filter($allClasses));
    }

    private function processArrayValue(array $value): string
    {
        $classes = [];

        foreach ($value as $subValue) {
            if (is_array($subValue)) {
                $classes[] = $this->processArrayValue($subValue);
            } else {
                $classes[] = $subValue;
            }
        }

        return implode(' ', array_filter($classes));
    }

    private function isAssociativeArray(array $arr): bool
    {
        if (empty($arr)) return false;
        return array_keys($arr) !== range(0, count($arr) - 1);
    }
}