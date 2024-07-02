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
        'headerAttributes' => ['label' => 'Headline Titel', 'type' => 'text'],
        'leadAttributes' => ['label' => 'Leadtext'],
        'textAttributes' => ['label' => 'Fließtext'],
        'header' => true,
        'lead' => true,
        'text' => true
    ];

    public function generateInputsForm(): MForm
    {
        $id = (!empty($this->config['id'])) ? $this->config['id'] . '.' : '';

        $mform = MForm::factory()
            ->setShowWrapper(false);

        if ($this->config['header'] === true && (!empty($this->config['headerAttributes']) && (!isset($this->config['headerAttributes']['hide']) || !$this->config['headerAttributes']['hide']))) {
            $addField = (isset($this->config['headerAttributes']['type']) && $this->config['headerAttributes']['type'] === 'text') ? 'addTextField' : 'addTextAreaField';
            // text oder textarea
            $mform->$addField($id . 'header', $this->config['headerAttributes']);
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
                    // text oder textarea
                    $mform->$addField($id . $attributesKey, $this->config[$attributesKey . 'Attributes']);
                }
            }
        }

        return $mform;
    }
}