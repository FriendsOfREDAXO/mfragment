<?php
/**
 * @author Joachim Doerr
 * @package redaxo5
 * @license MIT
 */

use FriendsOfRedaxo\MForm;
use FriendsOfRedaxo\MForm\Inputs\MFormInputsAbstract;
use FriendsOfRedaxo\MForm\Inputs\MFormInputsInterface;

class buttons extends MFormInputsAbstract implements MFormInputsInterface
{
    protected array $config = [
        'id' => 'buttons',
        'customLinkAttributes' => ['full' => true, 'data-intern' => 'enable', 'data-extern' => 'enable', 'data-media' => 'enable', 'data-mailto' => 'enable', 'data-tel' => 'disable', 'data-extern-link-prefix' => 'https://www.']
    ];
    public function generateInputsForm(): MForm
    {
        return MForm::factory()
            ->setShowWrapper(false)
            ->addRepeaterElement($this->config['id'], MForm::factory()
                ->setShowWrapper(false)
                ->addFieldsetArea('Button-Element', MForm::factory()
                    ->addColumnElement('5', MForm::factory()
                        ->addTextField("text", ['full' => true, 'placeholder' => 'Button-Text (optional)'])
                        , ['style' => 'padding-right:0']
                    )
                    ->addColumnElement('7', MForm::factory()
                        ->addCustomLinkField("link", $this->config['customLinkAttributes'])

                        , ['style' => 'padding-left:0']
                    )
                    , ['style' => 'margin-top:-20px!important;'])
                , false, true, ['btn_text' => 'Buttons hinzufügen', 'btn_class' => 'btn-default', 'confirm_delete_msg' => 'Button löschen?']
            );
    }
}