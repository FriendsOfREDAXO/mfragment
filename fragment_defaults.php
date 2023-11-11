<?php
/**
 * @author Joachim Doerr
 * @package redaxo5
 * @license MIT
 */

global $MFragmentDefaultConfig;

$MFragmentDefaultConfig = [
    'module' => [
        'uikit_slideshow' => [
            'section' => [
                'class' => [
                    'padding' => '', // '', 'uk-padding', 'uk-padding-small', 'uk-padding-large'
                    'ukcolor' => '', // '', 'uk-section-default', 'uk-section-primary', 'uk-section-secondary', 'uk-section-muted'
                ],
                'parallax' => 'true',   // '', 'true'
                'uk-parallax' => [ // if parallax = true
                    'easing' => 0,      // -2, -1, -0.5, 0, 0.5, 1, 2
                    'y' => 200,         // '200,0,200', 200
                    'start' => '100vh', // '100vh', '100%', 100
                    'end' => '',        // '100vh', '100%', 100
                ],
            ],
            'container' => [
                'class' => [
                    'default' => '',                      // '', 'uk-container'
                    'container' => 'uk-container-expand', // 'uk-container-xsmall', 'uk-container-small', 'uk-container-large', 'uk-container-xlarge', 'uk-container-expand'
                ]
            ],
            'slideshow' => [
                'uk-slideshow' => [
                    'animation' => 'slide',         // ''
                    'autoplay-interval' => 6000,    // 6000
                    'pause-on-hover' => 'true',     // 'true', 'false'
                    'draggable' => 'true',          // 'true', 'false'
                    'finite' => 'true',             // 'true', 'false'
                    'ratio' => '16:5',              //
                    'min-height' => 300,            // 300
                    'max-height' => 800,            // 800
                ],
                'showDotNavigation' => 'true',  // 'true', 'false'
                'showArrows' => 'true',         // 'true', 'false'
                'fullHeight' => 0,              // 0,1
                'uk-height-viewport' => [ // if fullHeight = true
                    'offset-top' => 'true',     // 'true', 'false'
                    'offset-bottom' => '',      // '', 300
                    'min-height' => 300,        // '', 300
                ]
            ]
        ]
    ]
];

// DEBUG CONFIG VIEW
# echo '<pre>'; print_r($MFragmentDefaultConfig); echo '</pre>';




