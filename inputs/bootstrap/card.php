<?php

use Cke5\Utils\Cke5Lang;
use FriendsOfRedaxo\MForm;
use FriendsOfRedaxo\MForm\Inputs\MFormInputsAbstract;
use FriendsOfRedaxo\MForm\Inputs\MFormInputsInterface;

class card extends MFormInputsAbstract implements MFormInputsInterface
{
    protected array $config = [
        'id' => 'card',
        // card content headline
//        'headlineAttributes' => ['label' => 'Headline', 'type' => 'text'],
        'headline' => true,
        'cke5HeadlineProfile' => '',
        // card content leadtext
        'cke5LeadProfile' => 'light',
        'leadAttributes' => ['label' => 'Leadtext'],
        'lead' => true,
        // card content text
        'cke5TextProfile' => 'default',
        'textAttributes' => ['label' => 'Fließtext'],
        'text' => true,
        // card content buttons
        'buttons' => true,
        // header
        'header' => false,
        // header
        'image' => false,
        // card list
        'list' => false,
        // card footer
        'footer' => false,
        'config' => false,
        // settings die selben wie bei section
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

    public function generateInputsForm(): MForm
    {
        $id = (!empty($this->config['id'])) ? $this->config['id'] . '.' : '';

        $cardContentInputForm = MForm::factory()
            ->setShowWrapper(false);

//        if ($this->config['headline'] === true && (!empty($this->config['headlineAttributes']) && (!isset($this->config['headlineAttributes']['hide']) || !$this->config['headlineAttributes']['hide']))) {
//            $addField = (isset($this->config['headlineAttributes']['type']) && $this->config['headlineAttributes']['type'] === 'text') ? 'addTextField' : 'addTextAreaField';
//            // text oder textarea look at line 34
//            // addTextAreaField
//            // addTextField
//            $cardContentInputForm->$addField($id . 'headline', $this->config['headlineAttributes']);
//        }

        foreach (['cke5HeadlineProfile' => 'headline', 'cke5LeadProfile' => 'lead', 'cke5TextProfile' => 'text'] as $profile => $attributesKey) {
            if ($this->config[$attributesKey] === true) {
                if (isset($this->config[$attributesKey . 'Attributes']) && !is_array($this->config[$attributesKey . 'Attributes'])) $this->config[$attributesKey . 'Attributes'] = [];
                $addField = (isset($this->config[$profile.'Type']) && $this->config[$profile.'Type'] === 'text') ? 'addTextField' : 'addTextAreaField';
                if ($addField === 'addTextAreaField' && !empty($this->config[$profile])) {
                    $this->config[$attributesKey . 'Attributes']['data-lang'] =  Cke5Lang::getUserLang();
                    $this->config[$attributesKey . 'Attributes']['data-profile'] =  $this->config[$profile];
                    $this->config[$attributesKey . 'Attributes']['class'] =  ((!empty($this->config[$attributesKey . 'Attributes']['class'])) ? $this->config[$attributesKey . 'Attributes']['class'] : '') . ' cke5-editor';
                }
                if ($this->config[$attributesKey] === true) {
                    // text oder textarea look at line 44
                    // addTextAreaField
                    // addTextField
                    $defaultValue = (!empty($this->config[$attributesKey . 'DefaultValue'])) ? $this->config[$attributesKey . 'DefaultValue'] : null;
                    $cardContentInputForm->$addField($id . $attributesKey, $this->config[$attributesKey . 'Attributes'], $defaultValue);
                }
            }
        }

        if (isset($this->config['contentMForm']) && $this->config['contentMForm'] instanceof MForm) {
            $cardContentInputForm->addForm($this->config['contentMForm']);
        }

        $mform = MForm::factory();
        if ($this->config['config'] === false) {
            $mform->setShowWrapper(false);
            $mform = $cardContentInputForm;
        } else {
            $mform->addTabElement('<i class="fa fa-file-text" aria-hidden="true"></i> Inhalt', $cardContentInputForm, true);
        }

        if ($this->config['image'] !== false) {
            $mform->addTabElement('<i class="fa fa-image"></i> Bild', MForm::factory()->addAlertInfo('TODO<br>
                - [ ] medium auswahl<br>
                - [ ] image optionen<br>
                - [ ] image format<br>
                - [ ] image caption<br>
                - [ ] image link<br>
                - [ ] slider<br>
                - [ ] zitat<br>
                - [ ] lead<br>
                - [ ] top mform<br>
                '
            ));
        }

        if ($this->config['list'] !== false) {
            $mform->addTabElement('<i class="fa fa-list"></i> Liste', MForm::factory()->addAlertInfo('TODO<br>
                - [ ] Repeater List Items<br>
                - [ ] list mform<br>
                '
            ));
        }

        if ($this->config['footer'] !== false) {
            $mform->addTabElement('<i class="fa fa-square-o"></i> Footer', MForm::factory()->addAlertInfo('TODO<br>
                - [ ] Text und Link Buttons<br>
                - [ ] footer mform<br>
                '
            ));
        }

        if ($this->config['config'] && ($this->config['margin'] !== false || $this->config['padding'] !== false || $this->config['bgClass'] !== false || $this->config['bgImg'] !== false)) {
            $this->config['fitting'] = false;
            // TODO padding und margin icons für abstände der card contents
            $mform->addTabElement('<i class="fa fa-cog"></i> Einstellungen', MForm::factory()->addInputs($id.'cardConfig', 'bootstrap/section', $this->config), false, true);
        }

        return $mform;
    }
}