<?php
namespace FriendsOfRedaxo\MFragment\Helper;

class BootstrapHelper
{
    public static function getPaddingClasses(array $settings, float $mdFactor = 1, float $lgFactor = 1.25): array {
        $class = [];
        if (!empty($settings['padding'])) {
            $class['padding-md'] = 'p-md-' . ceil($settings['padding'] * $mdFactor);
            $class['padding-lg'] = 'p-lg-' . ceil($settings['padding'] * $lgFactor);
        }
        if (!empty($settings['padding-y'])) {
            $class['padding-y-md'] = 'py-md-' . ceil($settings['padding-y'] * $mdFactor);
            $class['padding-y-lg'] = 'py-lg-' . ceil($settings['padding-y'] * $lgFactor);
        }
        if (!empty($settings['padding-x'])) {
            $class['padding-x-md'] = 'px-md-' . ceil($settings['padding-x'] * $mdFactor);
            $class['padding-x-lg'] = 'px-lg-' . ceil($settings['padding-x'] * $lgFactor);
        }
        if (!empty($settings['padding-left'])) {
            $class['padding-left-md'] = 'ps-md-' . ceil($settings['padding-left'] * $mdFactor);
            $class['padding-left-lg'] = 'ps-lg-' . ceil($settings['padding-left'] * $lgFactor);
        }
        if (!empty($settings['padding-right'])) {
            $class['padding-right-md'] = 'pe-md-' . ceil($settings['padding-right'] * $mdFactor);
            $class['padding-right-lg'] = 'pe-lg-' . ceil($settings['padding-right'] * $lgFactor);
        }
        if (!empty($settings['padding-top'])) {
            $class['padding-top-md'] = 'pt-md-' . ceil($settings['padding-top'] * $mdFactor);
            $class['padding-top-lg'] = 'pt-lg-' . ceil($settings['padding-top'] * $lgFactor);
        }
        if (!empty($settings['padding-bottom'])) {
            $class['padding-bottom-md'] = 'pb-md-' . ceil($settings['padding-bottom'] * $mdFactor);
            $class['padding-bottom-lg'] = 'pb-lg-' . ceil($settings['padding-bottom'] * $lgFactor);
        }
        return $class;
    }

    public static function getMarginClasses(array $settings, float $mdFactor = 1, float $lgFactor = 1.25): array {
        $class = [];
        if (!empty($settings['margin'])) {
            $class['margin-md'] = 'm-md-' . ceil($settings['margin'] * $mdFactor);
            $class['margin-lg'] = 'm-lg-' . ceil($settings['margin'] * $lgFactor);
        }
        if (!empty($settings['margin-y'])) {
            $class['margin-y-md'] = 'my-md-' . ceil($settings['margin-y'] * $mdFactor);
            $class['margin-y-lg'] = 'my-lg-' . ceil($settings['margin-y'] * $lgFactor);
        }
        if (!empty($settings['margin-x'])) {
            $class['margin-x-md'] = 'mx-md-' . ceil($settings['margin-x'] * $mdFactor);
            $class['margin-x-lg'] = 'mx-lg-' . ceil($settings['margin-x'] * $lgFactor);
        }
        if (!empty($settings['margin-left'])) {
            $class['margin-left-md'] = 'ms-md-' . ceil($settings['margin-left'] * $mdFactor);
            $class['margin-left-lg'] = 'ms-lg-' . ceil($settings['margin-left'] * $lgFactor);
        }
        if (!empty($settings['margin-right'])) {
            $class['margin-right-md'] = 'me-md-' . ceil($settings['margin-right'] * $mdFactor);
            $class['margin-right-lg'] = 'me-lg-' . ceil($settings['margin-right'] * $lgFactor);
        }
        if (!empty($settings['margin-top'])) {
            $class['margin-top-md'] = 'mt-md-' . ceil($settings['margin-top'] * $mdFactor);
            $class['margin-top-lg'] = 'mt-lg-' . ceil($settings['margin-top'] * $lgFactor);
        }
        if (!empty($settings['margin-bottom'])) {
            $class['margin-bottom-md'] = 'mb-md-' . ceil($settings['margin-bottom'] * $mdFactor);
            $class['margin-bottom-lg'] = 'mb-lg-' . ceil($settings['margin-bottom'] * $lgFactor);
        }
        return $class;
    }

    public static function getColumnClasses(array $settings, float $mdFactor = 0.75, float $lgFactor = 1): array
    {
        $class = [
            'default' => 'col-12'
        ];

        if (!empty($settings['col'])) {
            $mdValue = min(12, max(1, ceil($settings['col'] * $mdFactor)));
            $lgValue = min(12, max(1, ceil($settings['col'] * $lgFactor)));

            $class['col-md'] = 'col-md-' . $mdValue;
            $class['col-lg'] = 'col-lg-' . $lgValue;
        }

        return array_filter($class);
    }

    public static function getPositionClasses(array $settings): array
    {
        $class = [];
        if (!empty($settings['position'])) {
            switch ($settings['position']) {
                case 'left':
                    $class['position'] = 'me-auto';
                    break;
                case 'center':
                    $class['position'] = 'm-auto';
                    break;
                case 'right':
                    $class['position'] = 'ms-auto';
                    break;
            }
        }
        return $class;
    }

    public static function getContainerClasses(array $settings): array
    {
        if (empty($settings['fitting'])) {
            return ['default' => 'container-lg'];
        }

        $types = [
            'smallBox' => 'container-narrow',
            'box' => 'container-lg',
            'fluid' => 'container-fluid',
            'fluidBox' => 'container-fluid'
        ];

        return [
            'default' => $types[$settings['fitting']] ?? ''
        ];
    }

    public static function isContainerDataTxtFluid(array $settings): string {
        if (!empty($settings['fitting'])) {
            switch ($settings['fitting']) {
                case 'fluidBox':
                    return 'false';
            }
        }
        return 'true';
    }
}