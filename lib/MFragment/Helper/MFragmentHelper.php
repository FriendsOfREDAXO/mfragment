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

        // Überprüfen, ob class Attribute vorhanden sind
        if (isset($custom['class'])) {
            // Wenn default['class'] nicht existiert, erstelle ein leeres Array
            if (!isset($default['class'])) {
                $default['class'] = [];
            }

            // Wenn custom['class'] ein String ist, konvertiere ihn zu einem Array
            if (is_string($custom['class'])) {
                $customClass = explode(' ', $custom['class']);
                $result['class'] = is_array($default['class']) ?
                    array_merge($default['class'], $customClass) :
                    $customClass;
            }
            // Wenn custom['class'] ein Array ist, merge es mit default['class']
            elseif (is_array($custom['class'])) {
                // Flache Array erstellen, um default-Werte zu erhalten
                $flatDefault = [];
                foreach ($default['class'] as $key => $value) {
                    if ($key === 'default' || is_numeric($key)) {
                        $flatDefault[] = $value;
                    }
                }

                // Flache Array für custom erstellen
                $flatCustom = [];
                foreach ($custom['class'] as $key => $value) {
                    if ($key === 'default' || is_numeric($key)) {
                        $flatCustom[] = $value;
                    }
                }

                // Zusammenführen ohne Duplikate
                $result['class'] = array_unique(array_merge($flatDefault, $flatCustom));
            }
            // Sonst behalte den default Wert
            else {
                $result['class'] = $default['class'];
            }
        }

        return $result;
    }
}