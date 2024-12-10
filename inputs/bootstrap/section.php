<?php
/**
 * @author Joachim Doerr
 * @package redaxo5
 * @license MIT
 */

use FriendsOfRedaxo\MForm;
use FriendsOfRedaxo\MForm\Inputs\MFormInputsAbstract;
use FriendsOfRedaxo\MForm\Inputs\MFormInputsInterface;
use FriendsOfRedaxo\MFragment\Helper\MFragmentMFormInputsHelper;

class section extends MFormInputsAbstract implements MFormInputsInterface
{
    // default configuration for section elements
    protected array $config = [
        'id' => 'section',
        'fittingLabel' => 'Einpassung',
        'fittingDefaultValue' => 'box',
        'fitting' => [],
        'marginLabel' => 'Außenabstand',
        'marginDefaultValue' => 1,
        'margin' => [],
        'paddingLabel' => 'Innenabstand',
        'paddingDefaultValue' => 1,
        'padding' => [],
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
            'transparent' => 'Transparent',
        ],
        'configKeys' => ['bgImg', 'bgClass', 'fitting', 'margin', 'padding', 'border'],
        'bgImgLabel' => 'Hintergrund-Bild',
        'bgImgDefaultValue' => '',
        'bgImg' => false,
    ];

    public function __construct(MForm $mform, array $inputsConfig = [])
    {
        if (!isset($inputsConfig['fitting']) || ($inputsConfig['fitting'] !== false && !is_array($inputsConfig['fitting']))) {
            $inputsConfig['fitting'] = MFragmentMFormInputsHelper::getContainerTypeOptions('ContainerTextFluidIcon', ['smallBox' => 'Small Box', 'box' => 'Box', 'fluid' => 'Fluid'], '', 'Container ');
        }
        if (!isset($inputsConfig['margin']) || ($inputsConfig['margin'] !== false && !is_array($inputsConfig['margin']))) {
            $inputsConfig['margin'] = MFragmentMFormInputsHelper::getIconMarginOptions('DoubleContainerTextIcon', [0 => 'None', 1 => 'Small', 2 => 'Medium', 3 => 'Large'], ' Margin');
        }
        if (!isset($inputsConfig['padding']) || ($inputsConfig['padding'] !== false && !is_array($inputsConfig['padding']))) {
            $inputsConfig['padding'] = MFragmentMFormInputsHelper::getIconPaddingOptions('DoubleContainerTextIcon', [0 => 'None', 1 => 'Small', 2 => 'Medium', 3 => 'Large'], ' Padding');
        }

        parent::__construct(new MForm(), $inputsConfig);
    }

    public function generateInputsForm(): MForm
    {
        $id = (!empty($this->config['id'])) ? $this->config['id'] . '.' : '';

        return self::getConfigForm($id);
    }
}