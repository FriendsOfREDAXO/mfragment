<?php
/**
 * @author Joachim Doerr
 * @package redaxo5
 * @license MIT
 */

use FriendsOfRedaxo\MForm;
use FriendsOfRedaxo\MForm\Inputs\MFormInputsAbstract;
use FriendsOfRedaxo\MForm\Inputs\MFormInputsInterface;

class section extends MFormInputsAbstract implements MFormInputsInterface
{
    protected array $config = [
        'id' => 'section',
        'fittingLabel' => 'Einpassung',
        'fittingDefaultValue' => 'box',
        'fitting' => [
            'box' => ['img' => "../theme/public/assets/backend/img/text_text_container_stretch_1.svg", 'label' => "Box"],
            'full' => ['img' => "../theme/public/assets/backend/img/text_text_container_stretch_2.svg", 'label' => "Fluid"],
        ],
        'marginLabel' => 'Zeilenabstand',
        'marginDefaultValue' => 1,
        'margin' => [
            0 => ['img' => "../theme/public/assets/backend/img/text_text_margin_0.svg", 'label' => "Margin 0"],
            1 => ['img' => "../theme/public/assets/backend/img/text_text_margin_1.svg", 'label' => "Margin 1"],
            4 => ['img' => "../theme/public/assets/backend/img/text_text_margin_2.svg", 'label' => "Margin 2"],
            7 => ['img' => "../theme/public/assets/backend/img/text_text_margin_3.svg", 'label' => "Margin 3"],
        ],
        'paddingLabel' => 'Innenabstand',
        'paddingDefaultValue' => 1,
        'padding' => [
            0 => ['img' => "../theme/public/assets/backend/img/text_text_padding_0.svg", 'label' => "Padding 0"],
            1 => ['img' => "../theme/public/assets/backend/img/text_text_padding_1.svg", 'label' => "Padding 1"],
            4 => ['img' => "../theme/public/assets/backend/img/text_text_padding_2.svg", 'label' => "Padding 2"],
            7 => ['img' => "../theme/public/assets/backend/img/text_text_padding_3.svg", 'label' => "Padding 3"],
        ],
        'borderLabel' => '',
        'borderDefaultValue' => '',
        'border' => false,
        'bgClassLabel' => 'Hintergrundfarbe',
        'bgClassDefaultValue' => 'default',
        'bgClass' => [
            'default' => 'Standard',
            'primary' => 'Primär',
            'secondary' => 'Sekundär',
            'muted' => 'Muted',
            'transparent' => 'Transparent'
        ],
        'configKeys' => ['bgImg', 'bgColor', 'fitting', 'margin', 'padding', 'border'],
        'bgImgLabel' => 'Hintergrund-Bild',
        'bgImgDefaultValue' => '',
        'bgImg' => true,
    ];

    public function generateInputsForm(): MForm
    {
        $id = (!empty($this->config['id'])) ? $this->config['id'] . '.' : '';

        return self::getConfigForm($id);
    }
}