<?php
/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 * https://developer.mozilla.org/en-US/docs/Web/HTML/Element/audio
 */

use FriendsOfRedaxo\MFragment\Helper\FragmentOutputHelper;

$givenRowClass = $this->getVar('rowClass');
$givenRowAttributes = $this->getVar('rowAttributes');
$columns = $this->getVar('columns');
$colOutput = '';

$defaultColClass = [
    'class' => '',
    'margin' => '',
    'padding' => '',
];

foreach ($columns as $column) {
    $class = (!empty($column['colClass']) && is_array($column['colClass'])) ? ' class="'.implode(' ', $column['colClass']).'"' : '';
    $attributes = (!empty($fragmentPart['attributes']) && is_array($fragmentPart['attributes'])) ? ' ' . rex_string::buildAttributes($fragmentPart['attributes']) : '';
    if (!empty($column['content'])) {
        $colOutput .= '<div' . $class . $attributes . '>';
        if (is_array($column['content'])) {
            foreach ($column['content'] as $columnContent) {
                $colOutput .= FragmentOutputHelper::parseEachFragmentParts($columnContent);
            }
        } else if (is_string($column['content'])) {
            $colOutput .= $column['content'];
        }
        $colOutput .= '</div>';
    }
}

$rowClass = array_merge([
    'class' => 'row',
    'margin' => '',
    'padding' => '',
], (is_array($givenRowClass) ? $givenRowClass : []));
$class = (!empty($rowClass)) ? ' class="' . implode(' ', $rowClass) . '"' : '';
$attributes = (!empty($givenRowAttributes) && is_array($givenRowAttributes)) ? ' ' . rex_string::buildAttributes($givenRowAttributes) : '';

echo '
<div' . $class . $attributes . '>
    ' . $colOutput . '
</div>
';
