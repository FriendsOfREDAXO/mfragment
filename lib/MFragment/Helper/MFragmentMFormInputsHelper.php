<?php

namespace FriendsOfRedaxo\MFragment\Helper;

use FriendsOfRedaxo\MFragment\Utils\SVGConfigIconSet;

class MFragmentMFormInputsHelper
{
    /**
     * @param string $iconType [DoubleContainerTextIcon]
     * @param array $options [0 => 'None', 1 => 'Small', 2 => 'Medium', 3 => 'Large' ... ]
     * @param string $paddingType ['bottom'|'top'] - Typ des Paddings (default: 'bottom' für Abwärtskompatibilität)
     */
    public static function getIconPaddingOptions(string $iconType, array $options = [], $iconLabelSuffix = '', $iconLabelPrefix = '', string $paddingType = 'bottom'): array
    {
        $itemPaddingOptions = [];
        foreach ($options as $i => $label) {
            if (method_exists(SVGConfigIconSet::class, 'get' . $iconType)) {
                switch($iconType) {
                    case 'DoubleContainerTextIcon':
                        if ($paddingType === 'top') {
                            // Für padding-top: Container vergrößert sich nach oben, Text rutscht nach oben
                            $itemPaddingOptions[$i] = ['svgIconSet' => SVGConfigIconSet::getDoubleContainerTextIcon($iconLabelPrefix . $label . $iconLabelSuffix, ['top' => 200, 'containerHeight' => (SVGConfigIconSet::config['container']['height'] + floatval($i * 350) - 500)], false, ['containerHeight' => (SVGConfigIconSet::config['container']['height'] - 250)], null, false, ['containerHeight' => (SVGConfigIconSet::config['container']['height'] - 250)], 1300 - (floatval($i * 180))), 'label' => $label];
                        } else {
                            // Für padding-bottom: Container vergrößert sich nach unten, Text rutscht nach unten (aktuelle Logik)
                            $itemPaddingOptions[$i] = ['svgIconSet' => SVGConfigIconSet::getDoubleContainerTextIcon($iconLabelPrefix . $label . $iconLabelSuffix, ['top' => 200, 'containerHeight' => (SVGConfigIconSet::config['container']['height'] + floatval($i * 350) - 500)], false, ['containerHeight' => (SVGConfigIconSet::config['container']['height'] - 250)], null, false, ['containerHeight' => (SVGConfigIconSet::config['container']['height'] - 250)], floatval($i * 180) + 1300), 'label' => $label];
                        }
                        break;
                    case 'DoubleContainerTextLayoutImgIcon':
                        if ($paddingType === 'top') {
                            // Für padding-top: Container vergrößert sich nach oben, Text rutscht nach oben
                            $topTextPosition = 1300 - (floatval($i * 180));
                            if ($i == 0) $topTextPosition = 2600;
                            $itemPaddingOptions[$i] = ['svgIconSet' => SVGConfigIconSet::getDoubleContainerTextLayoutImgIcon($iconLabelPrefix . $label . $iconLabelSuffix, 'left', ['top' => 200, 'containerHeight' => (SVGConfigIconSet::config['container']['height'] + floatval($i * 350) - 500)], null, null, ['containerHeight' => (SVGConfigIconSet::config['container']['height'] - 250)], null, null, $topTextPosition), 'label' => $label];
                        } else {
                            // Für padding-bottom: Container vergrößert sich nach unten, Text rutscht nach unten (aktuelle Logik)
                            $topTextPosition = floatval($i * 180) + 1300;
                            if ($i == 0) $topTextPosition = 2600;
                            $itemPaddingOptions[$i] = ['svgIconSet' => SVGConfigIconSet::getDoubleContainerTextLayoutImgIcon($iconLabelPrefix . $label . $iconLabelSuffix, 'left', ['top' => 200, 'containerHeight' => (SVGConfigIconSet::config['container']['height'] + floatval($i * 350) - 500)], null, null, ['containerHeight' => (SVGConfigIconSet::config['container']['height'] - 250)], null, null, $topTextPosition), 'label' => $label];
                        }
                        break;
                    case 'DoubleContainerLayoutImgIcon':
                        if ($paddingType === 'top') {
                            $val = $i+1;
                            $topTextPosition = floatval($i * 120) + 200;
                            if ($i == 0) $topTextPosition = 1250;
                            $itemPaddingOptions[$i] = ['svgIconSet' => SVGConfigIconSet::getDoubleContainerLayoutImgIcon($iconLabelPrefix . $label . $iconLabelSuffix, 'left', ['vertical' => 'bottom', 'top' => 230, 'containerHeight' => (SVGConfigIconSet::config['container']['height'] + floatval($val * 270) - 500)], null, ['top' => 60], ['containerHeight' => (SVGConfigIconSet::config['container']['height'] - 250)], null, null, $topTextPosition), 'label' => $label];
                        } else {
                            $val = $i+1;
                            $topTextPosition = floatval($val * 120) + 1100;
                            if ($i == 0) $topTextPosition = 1250;
                            $itemPaddingOptions[$i] = ['svgIconSet' => SVGConfigIconSet::getDoubleContainerLayoutImgIcon($iconLabelPrefix . $label . $iconLabelSuffix, 'left', ['vertical' => 'top', 'top' => 230, 'containerHeight' => (SVGConfigIconSet::config['container']['height'] + floatval($val * 270) - 500)], null, ['top' => 60], ['containerHeight' => (SVGConfigIconSet::config['container']['height'] - 250)], null, null, $topTextPosition), 'label' => $label];
                        }
                        break;
                }
            }
        }
        return $itemPaddingOptions;
    }

    /**
     * @param string $iconType [DoubleContainerTextIcon|DoubleContainerTextLayoutImgIcon]
     * @param array $options [0 => 'None', 1 => 'Small', 2 => 'Medium', 3 => 'Large' ... ]
     */
    public static function getIconPaddingTopOptions(string $iconType, array $options = [], $iconLabelSuffix = '', $iconLabelPrefix = ''): array
    {
        return self::getIconPaddingOptions($iconType, $options, $iconLabelSuffix, $iconLabelPrefix, 'top');
    }

    /**
     * @param string $iconType [DoubleContainerTextIcon|DoubleContainerTextLayoutImgIcon]
     * @param array $options [0 => 'None', 1 => 'Small', 2 => 'Medium', 3 => 'Large' ... ]
     */
    public static function getIconPaddingBottomOptions(string $iconType, array $options = [], $iconLabelSuffix = '', $iconLabelPrefix = ''): array
    {
        return self::getIconPaddingOptions($iconType, $options, $iconLabelSuffix, $iconLabelPrefix, 'bottom');
    }

    /**
     * @param string|int $iconType [1|2|3|4|DoubleContainerTextIcon|DoubleContainerTextLayoutImgIcon|DoubleContainerMasonryIcon|DoubleContainerLayoutImgIcon]
     * @param array $options [0 => 'None', 1 => 'Small', 2 => 'Medium', 3 => 'Large' ... ]
     * @param string $marginType ['bottom'|'top'] - Typ des Margins (default: 'bottom' für Abwärtskompatibilität)
     */
    public static function getIconMarginOptions(string $iconType = 'DoubleContainerLayoutImgIcon', array $options = [], $iconLabelSuffix = '', $iconLabelPrefix = '', string $marginType = 'bottom'): array
    {
        $itemMarginOptions = [];
        foreach ($options as $i => $label) {
            $getMethod = 'get' . $iconType;
            if (method_exists(SVGConfigIconSet::class, $getMethod)) {
                switch($iconType) {
                    case 'DoubleContainerTextIcon':
                        if ($marginType === 'top') {
                            // Für margin-top: Erster Container wird nach oben verschoben (negativer Wert), Text auch nach oben
                            $itemMarginOptions[$i] = ['svgIconSet' => SVGConfigIconSet::getDoubleContainerTextIcon($iconLabelPrefix . $label . $iconLabelSuffix, ['top' => 200 - (intval($i + 1) * 270)], false, null, ['top' => 200], false, null, 1380 - (floatval($i * 90))), 'label' => $label];
                        } else {
                            // Für margin-bottom: Zweiter Container wird nach unten verschoben (aktuelle Logik)
                            $itemMarginOptions[$i] = ['svgIconSet' => SVGConfigIconSet::getDoubleContainerTextIcon($iconLabelPrefix . $label . $iconLabelSuffix, ['top' => 200], false, null, ['top' => intval($i + 1) * 270], false, null, floatval($i * 90) + 1380), 'label' => $label];
                        }
                        break;
                    case 'DoubleContainerTextLayoutImgIcon':
                        if ($marginType === 'top') {
                            // Für margin-top: Erster Container wird nach oben verschoben (negativer Wert), Text auch nach oben
                            $itemMarginOptions[$i] = ['svgIconSet' => SVGConfigIconSet::getDoubleContainerTextLayoutImgIcon($iconLabelPrefix . $label . $iconLabelSuffix, 'left', ['top' => 200 - (intval($i+1) * 270)], null, null, ['top' => 200], null, null, 1380 - (floatval($i * 90))), 'label' => $label];
                        } else {
                            // Für margin-bottom: Zweiter Container wird nach unten verschoben (aktuelle Logik)
                            $itemMarginOptions[$i] = ['svgIconSet' => SVGConfigIconSet::getDoubleContainerTextLayoutImgIcon($iconLabelPrefix . $label . $iconLabelSuffix, 'left', ['top' => 200], null, null, ['top' => intval($i+1) * 270], null, null, floatval($i * 90) + 1380), 'label' => $label];
                        }
                        break;
                    case 'DoubleContainerMasonryIcon':
                        if ($marginType === 'top') {
                            // Für margin-top: Erster Container wird nach oben verschoben (negativer Wert), Text auch nach oben
                            $itemMarginOptions[$i] = ['svgIconSet' => SVGConfigIconSet::getDoubleContainerMasonryIcon($iconLabelPrefix . $label . $iconLabelSuffix, 'left', ['top' => 200 - (intval($i+1) * 270)], null, null, ['top' => 200], null, null, 1380 - (floatval($i * 90))), 'label' => $label];
                        } else {
                            // Für margin-bottom: Zweiter Container wird nach unten verschoben (aktuelle Logik)
                            $itemMarginOptions[$i] = ['svgIconSet' => SVGConfigIconSet::getDoubleContainerMasonryIcon($iconLabelPrefix . $label . $iconLabelSuffix, 'left', ['top' => 200], null, null, ['top' => intval($i+1) * 270], null, null, floatval($i * 90) + 1380), 'label' => $label];
                        }
                        break;
                    case 'DoubleContainerLayoutImgIcon':
                        if ($marginType === 'top') {
                            // Für margin-top: Erster Container wird nach oben verschoben (negativer Wert), Text auch nach oben
                            $itemMarginOptions[$i] = ['svgIconSet' => SVGConfigIconSet::getDoubleContainerLayoutImgIcon($iconLabelPrefix . $label . $iconLabelSuffix, 'left', ['top' => 200 - (intval($i) * 270)], null, null, ['top' => 200], null, null, 1380 - (floatval($i * 90))), 'label' => $label];
                        } else {
                            // Für margin-bottom: Zweiter Container wird nach unten verschoben (aktuelle Logik)
                            $itemMarginOptions[$i] = ['svgIconSet' => SVGConfigIconSet::getDoubleContainerLayoutImgIcon($iconLabelPrefix . $label . $iconLabelSuffix, 'left', ['top' => 200], null, null, ['top' => intval($i+1) * 270], null, null, floatval($i * 90) + 1380), 'label' => $label];
                        }
                        break;
                    case 'ContainerTextFluidIcon':
                        if ($marginType === 'top') {
                            // Für margin-top: Erster Container wird nach oben verschoben (negativer Wert), Text auch nach oben
                            $itemMarginOptions[$i] = ['svgIconSet' => SVGConfigIconSet::getContainerTextFluidIcon($iconLabelPrefix . $label . $iconLabelSuffix, 'left', ['top' => 200 - (intval($i+1) * 270)], null, null, ['top' => 200], null, null, 1380 - (floatval($i * 90))), 'label' => $label];
                        } else {
                            // Für margin-bottom: Zweiter Container wird nach unten verschoben (aktuelle Logik)
                            $itemMarginOptions[$i] = ['svgIconSet' => SVGConfigIconSet::getContainerTextFluidIcon($iconLabelPrefix . $label . $iconLabelSuffix, 'left', ['top' => 200], null, null, ['top' => intval($i+1) * 270], null, null, floatval($i * 90) + 1380), 'label' => $label];
                        }
                        break;
                }
            }
        }
        return $itemMarginOptions;
    }

    /**
     * @param string|int $iconType [1|2|3|4|DoubleContainerTextIcon|DoubleContainerTextLayoutImgIcon|DoubleContainerMasonryIcon|DoubleContainerLayoutImgIcon]
     * @param array $options [0 => 'None', 1 => 'Small', 2 => 'Medium', 3 => 'Large' ... ]
     */
    public static function getIconMarginTopOptions(string $iconType = 'DoubleContainerLayoutImgIcon', array $options = [], $iconLabelSuffix = '', $iconLabelPrefix = ''): array
    {
        return self::getIconMarginOptions($iconType, $options, $iconLabelSuffix, $iconLabelPrefix, 'top');
    }

    /**
     * @param string|int $iconType [1|2|3|4|DoubleContainerTextIcon|DoubleContainerTextLayoutImgIcon|DoubleContainerMasonryIcon|DoubleContainerLayoutImgIcon]
     * @param array $options [0 => 'None', 1 => 'Small', 2 => 'Medium', 3 => 'Large' ... ]
     */
    public static function getIconMarginBottomOptions(string $iconType = 'DoubleContainerLayoutImgIcon', array $options = [], $iconLabelSuffix = '', $iconLabelPrefix = ''): array
    {
        return self::getIconMarginOptions($iconType, $options, $iconLabelSuffix, $iconLabelPrefix, 'bottom');
    }

    /**
     * @param string $containerType [ContainerTextFluidIcon|ContainerTextLayoutImgIcon]
     * @param array $options ['smallBox' => 'Small', 'box' => 'Box', 'fluid' => 'Fluid', 'fluidBox' => 'Fluid Box']
     */
    public static function getContainerTypeOptions(string $containerType, array $options = [], $iconLabelSuffix = '', $iconLabelPrefix = ''): array
    {
        $containerOptions = [];
        foreach ($options as $i => $label) {
            $getMethod = 'get' . $containerType;
            if (method_exists(SVGConfigIconSet::class, $getMethod)) {
                switch ($containerType) {
                    case 'ContainerTextFluidIcon':
                    case 'ContainerTextLayoutImgIcon':
                    case 'DoubleContainerMasonryIcon':
                        $containerOptions[$i] =  ['svgIconSet' => SVGConfigIconSet::$getMethod($iconLabelPrefix . $label . $iconLabelSuffix, 'container' . ucfirst($i), null, false), 'label' => $label];
                        break;
                }
            }
        }
        return $containerOptions;
    }

    /**
     * @param array $options ['1' => '1 Column', '2' => '2 Columns', '3' => '3 Columns', ... ]
     * @param string $position ['left'|'center'|'right'] - Position der Spalte
     * @param bool $showLines - Ob Rasterlinien angezeigt werden sollen
     */
    public static function getImgColumnWidthOptions(array $options = [], string $position = 'left', bool $showLines = false, $iconLabelSuffix = '', $iconLabelPrefix = ''): array
    {
        $columnOptions = [];
        foreach ($options as $col => $label) {
            $columnOptions[$col] = [
                'svgIconSet' => SVGConfigIconSet::getImgColumnWidthIcon($iconLabelPrefix . $label . $iconLabelSuffix, intval($col), $position, $showLines), 
                'label' => $label
            ];
        }
        return $columnOptions;
    }
}