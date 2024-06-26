<?php
/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 * https://developer.mozilla.org/en-US/docs/Web/HTML/Element/audio
 */

$givenLinks = $this->getVar('links');

if (isset($givenLinks) && is_array($givenLinks) && count($givenLinks) > 0) {
    foreach ($givenLinks as $key => $button) {

        if (!isset($button['attributes'])) {
            $button['attributes'] = [];
        }
        if (!isset($button['attributes']['class'])) {
            $button['attributes']['class'] = [];
        }

        if (!isset($button['label'])) {
            $button['label'] = '';
        }
        if (isset($button['hidden_label'])) {
            $button['label'] = '<span class="d-none">' . $button['hidden_label'] . '</span>';
        }

        $icon = isset($button['icon']) ? $button['icon'] : '';

        $tag = 'button';
        $href = '';
        if (isset($button['url'])) {
            $tag = 'a';
            $href = ' href="' . $button['url'] . '"';
        }
        echo '<' . $tag . $href . rex_string::buildAttributes($button['attributes']) . '>' . $icon . $button['label'] . '</' . $tag . '>';
    }
}