<?php

use Cke5\Utils\Cke5Lang;
use FriendsOfRedaxo\MForm;
use FriendsOfRedaxo\MForm\Inputs\MFormInputsAbstract;
use FriendsOfRedaxo\MForm\Inputs\MFormInputsInterface;

class accordion extends MFormInputsAbstract implements MFormInputsInterface
{
    protected array $config = [
        'id' => 'accordion',
        'cke5Profile' => 'default',
        'open' => false,
        'confirmDelete' => true,
        'btn_text' => 'Accordion hinzufügen',
        'btn_class' => 'btn-default',
        'confirm_delete_msg' => 'Accordion Element löschen?'
    ];
    public function generateInputsForm(): MForm
    {
        $contentMForm = MForm::factory()->setShowWrapper(false);
        $headlineAttributes = (!isset($this->config['headlineAttributes']) || !is_array($this->config['headlineAttributes'])) ? [] : $this->config['headlineAttributes'];
        $contentMForm->addTextField("header", array_merge(['full' => true, 'placeholder' => 'Accordion Titel'], $headlineAttributes));
        if (!empty($this->config['contentMForm']) && $this->config['contentMForm'] instanceof MForm) {
            $contentMForm->addForm($this->config['contentMForm']->setShowWrapper(false));
        } else {
            // add card
            $contentMForm->addTextAreaField("content", ['full' => true, 'placeholder' => 'Fließtext Accordioninhalt', 'data-lang' => Cke5Lang::getUserLang(), 'data-profile' => $this->config['cke5Profile'], 'class' => 'cke5-editor']);
        }

        $contentMForm->addToggleCheckboxField('show', [1 => 'Accordion-Element initial geöffnet'], ['full' => true]);

        return MForm::factory()
            ->setShowWrapper(false)
            ->addRepeaterElement(
                $this->config['id'],
                MForm::factory()->addFieldsetArea('Accordion-Element', $contentMForm, ['style' => 'margin-top:-20px!important;']),
                $this->config['open'],
                $this->config['confirmDelete'],
                ['btn_text' => $this->config['btn_text'], 'btn_class' => $this->config['btn_class'], 'confirm_delete_msg' => $this->config['confirm_delete_msg']]
            );
    }
}