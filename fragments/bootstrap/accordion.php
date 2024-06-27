<?php
/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 * https://developer.mozilla.org/en-US/docs/Web/HTML/Element/audio
 */

use FriendsOfRedaxo\MFragment\Helper\FragmentOutputHelper;

$showAccordionHeader = false;
$showAccordionBody = false;

$givenAccordionClass = $this->getVar('cardClass');
$givenAccordionItemClass = $this->getVar('itemClass');
$givenAccordionHeaderClass = $this->getVar('headerClass');
$givenAccordionHeaderTitleClass = $this->getVar('titleClass');
$givenAccordionCollapseClass = $this->getVar('collapseClass');
$givenAccordionBodyClass = $this->getVar('bodyClass');
$givenAccordion = $this->getVar('accordions');
$headingType = $this->getVar('headingType', 'h2');
$linkType = $this->getVar('linkType', 'button');

$accordionClass = array_merge([
    'class' => 'accordion',
    'border' => 'border-top border-bottom',
    'margin' => '',
    'padding' => '',
], (is_array($givenAccordionClass) ? $givenAccordionClass : []));
$accordionItemClass = array_merge([
    'class' => 'accordion-item',
    'margin' => '',
    'padding' => '',
], (is_array($givenAccordionItemClass) ? $givenAccordionItemClass : []));
$accordionHeaderClass = array_merge([
    'class' => 'accordion-header',
    'margin' => '',
    'padding' => '',
], (is_array($givenAccordionHeaderClass) ? $givenAccordionHeaderClass : []));
$accordionHeaderTitleClass = array_merge([
    'class' => 'accordion-button',
    'fs' => 'fs-3',
    'margin' => '',
    'padding' => '',
], (is_array($givenAccordionHeaderTitleClass) ? $givenAccordionHeaderTitleClass : []));
$accordionCollapseClass = array_merge([
    'class' => 'accordion-collapse',
    'collapse' => 'collapse',
    'margin' => '',
    'padding' => '',
], (is_array($givenAccordionCollapseClass) ? $givenAccordionCollapseClass : []));
$accordionBodyClass = array_merge([
    'class' => 'accordion-body',
    'margin' => '',
    'padding' => '',
], (is_array($givenAccordionBodyClass) ? $givenAccordionBodyClass : []));

if (rex::isBackend()) {
    $accordionClass['class'] = 'panel-group';
    $accordionClass['border'] = '';
    $accordionItemClass['class'] = 'panel panel-default';
    $accordionHeaderClass['class'] = 'panel-heading';
    $accordionHeaderTitleClass['class'] = 'panel-title';
    $accordionCollapseClass['class'] = 'panel-collapse';
    $accordionBodyClass['class'] = 'panel-body';
    $linkType = 'a';
    $headingType = 'div';
}

$uniqueKey = $this->getVar('uid', uniqid());
$accordion = '';
if (isset($givenAccordion) && is_array($givenAccordion) && count($givenAccordion) > 0) {
    foreach ($givenAccordion as $key => $accordionItem) {
        $collapsed = ($accordionItem['show'] !== "1") ? ' collapsed' : '';
        $collapse = ($accordionItem['show'] !== "1") ? '' : ' show';
        $key = $uniqueKey . '_' . $key;
        $attr = '';

        if (rex::isBackend()) {
            $collapse = ($accordionItem['show'] !== "1") ? '' : ' in';
            $attr = ' data-toggle="collapse" href="#collapse-REX_SLICE_ID-' . $key . '" data-parent="#accordion-REX_SLICE_ID-'.$uniqueKey.'"';
        }

        $accordion .= '
            <div class="'.implode(' ', $accordionItemClass).'">
                <'.$headingType.' class="'.implode(' ', $accordionHeaderClass).'" id="heading-REX_SLICE_ID-' . $key . '">
                    <'.$linkType.' class="'.implode(' ', $accordionHeaderTitleClass).' fs-3 ' . $collapsed . '" type="button" data-bs-toggle="collapse" '.$attr.'
                            data-bs-target="#collapse-REX_SLICE_ID-' . $key . '" aria-expanded="false" aria-controls="collapse-REX_SLICE_ID-' . $key . '">
                        ' . $accordionItem['header'] . '
                    </'.$linkType.'>
                </'.$headingType.'>
                <div id="collapse-REX_SLICE_ID-' . $key . '" class="'.implode(' ', $accordionCollapseClass).'  ' . $collapse . '" aria-labelledby="heading-REX_SLICE_ID-' . $key . '" data-bs-parent="#accordion-REX_SLICE_ID-'.$uniqueKey.'">
                    <div class="'.implode(' ', $accordionBodyClass).'">
                        ' . FragmentOutputHelper::parseEachFragmentParts($accordionItem['content']) . '
                    </div>
                </div>
            </div>';
    }

    echo  '<div class="'.implode(' ', $accordionClass).'" id="accordion-REX_SLICE_ID-'.$uniqueKey.'">' . $accordion . '</div>';
}

