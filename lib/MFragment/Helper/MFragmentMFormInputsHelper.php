<?php

namespace FriendsOfRedaxo\MFragment\Helper;

use FriendsOfRedaxo\MFragment\Utils\SVGConfigIconSet;

class MFragmentMFormInputsHelper
{
    /**
     * @param string $iconType [DoubleContainerTextIcon]
     * @param array $options [0 => 'None', 1 => 'Small', 2 => 'Medium', 3 => 'Large' ... ]
     */
    public static function getIconPaddingOptions(string $iconType, array $options = [], $iconLabelSuffix = '', $iconLabelPrefix = ''): array
    {
        $itemPaddingOptions = [];
        foreach ($options as $i => $label) {
            $getMethod = 'get' . $iconType;
            if (method_exists(SVGConfigIconSet::class, $getMethod)) {
                switch($iconType) {
                    case 'DoubleContainerTextIcon':
                        $itemPaddingOptions[$i] = ['svgIconSet' => SVGConfigIconSet::$getMethod($iconLabelPrefix . $label . $iconLabelSuffix, ['top' => 200, 'containerHeight' => (SVGConfigIconSet::config['container']['height'] + floatval($i * 350) - 500)], false, ['containerHeight' => (SVGConfigIconSet::config['container']['height'] - 250)], null, false, ['containerHeight' => (SVGConfigIconSet::config['container']['height'] - 250)], floatval($i * 180) + 1300), 'label' => $label];
                        break;
                    case 'DoubleContainerTextLayoutImgIcon':
                        $topTextPosition = floatval($i * 180) + 1300;
                        if ($i == 0) $topTextPosition = 2600;
                        $itemPaddingOptions[$i] = ['svgIconSet' => SVGConfigIconSet::$getMethod($iconLabelPrefix . $label . $iconLabelSuffix, 'left', ['top' => 200, 'containerHeight' => (SVGConfigIconSet::config['container']['height'] + floatval($i * 350) - 500)], null, null, ['containerHeight' => (SVGConfigIconSet::config['container']['height'] - 250)], null, null, $topTextPosition), 'label' => $label];
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
    public static function getIconMarginOptions(string $iconType, array $options = [], $iconLabelSuffix = '', $iconLabelPrefix = ''): array
    {
        $itemMarginOptions = [];
        foreach ($options as $i => $label) {
            $getMethod = 'get' . $iconType;
            if (method_exists(SVGConfigIconSet::class, $getMethod)) {
                switch($iconType) {
                    case 'DoubleContainerTextIcon':
                        $itemMarginOptions[$i] = ['svgIconSet' => SVGConfigIconSet::$getMethod($iconLabelPrefix . $label . $iconLabelSuffix, ['top' => 200], false, null, ['top' => intval($i + 1) * 270], false, null, floatval($i * 90) + 1380), 'label' => $label];
                        break;
                    case 'DoubleContainerTextLayoutImgIcon':
                    case 'DoubleContainerMasonryIcon':
                        $itemMarginOptions[$i] = ['svgIconSet' => SVGConfigIconSet::$getMethod($iconLabelPrefix . $label . $iconLabelSuffix, 'left', ['top' => 200], null, null, ['top' => intval($i+1) * 270], null, null, floatval($i * 90) + 1380), 'label' => $label];
                        break;
                }
            }
        }
        return $itemMarginOptions;
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
}