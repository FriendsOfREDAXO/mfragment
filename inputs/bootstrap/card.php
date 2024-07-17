<?php
/**
 * @author Joachim Doerr
 * @package redaxo5
 * @license MIT
 */

use FriendsOfRedaxo\MForm;
use FriendsOfRedaxo\MForm\Inputs\MFormInputsAbstract;
use FriendsOfRedaxo\MForm\Inputs\MFormInputsInterface;

class card extends MFormInputsAbstract implements MFormInputsInterface
{
    protected array $config = [
        'id' => 'card',
        'cke5LeadProfile' => 'main_light',
        'cke5TextProfile' => 'main_default',
        'headlineAttributes' => ['label' => 'Headline Titel', 'type' => 'text'],
        'leadAttributes' => ['label' => 'Leadtext'],
        'textAttributes' => ['label' => 'Fließtext'],
        'headline' => true,
        'lead' => true,
        'text' => true
    ];

    public function generateInputsForm(): MForm
    {
        $id = (!empty($this->config['id'])) ? $this->config['id'] . '.' : '';

        $mform = MForm::factory()
            ->setShowWrapper(false);

        if ($this->config['headline'] === true && (!empty($this->config['headlineAttributes']) && (!isset($this->config['headlineAttributes']['hide']) || !$this->config['headlineAttributes']['hide']))) {
            $addField = (isset($this->config['headlineAttributes']['type']) && $this->config['headlineAttributes']['type'] === 'text') ? 'addTextField' : 'addTextAreaField';
            // text oder textarea look at line 34
            // addTextAreaField
            // addTextField
            $mform->$addField($id . 'headline', $this->config['headlineAttributes']);
        }

        foreach (['cke5LeadProfile' => 'lead', 'cke5TextProfile' => 'text'] as $profile => $attributesKey) {
            if ($this->config[$attributesKey] === true) {
                if (isset($this->config[$attributesKey . 'Attributes']) && !is_array($this->config[$attributesKey . 'Attributes'])) $this->config[$attributesKey . 'Attributes'] = [];
                $addField = (isset($this->config[$profile]['type']) && $this->config[$profile]['type'] === 'text') ? 'addTextField' : 'addTextAreaField';
                if ($addField === 'addTextAreaField' && !empty($this->config[$profile])) {
                    $this->config[$attributesKey . 'Attributes']['data-lang'] =  \Cke5\Utils\Cke5Lang::getUserLang();
                    $this->config[$attributesKey . 'Attributes']['data-profile'] =  $this->config[$profile];
                    $this->config[$attributesKey . 'Attributes']['class'] =  ((!empty($this->config['class'])) ? $this->config['class'] : '') . ' cke5-editor';
                }
                if ($this->config[$attributesKey] === true) {
                    // text oder textarea look at line 44
                    // addTextAreaField
                    // addTextField
                    $mform->$addField($id . $attributesKey, $this->config[$attributesKey . 'Attributes']);
                }
            }
        }

        return $mform;
    }
}