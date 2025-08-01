<?php
# path: src/addons/mfragment/inputs/default/media.php

use FriendsOfRedaxo\MForm;
use FriendsOfRedaxo\MForm\Inputs\MFormInputsAbstract;
use FriendsOfRedaxo\MForm\Inputs\MFormInputsInterface;

class media extends MFormInputsAbstract implements MFormInputsInterface
{
    protected array $config = [
        'id' => 1,
        'label' => '<i class="fa fa-file"></i> Bild',
        'preview' => '1',
        'descriptionLabel' => 'Beschreibung',
        'description' => true,
        'showTitleAndDescriptionDefaultValue' => 0,
        'setCustomTitleAndDescriptionDefaultValue' => 1,
        'lightboxDefaultValue' => 0,
        'lightbox' => true,
        'link' => true,
        'customLinkAttributes' => ['label' => 'Link', 'data-intern'=>'enable','data-extern'=>'enable','data-media'=>'disable','data-mailto'=>'disable','data-tel'=>'disable', 'data-extern-link-prefix' => 'https://www.']
    ];

    public function generateInputsForm(): MForm
    {
        $id = (!empty($this->config['id'])) ? $this->config['id'] . '.' : '';

        $mform = MForm::factory()->setShowWrapper(true)
            ->addMediaField($id.'media', ['label' => $this->config['label'], 'preview' => $this->config['preview']]);

        if ((!empty($this->config['description'])) && $this->config['description'] === true) {
            $mform->addInlineElement($this->config['descriptionLabel'], MForm::factory()
                ->addHtml('<div class="row"><div class="col-md-3">')
                ->addToggleCheckboxField($id.'showTitleAndDescription', [1 => 'Anzeige'], ['full' => true, 'data-toggle-item' => 'collapseTitleAndDescription'], $this->config['showTitleAndDescriptionDefaultValue'])
                ->addHtml('</div><div class="col-md-9">')
                ->addCollapseElement('', MForm::factory()
                    ->setShowWrapper(false)
                    ->addSelectField($id.'customTitleAndDescription', [
                        1 => 'Beschreibung aus Medienpool beziehen',
                        4 => 'Beschreibung aus Eingabe beziehen (optional, bei nicht Eingabe Bezug aus Medienpool)',
                    ], ['full' => true], 1, $this->config['setCustomTitleAndDescriptionDefaultValue'])
                    ->setToggleOptions([1 => 'null', 4 => 'customTitleAndDescription'])
                    ->addCollapseElement('',null, false, true, ['data-group-collapse-id' => 'null'])
                    ->addCollapseElement('', MForm::factory()
                        ->addTextField($id.'title', ['label' => 'Title', 'full' => true, 'placeholder' => 'Title (optional)'])
                        ->addTextAreaField($id.'description', ['label' => 'Beschreibung','full' => true, 'placeholder' => 'Beschreibung (optional)'])
                        ->addColumnElement(6, MForm::factory()
                            ->addTextField($id.'author', ['label' => 'Author', 'full' => true, 'placeholder' => 'Author (optional)'])
                        )
                        ->addColumnElement(6, MForm::factory()
                            ->addTextField($id.'copyright', ['label' => 'Copyright', 'full' => true, 'placeholder' => 'Copyright (optional)'])
                        )
                        , false, true, ['data-group-collapse-id' => 'customTitleAndDescription']
                    )
                    , false, true, ['data-group-collapse-id' => 'collapseTitleAndDescription'])
                ->addHtml('</div></div>')
            );
        }

        if ((!empty($this->config['lightbox'])) && $this->config['lightbox'] === true && (!empty($this->config['link'])) && $this->config['link'] === true) {
            $mform->addForm(MForm::factory()
                ->addRadioIconField($id.'linkOption', [
                    1 => ['icon' => 'fa fa-ban', 'label' => 'kein Link'],
                    2 => ['icon' => 'fa fa-search-plus', 'label' => 'Lightbox (vergrößern)'],
                    3 => ['icon' => 'fa fa-link', 'label' => 'Hyperlink (intern / extern)'],
                ], ['label' => 'Verlinkung'], 1)
                ->setToggleOptions([1 => '0null', 2 => '0null', 3 => 'customLink'])
                ->addCollapseElement('',null, false, true, ['data-group-collapse-id' => '0null'])
                ->addCollapseElement('', MForm::factory()
                    ->addCustomLinkField($id.'link', $this->config['customLinkAttributes'])
                    , false, true, ['data-group-collapse-id' => 'customLink']
                )
            );
        } else {
            if ((!empty($this->config['link'])) && $this->config['link'] === true) {
                $mform->addCustomLinkField($id.'link', $this->config['customLinkAttributes']);
            }
            if ((!empty($this->config['lightbox'])) && $this->config['lightbox'] === true) {
                $mform->addToggleCheckboxField($id.'linkOption', [1 => 'Bild in Lightbox anzeigen (vergrößern)'], ['Label' => 'Lightbox', 'data-toggle-item' => 'collapseTitleAndDescription'], $this->config['lightboxDefaultValue']);
            }
        }

        return $mform;
    }
}
