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
$givenAccordionBodyClass = $this->getVar('bodyClass');
$givenAccordion = $this->getVar('accordions');

$accordionClass = array_merge([
    'class' => 'accordion',
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
$accordionBodyClass = array_merge([
    'class' => 'accordion-body',
    'margin' => '',
    'padding' => '',
], (is_array($givenAccordionBodyClass) ? $givenAccordionBodyClass : []));

$uniqueKey = $this->getVar('uid', uniqid());
$accordion = '';
if (isset($givenAccordion) && is_array($givenAccordion) && count($givenAccordion) > 0) {
    foreach ($givenAccordion as $key => $accordionItem) {
        $collapsed = ($accordionItem['show'] !== "1") ? ' collapsed' : '';
        $collapse = ($accordionItem['show'] !== "1") ? '' : ' show';
        $key = $uniqueKey . '_' . $key;
        $accordion .= '
                    <div class="'.implode(' ', $accordionItemClass).'">
                        <h2 class="'.implode(' ', $accordionHeaderClass).'" id="heading-REX_SLICE_ID-' . $key . '">
                            <button class="accordion-button fs-3' . $collapsed . '" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#collapse-REX_SLICE_ID-' . $key . '" aria-expanded="false" aria-controls="collapse-REX_SLICE_ID-' . $key . '">
                                ' . $accordionItem['header'] . '
                            </button>
                        </h2>
                        <div id="collapse-REX_SLICE_ID-' . $key . '" class="accordion-collapse collapse ' . $collapse . '" aria-labelledby="heading-REX_SLICE_ID-' . $key . '" data-bs-parent="#accordion-REX_SLICE_ID-'.$uniqueKey.'">
                            <div class="'.implode(' ', $accordionBodyClass).'">
                                ' . FragmentOutputHelper::eachFragmentParts($accordionItem['content']) . '
                            </div>
                        </div>
                    </div>';
    }

    echo  '<div class="accordion border-top border-bottom" id="accordion-REX_SLICE_ID-'.$uniqueKey.'">' . $accordion . '</div>';
}

