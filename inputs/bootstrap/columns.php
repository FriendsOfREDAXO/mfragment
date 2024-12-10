<?php
/**
 * @author Joachim Doerr
 * @package redaxo5
 * @license MIT
 */

use FriendsOfRedaxo\MForm;
use FriendsOfRedaxo\MForm\Inputs\MFormInputsAbstract;
use FriendsOfRedaxo\MForm\Inputs\MFormInputsInterface;

class columns extends MFormInputsAbstract implements MFormInputsInterface
{
    protected array $config = [
        'id' => 'columns',
        'open' => true,
        'btnLabel' => 'Spalten hinzufügen',
        'confirmDeleteMessage' => 'Spalte löschen?',
        'contentTabTitle' => '<i class="fa fa-file-text-o"></i> Text (Spalte)',
        'configTabTitle' => '<i class="fa fa-cog"></i> Einstellungen (Spalte)',
        'colLabel' => 'Zeilenbreite',
        'colDefaultValue' => 'auto',
        'col' => [
            'auto' => ['img' => "../theme/public/assets/backend/img/text_text_col_auto.svg", 'label' => "Automatische Spaltenbreite"],
            1 => [],
            2 => [],
            3 => ['img' => "../theme/public/assets/backend/img/text_text_col_3.svg", 'label' => "Col3"],
            4 => ['img' => "../theme/public/assets/backend/img/text_text_col_4.svg", 'label' => "Col4"],
            5 => ['img' => "../theme/public/assets/backend/img/text_text_col_5.svg", 'label' => "Col5"],
            6 => ['img' => "../theme/public/assets/backend/img/text_text_col_6.svg", 'label' => "Col6"],
            7 => ['img' => "../theme/public/assets/backend/img/text_text_col_7.svg", 'label' => "Col7"],
            8 => ['img' => "../theme/public/assets/backend/img/text_text_col_8.svg", 'label' => "Col8"],
            9 => ['img' => "../theme/public/assets/backend/img/text_text_col_9.svg", 'label' => "Col9"],
            10 => [],
            11 => [],
            12 => [],
        ],
        'marginLabel' => 'Außenabstand',
        'marginDefaultValue' => 1,
        'margin' => [
            0 => ['img' => "../theme/public/assets/backend/img/text_text_margin_0.svg", 'label' => "Margin 0"],
            1 => ['img' => "../theme/public/assets/backend/img/text_text_margin_1.svg", 'label' => "Margin 1"],
            2 => [],
            3 => [],
            4 => ['img' => "../theme/public/assets/backend/img/text_text_margin_2.svg", 'label' => "Margin 2"],
            5 => [],
            6 => [],
            7 => ['img' => "../theme/public/assets/backend/img/text_text_margin_3.svg", 'label' => "Margin 3"],
            8 => [],
            10 => [],
        ],
        'paddingLabel' => 'Innenabstand',
        'paddingDefaultValue' => 1,
        'padding' => [
            0 => ['img' => "../theme/public/assets/backend/img/text_text_padding_0.svg", 'label' => "Padding 0"],
            1 => ['img' => "../theme/public/assets/backend/img/text_text_padding_1.svg", 'label' => "Padding 1"],
            2 => [],
            3 => [],
            4 => ['img' => "../theme/public/assets/backend/img/text_text_padding_2.svg", 'label' => "Padding 2"],
            5 => [],
            6 => [],
            7 => ['img' => "../theme/public/assets/backend/img/text_text_padding_3.svg", 'label' => "Padding 3"],
            8 => [],
            9 => [],
            10 => [],
        ],
        'borderLabel' => '',
        'borderDefaultValue' => '',
        'border' => [
        ],
        'verticalAlignLabel' => 'Zentrierung',
        'verticalAlignDefaultValue' => 'start',
        'verticalAlign' => [
            'start' => ['img' => "../theme/public/assets/backend/img/text_text_vertical_3.svg", 'label' => "Top"],
            'center' => ['img' => "../theme/public/assets/backend/img/text_text_vertical_1.svg", 'label' => "Center"],
            'end' => ['img' => "../theme/public/assets/backend/img/text_text_vertical_2.svg", 'label' => "Bottom"],
        ],
        'horizontalAlignLabel' => '',
        'horizontalAlignDefaultValue' => '',
        'horizontalAlign' => [
        ],
        'bgColorLabel' => 'Hintergrundfarbe',
        'bgColorDefaultValue' => 'default',
        'bgColor' => [
            'default' => 'Standard',
            'primary' => 'Primär',
            'secondary' => 'Sekundär',
            'muted' => 'Muted',
            'transparent' => 'Transparent'
        ],
        'configKeys' => ['bgColor', 'col', 'margin', 'padding', 'border', 'verticalAlign', 'horizontalAlign']
    ];

    public function generateInputsForm(): MForm
    {
        return MForm::factory()->setShowWrapper(false)
            ->addRepeaterElement($this->config['id'], MForm::factory()
                ->addTabElement($this->config['contentTabTitle'], self::getContentFrom(), true)
                ->addTabElement($this->config['configTabTitle'], self::getConfigForm())
            , $this->config['open'], true, ['btn_text' => $this->config['btnLabel'], 'btn_class' => 'btn-default', 'confirm_delete_msg' => $this->config['confirmDeleteMessage']]);
    }
}
