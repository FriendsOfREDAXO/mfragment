<?php
# path: src/addons/mfragment/lib/MFragment/Utils/SVGConfigIconSet.php
namespace FriendsOfRedaxo\MFragment\Utils;

class SVGConfigIconSet
{
    public const config = [
        'wrapper' => [
            'width' => 2780,
            'height' => 2780,
            'style' => 'background-color: #ccc; opacity: 0.7;',
        ],
        'container' => [
            'width' => 2780,
            'height' => 1466.804,
            'left' => 0,
            'top' => 656.598,
            'style' => 'background-color: #fff; opacity: 0.67; border: 67.08px solid rgba(0,0,0,0.1)',
        ],
        'text' => [
            'fontFamily' => 'Helvetica, Arial, sans-serif',
            'fontSize' => 100,
            'style' => 'text-align: center; color: #000; font-weight: normal;',
        ],
        'content' => [
            'lineHeight' => 55.637,
            'lineDistance' => 124,
            'defaultPaddingX' => 444.284,
            'flexPaddingX' => 40,
            'top' => 656.598,
            'opacity' => 0.8,
            'style' => 'background-color: #000;',
            'startY' => 928.1815,
            'endY' => 1851.8185,
        ],
        'grid' => [
            'columns' => 12,
            'gutter' => 80
        ],
        'lines' => [
            'color' => '#000',
            'width' => 27,
            'opacity' => 0.12,
            'x1' => 384.815,
            'x2' => 2393.52,
            'y1' => 314.252,
            'y2' => 2461.252,
        ],
        'arrows' => [
            'horizontal' => [
                'tipWidth' => 93.158,
                'defaultY' => 2291.14,
                'style' => [
                    'fill' => '#505050',
                    'opacity' => 0.67,
                    'stroke' => '#000',
                    'strokeOpacity' => 0.18,
                    'strokeWidth' => 1.67,
                ]
            ],
            'fit' => [
                'length' => 120,
                'width' => 40,
                'opacity' => 1,
                'color' => '#000',
            ],
            'stretch' => [
                'length' => 100,
                'width' => 40,
                'opacity' => 1,
                'color' => '#756f6d',
                'margin' => 100,
                'inset' => 200,
            ],
            'diagonal' => [
                'length' => 20,
                'width' => 2,
                'color' => '#000',
                'angle' => 45,
            ]
        ]
    ];

    public static function getTextLayoutImgFillIcon($description = '', $type = 'imgContentIcon', $imgPosition = 'left', $fitType = 'fit'): string
    {
        return self::getContainerTextLayoutImgIcon($description, $type, $imgPosition, $fitType);
    }

    public static function getContainerTextLayoutImgFluidIcon($description = '', $type = '', $imgPosition = ''): string
    {
        return self::getContainerTextLayoutImgIcon($description, $type, $imgPosition, null);
    }

    public static function getDoubleContainerTextIcon($description = '',
                                                      $contentLinesConfig1 = [], $contentLinesConfig2 = [],
                                                      $containerConfig1 = [],
                                                      $contentLinesConfig3 = [], $contentLinesConfig4 = [],
                                                      $containerConfig2 = [],
                                                      $descriptionTextTop = 2451.55): string {

        $defaultHeight = self::config['container']['height'] - 300;
        $top = 10;

        $contentLinesConfig1 = array_merge([
            'lines' => 4,
            'vertical' => 'center',
            'position' => ($contentLinesConfig2 !== false) ? 0 : 1,
            'col' => ($contentLinesConfig2 !== false) ? 6 : 10,
            'top' => $top,
            'fitType' => 'fit',
            'containerHeight' => $defaultHeight,
        ], $contentLinesConfig1 ?? []);
        $top = $contentLinesConfig1['top'];
        $height = $contentLinesConfig1['containerHeight'];

        if ($contentLinesConfig2 !== false) {
            $contentLinesConfig2 = array_merge($contentLinesConfig1, ['position' => 6], $contentLinesConfig2 ?? []);
        }

        $containerConfig1 = array_merge([
            'width' => self::config['container']['width'],
            'height' => $height,
            'left' => 0,
            'top' => $top,
            'style' => self::config['container']['style'],
        ], $containerConfig1 ?? []);

        $contentLinesConfig3 = array_merge([
            'lines' => 4,
            'vertical' => 'center',
            'position' => ($contentLinesConfig4 !== false) ? 0 : 1,
            'col' => ($contentLinesConfig4 !== false) ? 6 : 10,
            'top' => $top,
            'fitType' => 'fit',
            'containerHeight' => $defaultHeight,
        ], $contentLinesConfig3 ?? []);
        $top = $contentLinesConfig3['top'];
        $boxHeight = $contentLinesConfig3['containerHeight'];
        $contentLinesConfig3['top'] = $contentLinesConfig3['top'] + $height;

        if ($contentLinesConfig4 !== false) {
            $contentLinesConfig4 = array_merge($contentLinesConfig3, ['top' => $top, 'position' => 6], $contentLinesConfig4 ?? []);
            $contentLinesConfig4['top'] = $contentLinesConfig4['top'] + $height;
        }

        $containerConfig2 = array_merge([
            'width' => self::config['container']['width'],
            'height' => $boxHeight,
            'left' => 0,
            'top' => $top,
            'style' => self::config['container']['style'],
        ], $containerConfig2 ?? []);
        $containerConfig2['top'] = $containerConfig2['top'] + $height;

        // Erste Container-Sektion
        $container1Content =
            self::createContainer($containerConfig1['left'], $containerConfig1['top'], $containerConfig1['height']) .
            self::createContentLines(
                $contentLinesConfig1['lines'],
                $contentLinesConfig1['vertical'],
                $contentLinesConfig1['position'],
                $contentLinesConfig1['col'],
                80,
                false,
                $contentLinesConfig1['top'],
                $contentLinesConfig1['containerHeight']
            ) . ((is_array($contentLinesConfig2)) ?
            self::createContentLines(
                $contentLinesConfig2['lines'],
                $contentLinesConfig2['vertical'],
                $contentLinesConfig2['position'],
                $contentLinesConfig2['col'],
                80,
                false,
                $contentLinesConfig2['top'],
                $contentLinesConfig2['containerHeight']
            ) : '');

        // Zweite Container-Sektion
        $container2Content =
            self::createContainer($containerConfig2['left'], $containerConfig2['top'], $containerConfig2['height']) .
            self::createContentLines(
                $contentLinesConfig3['lines'],
                $contentLinesConfig3['vertical'],
                $contentLinesConfig3['position'],
                $contentLinesConfig3['col'],
                80,
                false,
                $contentLinesConfig3['top'],
                $contentLinesConfig3['containerHeight']
            ) . ((is_array($contentLinesConfig4)) ?
            self::createContentLines(
                $contentLinesConfig4['lines'],
                $contentLinesConfig4['vertical'],
                $contentLinesConfig4['position'],
                $contentLinesConfig4['col'],
                80,
                false,
                $contentLinesConfig4['top'],
                $contentLinesConfig4['containerHeight']
            ) : '');

        return self::createBaseWrapper(
            $container1Content .
            $container2Content .
            ($description ? self::createDescriptionText($description, self::config['wrapper']['width'] / 2, $descriptionTextTop) : '')
        );
    }

    public static function getDoubleContainerMasonryIcon($description = '',
                                                         $containerConfig1 = [],
                                                         $containerConfig2 = [],
                                                         $descriptionTextTop = 2451.55): string
    {
        $height = self::config['container']['height'] - 300;
        $top = 10;

        $containerConfig1 = array_merge([
            'width' => self::config['container']['width'],
            'height' => $height,
            'left' => 0,
            'top' => $top,
            'style' => self::config['container']['style'],
        ], (is_array($containerConfig1) ? $containerConfig1 : []));

        $containerConfig2 = array_merge([
            'width' => self::config['container']['width'],
            'height' => $height,
            'left' => 0,
            'top' => $top,
            'style' => self::config['container']['style'],
        ], (is_array($containerConfig2) ? $containerConfig2 : []));

        $containerConfig2['top'] = $containerConfig2['top'] + $height;

        // Erste Container-Sektion
        $container1Content =
            self::createContainer($containerConfig1['left'], $containerConfig1['top'], $containerConfig1['height']) .
            self::createMasonryBoxes($containerConfig1['top'] + 67.08, $containerConfig1['height'] - 134.16);

        // Zweite Container-Sektion
        $container2Content =
            self::createContainer($containerConfig2['left'], $containerConfig2['top'], $containerConfig2['height']) .
            self::createMasonryBoxes($containerConfig2['top'] + 67.08, $containerConfig2['height'] - 134.16);

        return self::createBaseWrapper(
            $container1Content .
            $container2Content .
            ($description ? self::createDescriptionText($description, self::config['wrapper']['width'] / 2, $descriptionTextTop ?? 2451.55) : '')
        );
    }

    public static function getContainerTextFluidIcon($description = '', $type = 'containerFluid', $contentLinesConfig1 = [], $contentLinesConfig2 = []): string
    {
        $arrowPosition = 0;
        $arrowCol = 12;
        $contentLines1IsFlex = false;
        $contentLines2IsFlex = false;
        $isArrowFlex = false;
        $svgBottom = '';

        $defaultHeight = self::config['container']['height'];
        $top = self::config['container']['top'];

        $contentLinesConfig1 = array_merge([
            'lines' => 4,
            'vertical' => 'center',
            'position' => ($contentLinesConfig2 !== false) ? 0 : 0,
            'col' => ($contentLinesConfig2 !== false) ? 6 : 12,
            'top' => $top,
            'fitType' => 'fit',
            'containerHeight' => $defaultHeight,
        ], $contentLinesConfig1 ?? []);
        $top = $contentLinesConfig1['top'];
        $height = $contentLinesConfig1['containerHeight'];

        if ($contentLinesConfig2 !== false) {
            $contentLinesConfig2 = array_merge($contentLinesConfig1, ['position' => 6], $contentLinesConfig2 ?? []);
        }

        $containerConfig1 = [
            'height' => $height,
            'left' => 0,
            'top' => $top,
        ];

        if ($type == 'containerFluid') {
            $contentLines1IsFlex = true;
            $contentLines2IsFlex = true;
            $isArrowFlex = true;
        } else if ($type == 'containerSmallBox') {
            $arrowCol = 8;
            $arrowPosition = 2;
            $contentLinesConfig1['col'] = 8;
            $contentLinesConfig1['position'] = 2;
        }

        // Container erstellen
        $container = self::createContainer($containerConfig1['left'], $containerConfig1['top'], $containerConfig1['height']);

        // Erste Linienspalte
        $container .= self::createContentLines(
            $contentLinesConfig1['lines'],
            $contentLinesConfig1['vertical'],
            $contentLinesConfig1['position'],
            $contentLinesConfig1['col'], 80, $contentLines1IsFlex,
            $contentLinesConfig1['top'],
            $contentLinesConfig1['containerHeight']
        );

        if ($contentLinesConfig2 !== false) {
            // Zweite Linienspalte
            $container .= self::createContentLines(
                $contentLinesConfig2['lines'],
                $contentLinesConfig2['vertical'],
                $contentLinesConfig2['position'],
                $contentLinesConfig2['col'], 80, $contentLines2IsFlex,
                $contentLinesConfig2['top'],
                $contentLinesConfig2['containerHeight']
            );
        }

        // Vertikale Linien und Pfeile hinzufügen
        if ($type == 'containerFluid' || $type == 'containerFluidBox' || $type == 'containerBox' || $type == 'containerSmallBox') {
            $svgBottom = self::createLines() . self::createHorizontalArrow($arrowPosition, $arrowCol, $isArrowFlex);
        }

        // Description Text und Bottom SVG hinzufügen
        $container .= ($description ? self::createDescriptionText($description, self::config['wrapper']['width'] / 2, 2451.55) : '') . $svgBottom;

        return self::createBaseWrapper($container);
    }

    public static function getTextLayoutImgPositionIcon($description = '', $imgPosition = 'left', $fitType = 'stretch'): string
    {
        return self::getContainerTextLayoutImgIcon($description, null, $imgPosition, null, true, ['lines' => 12, 'fitType' => $fitType], ['lines' => 4]);
    }

    public static function getTextColumnWidthIcon($description = '', $col = 6, $position = 'left', $showLines = false): string
    {
        // Position der Spalte bestimmen
        $columnPosition = match($position) {
            'left' => 0,
            'right' => 12 - $col,
            'center' => (12 - $col) / 2, // Zentriert die Spalte
            default => 0
        };

        // Container Konfiguration
        $containerConfig = [
            'width' => self::config['container']['width'],
            'height' => self::config['container']['height'],
            'left' => 0,
            'top' => self::config['container']['top'],
            'style' => self::config['container']['style'],
        ];

        // Text-Spalte Konfiguration
        $columnConfig = [
            'lines' => 4,
            'vertical' => 'center',
            'position' => $columnPosition,
            'col' => $col,
            'top' => self::config['container']['top'],
            'containerHeight' => $containerConfig['height'],
        ];

        // Container erstellen
        $container =
            self::createContainer($containerConfig['left'], $containerConfig['top'], $containerConfig['height']) .
            (is_string($description) ? self::createDescriptionText($description, self::config['container']['width'] / 2, 2451.55, self::config['text']['fontSize']) : '') .
            self::createContentLines(
                $columnConfig['lines'],
                $columnConfig['vertical'],
                $columnConfig['position'],
                $columnConfig['col'],
                self::config['grid']['gutter'],
                false, //($columnConfig['fitType'] == 'stretch'),
                $columnConfig['top'],
                $columnConfig['containerHeight']
            );

        return self::createBaseWrapper($container . (($showLines === true) ? self::createLines() : ''));
    }

    public static function getTextLayoutImgColumnWidthIcon($description = '', $col = 6, $imgPosition = 'left', $fitType = 'fit'): string
    {
        $imgCol = $col;
        $imgPosition = 0;
        $textCol = 12 - $col;
        $textPosition = $imgCol;
        if ($imgPosition == 'right') {
            $imgPosition = $textPosition;
            $textPosition = 0;
        }
        return self::getContainerTextLayoutImgIcon($description, null, $imgPosition, null, true, ['col' => $imgCol, 'position' => $imgPosition, 'fitType' => $fitType], ['col' => $textCol, 'position' => $textPosition, 'fitType' => $fitType]);
    }

    public static function getTextLayoutImgCenteringIcon($description = '', $imgVertical = 'top', $contentVertical = 'top', $imgPosition = 'left', $fitType = 'fit'): string
    {
        return self::getContainerTextLayoutImgIcon($description, null, $imgPosition, null, true, ['vertical' => $imgVertical, 'fitType' => 'stretch', 'lines' => 10], ['vertical' => $contentVertical, 'fitType' => 'stretch', 'paddingY' => 150]);
    }

    public static function getDoubleContainerTextLayoutImgIcon($description = '', $imgPositionStart = 'left', $boxConfig1 = [], $contentLinesConfig1 = [], $containerConfig1 = [], $boxConfig2 = [], $contentLinesConfig2 = [], $containerConfig2 = [], $descriptionTextTop = 2451.55): string
    {
        $imgPosition = ($imgPositionStart == 'left') ? 'right' : 'left';
        $height = self::config['container']['height'] - 300;
        $top = 10;

        $boxConfig1 = array_merge([
            'lines' => 8,
            'vertical' => 'center',
            'position' => 0,
            'col' => 6,
            'top' => $top,
            'fitType' => 'fit',
            'containerHeight' => $height,
        ], $boxConfig1 ?? []);
        $top = $boxConfig1['top'];
        $height = $boxConfig1['containerHeight'];

        $contentLinesConfig1 = array_merge([
            'lines' => 4,
            'vertical' => 'center',
            'position' => 6,
            'col' => 6,
            'top' => $top,
            'fitType' => 'fit',
            'containerHeight' => $height,
        ], $contentLinesConfig1 ?? []);

        $containerConfig1 = array_merge([
            'width' => self::config['container']['width'],
            'height' => $height,
            'left' => 0,
            'top' => $top,
            'style' => self::config['container']['style'],
        ], $containerConfig1 ?? []);

        $boxConfig2 = array_merge([
            'lines' => 8,
            'vertical' => 'center',
            'position' => 0,
            'col' => 6,
            'top' => $top,
            'fitType' => 'fit',
            'containerHeight' => $height,
        ], $boxConfig2 ?? []);
        $top = $boxConfig2['top'];
        $boxHeight = $boxConfig2['containerHeight'];
        $boxConfig2['top'] = $boxConfig2['top'] + $height;

        $contentLinesConfig2 = array_merge([
            'lines' => 4,
            'vertical' => 'center',
            'position' => 6,
            'col' => 6,
            'top' => $top,
            'fitType' => 'fit',
            'containerHeight' => $boxHeight,
        ], $contentLinesConfig2 ?? []);
        $contentLinesConfig2['top'] = $contentLinesConfig2['top'] + $height;

        $containerConfig2 = array_merge([
            'width' => self::config['container']['width'],
            'height' => $boxHeight,
            'left' => 0,
            'top' => $top,
            'style' => self::config['container']['style'],
        ], $containerConfig2 ?? []);
        $containerConfig2['top'] = $containerConfig2['top'] + $height;

        $container1 = self::getContainerTextLayoutImgIcon(null, null, $imgPositionStart, null, false, $boxConfig1, $contentLinesConfig1, $containerConfig1);
        $container2 = self::getContainerTextLayoutImgIcon($description, null, $imgPosition, null, false, $boxConfig2, $contentLinesConfig2, $containerConfig2, $descriptionTextTop);

        // SVG erstellen mit beiden Containern übereinander
        return self::createBaseWrapper($container1 . $container2);
    }

    public static function getDoubleContainerLayoutImgIcon($description = '', $imgPositionStart = 'left', $boxConfig1 = [], $contentLinesConfig1 = [], $containerConfig1 = [], $boxConfig2 = [], $contentLinesConfig2 = [], $containerConfig2 = [], $descriptionTextTop = 2451.55): string
    {
        $imgPosition = ($imgPositionStart == 'left') ? 'right' : 'left';
        $height = self::config['container']['height'] - 300;
        $top = 10;

        $boxConfig1 = array_merge([
            'lines' => 8,
            'vertical' => 'center',
            'position' => 0,
            'col' => 12,
            'top' => $top,
            'fitType' => 'fit',
            'containerHeight' => $height,
        ], $boxConfig1 ?? []);
        $top = $boxConfig1['top'];
        $height = $boxConfig1['containerHeight'];

        $contentLinesConfig1 = array_merge([
            'lines' => 4,
            'vertical' => 'center',
            'position' => 6,
            'col' => 6,
            'top' => $top,
            'fitType' => 'fit',
            'containerHeight' => $height,
        ], $contentLinesConfig1 ?? []);

        $containerConfig1 = array_merge([
            'width' => self::config['container']['width'],
            'height' => $height,
            'left' => 0,
            'top' => $top,
            'style' => self::config['container']['style'],
        ], $containerConfig1 ?? []);

        $boxConfig2 = array_merge([
            'lines' => 8,
            'vertical' => 'center',
            'position' => 0,
            'col' => 12,
            'top' => $top,
            'fitType' => 'fit',
            'containerHeight' => $height,
        ], $boxConfig2 ?? []);
        $top = $boxConfig2['top'];
        $boxHeight = $boxConfig2['containerHeight'];
        $boxConfig2['top'] = $boxConfig2['top'] + $height;

        $contentLinesConfig2 = array_merge([
            'lines' => 4,
            'vertical' => 'center',
            'position' => 6,
            'col' => 6,
            'top' => $top,
            'fitType' => 'fit',
            'containerHeight' => $boxHeight,
        ], $contentLinesConfig2 ?? []);
        $contentLinesConfig2['top'] = $contentLinesConfig2['top'] + $height;

        $containerConfig2 = array_merge([
            'width' => self::config['container']['width'],
            'height' => $boxHeight,
            'left' => 0,
            'top' => $top,
            'style' => self::config['container']['style'],
        ], $containerConfig2 ?? []);
        $containerConfig2['top'] = $containerConfig2['top'] + $height;

        // Container ohne Textstreifen erstellen (nur Boxen/Bilder)
        $container1 = 
            self::createContainer($containerConfig1['left'], $containerConfig1['top'], $containerConfig1['height'])
            . self::createBox($boxConfig1['lines'], $boxConfig1['vertical'], $boxConfig1['position'], $boxConfig1['col'], 0, false, $boxConfig1['top'], $boxConfig1['containerHeight']);

        $container2 = 
            self::createContainer($containerConfig2['left'], $containerConfig2['top'], $containerConfig2['height'])
            . (is_string($description) ? self::createDescriptionText($description, self::config['container']['width'] / 2, $descriptionTextTop, self::config['text']['fontSize']) : '')
            . self::createBox($boxConfig2['lines'], $boxConfig2['vertical'], $boxConfig2['position'], $boxConfig2['col'], 0, false, $boxConfig2['top'], $boxConfig2['containerHeight']);

        // SVG erstellen mit beiden Containern übereinander
        return self::createBaseWrapper($container1 . $container2);
    }

    public static function getContainerTextLayoutImgIcon($description = '', $type = '', $imgPosition = 'left', $fitType = '', $getWrapper = true, $boxConfig = [], $contentLinesConfig = [], $containerConfig = [], $descriptionTextTop = 2451.55): string
    {
        $gutter = self::config['grid']['gutter'];
        $arrowPosition = 0;
        $arrowCol = 12;
        $isArrowFlex = false;
        $svgBottom = '';

        // Container Konfiguration
        $containerConfig = array_merge([
            'width' => self::config['container']['width'],
            'height' => self::config['container']['height'],
            'left' => 0,
            'top' => self::config['container']['top'],
            'style' => self::config['container']['style'],
        ], $containerConfig ?? []);

        // Box Konfiguration
        $boxConfig = array_merge([
            'lines' => 8,
            'vertical' => 'center',
            'position' => 0,
            'col' => 6,
            'top' => self::config['container']['top'],
            'fitType' => 'fit',
            'containerHeight' => $containerConfig['height'],
        ], $boxConfig ?? []);
        $isImgFlex = ($boxConfig['fitType'] == 'stretch');

        // Content Konfiguration
        $contentLinesConfig = array_merge([
            'lines' => 4,
            'vertical' => 'center',
            'position' => 6,
            'col' => 6,
            'top' => self::config['container']['top'],
            'fitType' => 'fit',
            'paddingY' => 10,
            'containerHeight' => $containerConfig['height'],
        ], $contentLinesConfig ?? []);
        $isContentFlex = ($contentLinesConfig['fitType'] == 'stretch');

        // Position Anpassungen
        if ($imgPosition == 'right') {
            $boxConfig['position'] = 6;
            $contentLinesConfig['position'] = 0;
        }

        // Container Typ Anpassungen
        if ($type == 'containerFluidBox') {
            $isImgFlex = true;
            $arrowCol = ($imgPosition != 'left') ? 10.5 : 14;
            $arrowPosition = ($imgPosition != 'left') ? -0.05 : 0;
            $isArrowFlex = ($imgPosition != 'left');
        } else if ($type == 'containerFluid') {
            $isContentFlex = true;
            $isImgFlex = true;
            $isArrowFlex = true;
        }else if ($type == 'containerSmallBox') {
            $arrowCol = 8;
            $arrowPosition = 2;
            $boxConfig['position'] = 2;
            $boxConfig['col'] = 4;
            $contentLinesConfig['position'] = 6;
            $contentLinesConfig['col'] = 4;
        }

        // Vertikale Linien und Pfeile
        if (($type == 'containerSmallBox' || $type == 'containerFluidBox' || $type == 'containerFluid' || $type == 'containerBox') && empty($fitType)) {
            $svgBottom = self::createLines() . self::createHorizontalArrow($arrowPosition, $arrowCol, $isArrowFlex);
        }

        // Fit Type Anpassungen
        if ($fitType === 'stretch') {
            $isImgFlex = true;
            $boxConfig['lines'] = 12;
        }

        // Fit Marker berechnen
        if ($fitType === 'fit' || $fitType === 'stretch') {
            $left = $isImgFlex ? 40 : 444.284;
            $fullWidth = self::config['wrapper']['width'] - ($left * 2);
            $colWidth = ($fullWidth - ($gutter * 11)) / 12;
            $startX = $left + ($boxConfig['position'] * ($colWidth + $gutter));
            $width = ($boxConfig['col'] * $colWidth) + (($boxConfig['col'] - 1) * $gutter);
            $endX = $startX + $width;

            $lineHeight = 55.637;
            $distance = 124;
            $boxHeight = $distance * ($boxConfig['lines'] - 1) + $lineHeight;
            $startY = ($fitType === 'stretch') ? $containerConfig['top'] : 928.1815;
            $endY = $boxHeight + $startY;

            $svgBottom = self::createFitMarkers($startX, $startY, $endX, $endY, $fitType);
        }

        // Container zusammenbauen
        $container =
            self::createContainer($containerConfig['left'], $containerConfig['top'], $containerConfig['height']) .
            (is_string($description) ? self::createDescriptionText($description, self::config['container']['width'] / 2, $descriptionTextTop, self::config['text']['fontSize']) : '') .
            self::createBox($boxConfig['lines'], $boxConfig['vertical'], $boxConfig['position'], $boxConfig['col'], $gutter, $isImgFlex, $boxConfig['top'], $boxConfig['containerHeight']) .
            self::createContentLines(
                $contentLinesConfig['lines'],
                $contentLinesConfig['vertical'],
                $contentLinesConfig['position'],
                $contentLinesConfig['col'],
                $gutter,
                $isContentFlex,
                $contentLinesConfig['top'],
                $contentLinesConfig['containerHeight'],
                (!empty($contentLinesConfig['paddingY']) ? $contentLinesConfig['paddingY'] : 0)
            ) . $svgBottom;

        return $getWrapper ? self::createBaseWrapper($container) : $container;
    }

    private static function createFitMarkers($startX, $startY, $endX, $endY, $type = 'fit'): string
    {
        if ($type === 'fit') {
            // Pfeile nach außen zeigend - 1.5x größer
            $arrow = 120; // 120 * 1.5
            $style = 'stroke: #000; stroke-width: 40px; fill: none; stroke-opacity: 1;'; // 40px * 1.5
            return '
        <!-- Fit-Pfeile -->
        <!-- Oben links -->
        <path style="' . $style . '" d="M' . $startX . ',' . $startY . ' L' . ($startX - $arrow) . ',' . ($startY - $arrow) . ' M' . $startX . ',' . $startY . ' L' . $startX . ',' . ($startY - $arrow) . ' M' . $startX . ',' . $startY . ' L' . ($startX - $arrow) . ',' . $startY . '"></path>
        <!-- Oben rechts -->
        <path style="' . $style . '" d="M' . $endX . ',' . $startY . ' L' . ($endX + $arrow) . ',' . ($startY - $arrow) . ' M' . $endX . ',' . $startY . ' L' . $endX . ',' . ($startY - $arrow) . ' M' . $endX . ',' . $startY . ' L' . ($endX + $arrow) . ',' . $startY . '"></path>
        <!-- Unten links -->
        <path style="' . $style . '" d="M' . $startX . ',' . $endY . ' L' . ($startX - $arrow) . ',' . ($endY + $arrow) . ' M' . $startX . ',' . $endY . ' L' . $startX . ',' . ($endY + $arrow) . ' M' . $startX . ',' . $endY . ' L' . ($startX - $arrow) . ',' . $endY . '"></path>
        <!-- Unten rechts -->
        <path style="' . $style . '" d="M' . $endX . ',' . $endY . ' L' . ($endX + $arrow) . ',' . ($endY + $arrow) . ' M' . $endX . ',' . $endY . ' L' . $endX . ',' . ($endY + $arrow) . ' M' . $endX . ',' . $endY . ' L' . ($endX + $arrow) . ',' . $endY . '"></path>';
        } else {
            // Stretch-Pfeile nach innen zeigend - 1.5x größer
            $inset = 150;   // 100 * 1.5
            $offset = 300;  // 200 * 1.5
            $style = 'stroke: #756f6d; stroke-width: 40px; fill: none; stroke-opacity: 1;'; // 40px * 1.5
            return '
        <!-- Stretch-Pfeile -->
        <!-- Oben links -->
        <path style="' . $style . '" d="M' . ($startX + $inset) . ',' . ($startY + $inset) . ' L' . ($startX + $offset) . ',' . ($startY + $offset) . ' M' . ($startX + $inset) . ',' . ($startY + $inset) . ' L' . ($startX + $inset) . ',' . ($startY + $offset) . ' M' . ($startX + $inset) . ',' . ($startY + $inset) . ' L' . ($startX + $offset) . ',' . ($startY + $inset) . '"></path>
        <!-- Oben rechts -->
        <path style="' . $style . '" d="M' . ($endX - $inset) . ',' . ($startY + $inset) . ' L' . ($endX - $offset) . ',' . ($startY + $offset) . ' M' . ($endX - $inset) . ',' . ($startY + $inset) . ' L' . ($endX - $inset) . ',' . ($startY + $offset) . ' M' . ($endX - $inset) . ',' . ($startY + $inset) . ' L' . ($endX - $offset) . ',' . ($startY + $inset) . '"></path>
        <!-- Unten links -->
        <path style="' . $style . '" d="M' . ($startX + $inset) . ',' . ($endY - $inset) . ' L' . ($startX + $offset) . ',' . ($endY - $offset) . ' M' . ($startX + $inset) . ',' . ($endY - $inset) . ' L' . ($startX + $inset) . ',' . ($endY - $offset) . ' M' . ($startX + $inset) . ',' . ($endY - $inset) . ' L' . ($startX + $offset) . ',' . ($endY - $inset) . '"></path>
        <!-- Unten rechts -->
        <path style="' . $style . '" d="M' . ($endX - $inset) . ',' . ($endY - $inset) . ' L' . ($endX - $offset) . ',' . ($endY - $offset) . ' M' . ($endX - $inset) . ',' . ($endY - $inset) . ' L' . ($endX - $inset) . ',' . ($endY - $offset) . ' M' . ($endX - $inset) . ',' . ($endY - $inset) . ' L' . ($endX - $offset) . ',' . ($endY - $inset) . '"></path>';
        }
    }

    private static function createLines()
    {
        return '<!-- lines-->
        <line style="stroke: #000; stroke-width: 27px; stroke-opacity: 0.18;" x1="384.815" y1="314.252" x2="384.815" y2="2461.252"></line>
        <line style="stroke: #000; stroke-width: 27px; stroke-opacity: 0.18;" x1="2393.52" y1="314.252" x2="2393.52" y2="2461.252"></line>
        <!-- arrow -->';
    }

    private static function createContainer($left = 0, $top = 656.598, $containerHeight = null): string
    {
        $height = (!is_null($containerHeight)) ? $containerHeight : self::config['container']['height'];
        $width = self::config['container']['width'] + (self::config['container']['width'] * 1.25);
        return '<rect style="width:' . $width . 'px; height: ' . $height . 'px; ' . self::config['container']['style'] . '" x="' . $left - (self::config['container']['width'] * 0.125) . '" y="' . $top . '"></rect>';
    }

    private static function createDescriptionText(string $text, float $x, float $y, int $fontSize = 110, string $color = '#000', string $fontWeight = 'normal'): string
    {
        return '<text style="font-family: Helvetica, Arial, sans-serif; text-align: center; font-size: ' . $fontSize . 'px; fill:' . $color . ';font-weight:' . $fontWeight . ';" x="' . $x . '" y="' . $y . '">' . $text . '</text>';
    }

    private static function createContentLines($lineCount = 4, $vertical = 'center', $position = 0, $col = 6, $gutter = 80, $isFlex = false, $top = 886.598, $containerHeight = 2780, $paddingY = 10): string
    {
        $lineHeight = 55.637; // höhe der Linien
        $distance = 124; // Abstand zwischen den Linien
        $boxHeight = $distance * ($lineCount - 1) + $lineHeight;
        $left = 444.284; // Abstand zum Rand des Containers

        if ($isFlex) {
            $left = 40;
        }

        // Y-Position berechnen basierend auf der Ausrichtung
        switch ($vertical) {
            case 'top':
                $startY = $top + $paddingY;
                break;
            case 'bottom':
                $startY = $top + ($containerHeight - $boxHeight) - $paddingY;
                break;
            case 'center':
            default:
                $startY = $top + ($containerHeight / 2) - ($boxHeight / 2);
                break;
        }

        // Breiten- und X-Position-Berechnungen bleiben gleich
        $fullWidth = 2780 - ($left * 2);
        $colWidth = ($fullWidth - ($gutter * 11)) / 12;
        $width = ($col * $colWidth) + (($col - 1) * $gutter);
        $x = $left + ($position * ($colWidth + $gutter));

        // Linien zeichnen
        $style = 'width: ' . $width . 'px; height: ' . $lineHeight . 'px; background-color: #000; opacity: 0.8;';
        $lines = '';

        // Alle Linien zeichnen, beginnend bei startY
        $currentY = $startY;
        for ($i = 0; $i < $lineCount; $i++) {
            $lines .= '<rect style="' . $style . '" x="' . $x . '" y="' . $currentY . '"></rect>';
            $currentY += $distance; // Nächste Position mit Abstand
        }

        return $lines;
    }

    private static function createBox($lineCount = 4, $vertical = 'center', $position = 0, $col = 6, $gutter = 80, $isFlex = false, $top = 656.598, $containerHeight = 2780): string
    {
        $lineHeight = 55.637;
        $distance = 124;
        $boxHeight = $distance * ($lineCount - 1) + $lineHeight;
        $left = 444.284;

        if ($isFlex) {
            $left = 40;
        }

        // Y-Position berechnen
        switch ($vertical) {
            case 'top':
                $y = $top;
                break;
            case 'bottom':
                $y = (($containerHeight - $boxHeight) - ($top/2));
                break;
            case 'center':
            default:
                // top + höhe des containers - höhe der box / 2
                $y = $top + ($containerHeight / 2) - ($boxHeight / 2);
                break;
        }

        // Breiten- und X-Position-Berechnungen
        $fullWidth = self::config['wrapper']['width'] - ($left * 2);
        $colWidth = ($fullWidth - ($gutter * 11)) / 12;
        $width = ($col * $colWidth) + (($col - 1) * $gutter);
        $x = $left + ($position * ($colWidth + $gutter));

        $style = 'width: ' . $width . 'px; height: ' . $boxHeight . 'px; background-color: #000; opacity: 0.4;';
        return '<rect style="' . $style . '" x="' . $x . '" y="' . $y . '"></rect>';
    }

    private static function createHorizontalArrow($position = 0, $col = 6, $isFlex = false, $options = []): string
    {
        // Standard Werte
        $left = $isFlex ? 40 : 444.284;
        $gutter = isset($options['gutter']) ? $options['gutter'] : 80;
        $opacity = isset($options['opacity']) ? $options['opacity'] : 0.67;
        $y = isset($options['y']) ? $options['y'] : 2291.14;

        // Berechne die Position und Breite basierend auf Spalten
        $fullWidth = 2780 - ($left * 2);
        $colWidth = ($fullWidth - ($gutter * 11)) / 12;
        $width = ($col * $colWidth) + (($col - 1) * $gutter);

        // Anpassung der X-Position um die Pfeilspitzen im sichtbaren Bereich zu halten
        $arrowTipWidth = 93.158; // Breite der Pfeilspitze
        if ($position > 0) {
            $x = $left - $position * ($colWidth + $gutter);
        }
        $x = $left + $position * ($colWidth + $gutter) + $arrowTipWidth;
        $adjustedWidth = $width - (2 * $arrowTipWidth); // Reduziere die Breite um Platz für die Pfeilspitzen zu lassen

        // Original Pfadkoordinaten als Basis mit angepasster Breite
        $originalPath = "M490.086,2291.14l36.932,36.932l-32.937,32.937l-93.158,-93.159l93.158,-93.159l32.937,32.937l-36.932,36.932l2173.06,0l-36.932,-36.932l32.937,-32.937l93.158,93.159l-93.158,93.159l-32.937,-32.937l36.932,-36.932l-2173.06,-0Z";

        // Pfad in einzelne Koordinaten aufteilen
        $coordinates = explode('l', substr($originalPath, 1));

        $newPath = 'M' . ($x) . ',' . ($y); // Neuer Startpunkt

        foreach ($coordinates as $i => $coord) {
            if ($i === 0) continue;

            $parts = explode(',', $coord);
            $dx = floatval($parts[0]);
            $dy = isset($parts[1]) ? floatval($parts[1]) : 0;

            // Skaliere horizontale Bewegungen wenn sie der Hauptbreite entsprechen
            if (abs($dx) > 2000) { // Wenn es sich um die Hauptbreite handelt
                $dx = $dx > 0 ? $adjustedWidth : -$adjustedWidth;
            }

            $newPath .= 'l' . $dx . ',' . $dy;
        }

        return sprintf(
            '<path style="fill: #505050; opacity: %f; stroke: #000; stroke-opacity: 0.18; stroke-width: 1.67px;" d="%s"></path>',
            $opacity,
            $newPath
        );
    }

    private static function createBaseWrapper(string $content = ''): string
    {
        return '<div style="width: ' . self::config['wrapper']['width'] . 'px; height: ' . self::config['wrapper']['height'] . 'px;">
            <!-- Grauer Hintergrund -->
            <rect style="width: ' . self::config['wrapper']['width'] . 'px; height: ' . self::config['wrapper']['height'] . 'px;' . self::config['wrapper']['style'] . '" x="0" y="0"></rect>

            ' . $content . '

        </div>';
    }


// Ergänzung für SVGConfigIconSet.php

    public static function getImageFormatIcon($description = '', $ratio = 1, array $containerConfig = [], $descriptionTextTop = 2451.55): string
    {
        // Grauer Hintergrund
        $content = '<!-- Grauer Hintergrund -->
    <rect style="width:' . self::config['wrapper']['width'] . 'px; height:' . self::config['wrapper']['height'] . 'px;' . self::config['wrapper']['style'] . '" x="0" y="0"></rect>
    
    <!-- Weißer Container -->
    <rect style="width: ' . self::config['container']['width'] . 'px; height: ' . self::config['container']['height'] . 'px; background-color: #fff; opacity: 0.67;" x="0" y="' . self::config['container']['top'] . '"></rect>';

        // Berechne Bildabmessungen mit konstanter Höhe
        $maxWidth = self::config['container']['width'] * 0.8;
        $height = self::config['container']['height'] * 0.6;
        $width = $height * $ratio;

        // Breite begrenzen falls nötig
        if ($width > $maxWidth) {
            $width = $maxWidth;
        }

        // Zentriere das Format-Beispiel
        $imageX = (self::config['container']['width'] - $width) / 2;
        $imageY = self::config['container']['top'] + (self::config['container']['height'] - $height) / 2;

        // Füge Format-Box hinzu
        $content .= '<!-- Format Box -->
    <rect style="fill: #000000; opacity: 0.8;" 
          x="' . $imageX . '" 
          y="' . $imageY . '" 
          width="' . $width . '" 
          height="' . $height . '"></rect>';

        // Description Text
        if ($description) {
            $content .= self::createDescriptionText($description, self::config['wrapper']['width'] / 2, $descriptionTextTop);
        }

        return '<div style="width: ' . self::config['wrapper']['width'] . 'px; height: ' . self::config['wrapper']['height'] . 'px;">' . $content . '</div>';
    }

    public static function getMasonryColumnsIcon($description = '', $columns = 3, $style = 'mixed'): string {
        $containerHeight = self::config['container']['height'] - 300;

        // Container erstellen
        $content = self::createContainer(0, self::config['container']['top'], $containerHeight);

        // Spalten-spezifisches Grid Pattern erstellen
        $columnPattern = self::createMasonryGridPattern(100, self::config['container']['top'], $containerHeight, $columns);
        $content .= $columnPattern;

        if ($description) {
            $content .= self::createDescriptionText($description, self::config['wrapper']['width'] / 2, 2451.55);
        }

        return self::createBaseWrapper($content);
    }

    public static function getMasonryGridIcon($description = '', $columns = 3, $style = 'mixed'): string
    {
        // Grauer Hintergrund
        $content = '<!-- Grauer Hintergrund -->
        <rect style="width:' . self::config['wrapper']['width'] . 'px; height:' . self::config['wrapper']['height'] . 'px;' . self::config['wrapper']['style'] . '" x="0" y="0"></rect>
        
        <!-- Weißer Container -->
        <rect style="width: ' . self::config['container']['width'] . 'px; height: ' . self::config['container']['height'] . 'px; background-color: #fff; opacity: 0.67;" x="0" y="' . self::config['container']['top'] . '"></rect>';

        // Grid-Einstellungen
        $gutter = 80;
        $usableWidth = self::config['container']['width'] * 0.8;
        $columnWidth = ($usableWidth - ($gutter * ($columns - 1))) / $columns;
        $startX = (self::config['container']['width'] - $usableWidth) / 2;

        // Höhenvariationen für dynamisches Layout
        $heights = [
            $columnWidth * 0.8,
            $columnWidth,
            $columnWidth * 1.2,
            $columnWidth * 0.7,
            $columnWidth * 1.1,
            $columnWidth * 0.9
        ];

        // Erstelle Masonry Grid
        $boxes = '';
        $columnHeights = array_fill(0, $columns, self::config['container']['top'] + 100);

        // Boxes erstellen
        $maxBoxes = $columns * 3;
        for ($i = 0; $i < $maxBoxes; $i++) {
            $column = array_keys($columnHeights, min($columnHeights))[0];
            $height = $heights[array_rand($heights)];

            $x = $startX + ($column * ($columnWidth + $gutter));
            $y = $columnHeights[$column];

            if (($y + $height + $gutter) < (self::config['container']['top'] + self::config['container']['height'] - 100)) {
                $boxes .= '<!-- Masonry Box -->
                <rect style="fill: #000000; opacity: 0.8;" 
                      x="' . $x . '" 
                      y="' . $y . '" 
                      width="' . $columnWidth . '" 
                      height="' . $height . '"></rect>';

                $columnHeights[$column] = $y + $height + $gutter;
            }
        }

        $content .= $boxes;

        // Description Text
        if ($description) {
            $content .= self::createDescriptionText($description, self::config['wrapper']['width'] / 2, 2451.55);
        }

        return '<div style="width: ' . self::config['wrapper']['width'] . 'px; height: ' . self::config['wrapper']['height'] . 'px;">' . $content . '</div>';
    }




    /**
     * Creates a masonry grid icon with container configuration
     */
    public static function getMasonryGridContainerIcon($description = '', $type = 'box'): string
    {
        // Container-Padding basierend auf Typ
        $padding = match($type) {
            'smallBox' => 350,
            'box' => 200,
            'fluid' => 40,
            default => 200
        };

        $containerTop = self::config['container']['top'];
        $containerHeight = self::config['container']['height'];

        // Basis-Container erstellen
        $content = sprintf(
            '<rect style="width:%dpx; height:%dpx; %s" x="0" y="0"></rect>',
            self::config['wrapper']['width'],
            self::config['wrapper']['height'],
            self::config['wrapper']['style']
        );

        // Container mit Padding
        $content .= sprintf(
            '<rect style="width:%dpx; height:%dpx; background-color: #fff; opacity: 0.67;" x="0" y="%d"></rect>',
            self::config['container']['width'],
            $containerHeight,
            $containerTop
        );

        // Masonry Grid hinzufügen
        $content .= self::createMasonryGridPattern($padding, $containerTop, $containerHeight);

        // Container-Typ Visualisierung
        if ($type !== 'fluid') {
            $content .= self::createLines();
        }

        // Beschreibungstext
        if ($description) {
            $content .= self::createDescriptionText(
                $description,
                self::config['wrapper']['width'] / 2,
                2451.55
            );
        }

        return sprintf(
            '<div style="width:%dpx; height:%dpx">%s</div>',
            self::config['wrapper']['width'],
            self::config['wrapper']['height'],
            $content
        );
    }


    /**
     * Creates a masonry grid pattern optimized for sections
     */
    private static function createMasonryGridPattern($padding = 80, $startY = 656.598, $containerHeight = null, $columns = 3): string
    {
        $containerHeight = $containerHeight ?? self::config['container']['height'];
        $gutter = 40;
        $usableWidth = self::config['container']['width'] - (2 * $padding);
        $columnWidth = ($usableWidth - ($gutter * ($columns - 1))) / $columns;

        $boxes = '';
        $columnHeights = array_fill(0, $columns, $startY + $gutter);

        // Angepasste Höhen für kompakteres Layout
        $heights = [
            $columnWidth * 0.4,  // Extra klein
            $columnWidth * 0.6,  // Klein
            $columnWidth * 0.8,  // Medium
            $columnWidth * 0.5,  // Zwischen klein
        ];

        $maxIterations = 12; // Begrenzt die Anzahl der Boxen pro Section
        $iteration = 0;

        while ($iteration < $maxIterations && min($columnHeights) < ($startY + $containerHeight - $gutter)) {
            $column = array_keys($columnHeights, min($columnHeights))[0];

            $x = $padding + ($column * ($columnWidth + $gutter));
            $y = $columnHeights[$column];

            $height = $heights[array_rand($heights)];

            if (($y + $height + $gutter) <= ($startY + $containerHeight - $gutter)) {
                $boxes .= sprintf(
                    '<rect style="fill: #000000; opacity: 0.8;" x="%f" y="%f" width="%f" height="%f"></rect>',
                    $x,
                    $y,
                    $columnWidth,
                    $height
                );

                $columnHeights[$column] = $y + $height + $gutter;
            }

            $iteration++;
        }

        return $boxes;
    }

    /**
     * Creates a single masonry section with container and pattern
     */
    private static function createMasonrySection($top, $height, $width): string
    {
        // Container Background
        $section = sprintf(
            '<rect style="width:%dpx; height:%dpx; background-color: #fff; opacity: 0.67; border: 67.08px solid rgba(0,0,0,0.1)" x="0" y="%d"></rect>',
            $width,
            $height,
            $top
        );

        // Berechne effektive Inhaltsbereich
        $contentPadding = 120; // Padding innerhalb des Containers
        $contentTop = $top + $contentPadding;
        $contentHeight = $height - ($contentPadding * 2);
        $contentWidth = $width - ($contentPadding * 2);

        // Spalten-Setup
        $columns = 3;
        $gutter = $contentWidth * 0.02; // 2% des verfügbaren Platzes
        $columnWidth = ($contentWidth - ($gutter * ($columns - 1))) / $columns;

        // Erstelle Masonry-Muster
        $columnHeights = array_fill(0, $columns, $contentTop);
        $pattern = '';

        // Verschiedene Boxhöhen für den Masonry-Effekt
        $heights = [
            $columnWidth * 0.5,  // Klein
            $columnWidth * 0.7,  // Medium
            $columnWidth * 0.6,  // Standard
            $columnWidth * 0.8   // Groß
        ];

        // Erzeuge Boxen für jede Spalte
        for ($col = 0; $col < $columns; $col++) {
            $x = $contentPadding + ($col * ($columnWidth + $gutter));
            $currentY = $columnHeights[$col];

            while ($currentY + min($heights) < $contentTop + $contentHeight) {
                $boxHeight = $heights[array_rand($heights)];

                if ($currentY + $boxHeight <= $contentTop + $contentHeight) {
                    $pattern .= sprintf(
                        '<rect style="fill: #000000; opacity: 0.8;" x="%f" y="%f" width="%f" height="%f"></rect>',
                        $x,
                        $currentY,
                        $columnWidth,
                        $boxHeight
                    );

                    $currentY += $boxHeight + ($gutter / 2);
                } else {
                    break;
                }
            }
        }

        return $section . $pattern;
    }


    /**
     * Creates a double section masonry layout with margin
     */
    public static function getMasonryMarginIcon($description = '', array $settings = []): string
    {
        $marginSize = $settings['margin'] ?? 1;
        $marginSpacing = $marginSize * 270;

        $defaultHeight = self::config['container']['height'] - 300;
        $top = 200;

        $containerWidth = self::config['container']['width'];

        // Basis SVG
        $content = sprintf(
            '<rect style="width:%dpx; height:%dpx; %s" x="0" y="0"></rect>',
            self::config['wrapper']['width'],
            self::config['wrapper']['height'],
            self::config['wrapper']['style']
        );

        // Erste Section
        $content .= sprintf(
            '<rect style="width:%dpx; height:%dpx; background-color: #fff; opacity: 0.67; border: 67.08px solid rgba(0,0,0,0.1)" x="0" y="%d"></rect>',
            $containerWidth,
            $defaultHeight,
            $top
        );

        // Masonry Boxen für erste Section
        $content .= self::createMasonryBoxes($top + 67.08, $defaultHeight - 134.16);

        // Zweite Section mit Margin-Abstand
        $secondSectionTop = $top + $defaultHeight + $marginSpacing;

        $content .= sprintf(
            '<rect style="width:%dpx; height:%dpx; background-color: #fff; opacity: 0.67; border: 67.08px solid rgba(0,0,0,0.1)" x="0" y="%d"></rect>',
            $containerWidth,
            $defaultHeight,
            $secondSectionTop
        );

        // Masonry Boxen für zweite Section
        $content .= self::createMasonryBoxes($secondSectionTop + 67.08, $defaultHeight - 134.16);

        if ($description) {
            $content .= self::createDescriptionText(
                $description,
                self::config['wrapper']['width'] / 2,
                floatval($marginSize * 90) + 1380
            );
        }

        return sprintf(
            '<div style="width:%dpx; height:%dpx">%s</div>',
            self::config['wrapper']['width'],
            self::config['wrapper']['height'],
            $content
        );
    }


    public static function getMasonryPaddingIcon($description = '', array $settings = []): string
    {
        $paddingSize = $settings['padding'] ?? 1;
        $height = self::config['container']['height'] - 300;
        $top = 10;

        // Box Config 1 für korrekte Höhenberechnung der ersten Section
        $boxConfig1 = [
            'top' => $top,
            'containerHeight' => $height,
        ];
        $top = $boxConfig1['top'];
        $height = $boxConfig1['containerHeight'];

        // Box Config 2 für korrekte Höhenberechnung der zweiten Section
        $boxConfig2 = [
            'top' => $top,
            'containerHeight' => $height,
        ];
        $top = $boxConfig2['top'];
        $boxHeight = $boxConfig2['containerHeight'];
        $boxConfig2['top'] = $boxConfig2['top'] + $height;

        // Erste Section
        $container1Content = self::createContainer(0, $boxConfig1['top'], $boxConfig1['containerHeight']);
        $container1Content .= self::createMasonryBoxes(
            $boxConfig1['top'] + floatval($paddingSize * 180) + 100,
            $boxConfig1['containerHeight'] - 250,
            350
        );

        // Zweite Section
        $container2Content = self::createContainer(0, $boxConfig2['top'], $boxConfig2['containerHeight']);
        $container2Content .= self::createMasonryBoxes(
            $boxConfig2['top'] + floatval($paddingSize * 180) + 100,
            $boxConfig2['containerHeight'] - 250,
            350
        );

        // Description Text
        $descriptionText = '';
        if ($description) {
            $descriptionText = self::createDescriptionText(
                $description,
                self::config['wrapper']['width'] / 2,
                floatval($paddingSize * 90) + 1380
            );
        }

        return self::createBaseWrapper(
            $container1Content .
            $container2Content .
            $descriptionText
        );
    }
    /**
     * Creates masonry boxes with fixed sizes, shared between margin and padding icons
     */
    private static function createMasonryBoxes($startY, $maxHeight, $boxHeight = 350): string
    {
        $boxes = '';
        $columns = 2;
        $startX = 444.284;
        $columnWidth = 800;
        $gutter = 150;

        // Verfolge die aktuelle Höhe jeder Spalte
        $columnHeights = array_fill(0, $columns, $startY);

        // Erstelle genau 4 Boxen
        for ($i = 0; $i < 4; $i++) {
            $currentColumn = $i % 2; // Alterniert zwischen 0 und 1

            // Berechne Position für neue Box
            $x = $startX + ($currentColumn * ($columnWidth + $gutter));
            $y = $columnHeights[$currentColumn];

            $boxes .= sprintf(
                '<rect style="fill: #000000; opacity: 0.8;" x="%d" y="%d" width="%d" height="%d"></rect>',
                $x,
                $y,
                $columnWidth,
                $boxHeight
            );

            // Aktualisiere die Spaltenhöhe
            $columnHeights[$currentColumn] = $y + $boxHeight + 50;
        }

        return $boxes;
    }


    public static function getImgColumnWidthIcon($description = '', $col = 6, $position = 'left', $showLines = false): string
    {
        // Position der Spalte bestimmen
        $columnPosition = match($position) {
            'left' => 0,
            'right' => 12 - $col,
            'center' => (12 - $col) / 2, // Zentriert die Spalte
            default => 0
        };

        // Container Konfiguration
        $containerConfig = [
            'width' => self::config['container']['width'],
            'height' => self::config['container']['height'],
            'left' => 0,
            'top' => self::config['container']['top'],
            'style' => self::config['container']['style'],
        ];

        // Image-Box Konfiguration (statt Text-Lines)
        $boxConfig = [
            'lines' => 8, // Anzahl der Linien für die Box-Höhe
            'vertical' => 'center',
            'position' => $columnPosition,
            'col' => $col,
            'top' => self::config['container']['top'],
            'containerHeight' => $containerConfig['height'],
            'fitType' => 'fit' // Standard-Bildanpassung
        ];

        // Container erstellen mit Box statt Text
        $container =
            self::createContainer($containerConfig['left'], $containerConfig['top'], $containerConfig['height']) .
            (is_string($description) ? self::createDescriptionText($description, self::config['container']['width'] / 2, 2451.55, self::config['text']['fontSize']) : '') .
            self::createBox(
                $boxConfig['lines'],
                $boxConfig['vertical'],
                $boxConfig['position'],
                $boxConfig['col'],
                self::config['grid']['gutter'],
                false, // stretch
                $boxConfig['top'],
                $boxConfig['containerHeight']
            );

        return self::createBaseWrapper($container . (($showLines === true) ? self::createLines() : ''));
    }
}