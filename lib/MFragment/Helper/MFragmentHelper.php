<?php
namespace FriendsOfRedaxo\MFragment\Helper;

class MFragmentHelper
{
    public static function createTag(string $tag, $content = null, array $config = []): array
    {
        $element = [
            'tag' => $tag,
        ];
        if ($content !== null) {
            $element['content'] = $content;
        }
        if (!empty($config)) {
            $element['config'] = $config;
        }
        return $element;
    }

    public static function createFragment(string $fragmentName, array $params = []): array
    {
        return array_merge(['fragment' => $fragmentName], $params);
    }

    public static function mergeConfig($default, $custom)
    {
        $result = $default;
        foreach ($custom as $key => $value) {
            if (isset($default[$key]) && is_array($default[$key]) && is_array($value)) {
                if ($key === 'attributes' && isset($value['class']) && isset($default[$key]['class'])) {
                    $result[$key] = self::mergeClassAttributes($default[$key], $value);
                } else {
                    $result[$key] = self::mergeConfig($default[$key], $value);
                }
            } elseif ($key === 'tag' && is_string($value)) {
                $result[$key] = $value;
            } elseif ($key === 'attributes' && is_array($value)) {
                $result[$key] = self::mergeClassAttributes($default[$key] ?? [], $value);
            } else {
                $result[$key] = $value;
            }
        }
        return $result;
    }

    private static function mergeClassAttributes($default, $custom)
    {
        $result = array_merge($default, $custom);
        if (isset($custom['class'])) {
            $result['class'] = array_merge($default['class'], $custom['class']);
        }
        return $result;
    }}