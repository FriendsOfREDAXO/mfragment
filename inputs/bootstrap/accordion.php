<?php
/**
 * @author Joachim Doerr
 * @package redaxo5
 * @license MIT
 */

use FriendsOfRedaxo\MForm;
use FriendsOfRedaxo\MForm\Inputs\MFormInputsAbstract;
use FriendsOfRedaxo\MForm\Inputs\MFormInputsInterface;

class accordion extends MFormInputsAbstract implements MFormInputsInterface
{
    protected array $config = [
        'id' => 'accordion',
        'cke5Profile' => 'main_default'
    ];
    public function generateInputsForm(): \FriendsOfRedaxo\MForm
    {
        $contentMForm = MForm::factory()->setShowWrapper(false);
        // TODO
//        $contentMForm->addTextField("header", ['full' => true, 'placeholder' => 'Accordion Titel']);
//        if (!empty($this->config['contentMForms'])) {
//            $this->addContentMForms($contentMForm, $this->config['contentMForms']);
//        } else {
            // add card
//
//        }

        return MForm::factory()
            ->setShowWrapper(false)
            ->addRepeaterElement($this->config['id'], MForm::factory()
                ->addFieldsetArea('Accordion-Element', MForm::factory()
                    ->addTextField("header", ['full' => true, 'placeholder' => 'Accordion Titel'])
                    ->addTextAreaField("text", ['full' => true, 'placeholder' => 'Fließtext Accordioninhalt', 'data-lang' => \Cke5\Utils\Cke5Lang::getUserLang(), 'data-profile' => $this->config['cke5Profile'], 'class' => 'cke5-editor'])
                    ->addToggleCheckboxField('show', [1 => 'Accordion-Element initial geöffnet'], ['full' => true])
                    , ['style' => 'margin-top:-20px!important;'])
                , false, true, ['btn_text' => 'Accordion hinzufügen', 'btn_class' => 'btn-default', 'confirm_delete_msg' => 'Accordion Element löschen?']
            );
    }
}