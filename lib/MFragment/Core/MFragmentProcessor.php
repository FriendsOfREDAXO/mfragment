<?php
namespace FriendsOfRedaxo\MFragment\Core;

use FriendsOfRedaxo\MFragment;
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

        $output = '';

        if ($content instanceof MFragment) {
            $output .= $this->processMFragmentItems($content->getItems());
        } elseif (is_array($content)) {
            $output .= $this->processArray($content);
        } elseif ($content instanceof MFragmentItem) {
            $output .= $this->processMFragmentItem($content);
        } elseif (is_string($content)) {
            $output .= $content;
        }

        $this->currentDepth--;

        return $output;
    }

    private function processMFragmentItems(array $items): string
    {
        $output = '';
        foreach ($items as $item) {
            $output .= $this->processInternal($item);
        }
        return $output;
    }

    private function processArray(array $content): string
    {
        $output = '';

        // If the content is a single item (not a list of items), wrap it in an array
        if (isset($content['tag']) || isset($content['fragment'])) {
            $content = [$content];
        }

        foreach ($content as $item) {
            if (is_array($item)) {
                if (isset($item['fragment'])) {
                    $output .= MFragment::parse($item['fragment'], $item);
                } elseif (isset($item['tag'])) {
                    $output .= $this->processTag($item);
                } elseif (isset($item['content'])) {
                    $output .= $this->processInternal($item['content']);
                }
            } else {
                $output .= $this->processInternal($item);
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
        } elseif ($item->tag) {
            return $this->processTag([
                'tag' => $item->tag,
                'content' => $item->content,
                'config' => $item->config,
                'attributes' => $item->attributes
            ]);
        }
        return $this->processInternal($item->content);
    }

    private function processTag(array $item): string
    {
        $tag = $item['tag'];
        $attributes = array_merge(($item['attributes'] ?? []), ((isset($item['config']['attributes'])) ? $item['config']['attributes'] : []));
        $attributes = (count($attributes) > 0) ? $this->buildAttributes($attributes) : '';
        $content = isset($item['content']) ? $this->processInternal($item['content']) : '';

        if (in_array($tag, ['area', 'base', 'br', 'col', 'embed', 'hr', 'img', 'input', 'link', 'meta', 'param', 'source', 'track', 'wbr'])) {
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
            } elseif (is_array($value)) {
                if ($this->isAssociativeArray($value)) {
                    $classes = [];
                    foreach ($value as $subKey => $subValue) {
                        if (is_array($subValue)) {
                            $classes = array_merge($classes, $subValue);
                        } else {
                            $classes[] = $subValue;
                        }
                    }
                    $output[] = $key . '="' . htmlspecialchars(implode(' ', $classes), ENT_QUOTES, 'UTF-8') . '"';
                } else {
                    $output[] = $key . '="' . htmlspecialchars(implode(' ', $value), ENT_QUOTES, 'UTF-8') . '"';
                }
            } elseif (is_string($value) && strpos($value, '{') === 0 && strpos($value, '}') === strlen($value) - 1) {
                // Handle strings that look like JSON
                $output[] = $key . "='" . $value . "'";
            } else {
                $output[] = $key . '="' . htmlspecialchars($value, ENT_QUOTES, 'UTF-8') . '"';
            }
        }
        return $output ? ' ' . implode(' ', $output) : '';
    }

    private function isAssociativeArray(array $arr): bool
    {
        if (empty($arr)) return false;
        return array_keys($arr) !== range(0, count($arr) - 1);
    }
}