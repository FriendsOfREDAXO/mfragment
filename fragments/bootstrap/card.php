<?php
/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 * https://developer.mozilla.org/en-US/docs/Web/HTML/Element/audio
 */

use FriendsOfRedaxo\MFragment\Helper\FragmentOutputHelper;

$showCardHeader = false;
$showCardBody = false;
$showCardFooter = false;

$givenCardClass = $this->getVar('cardClass');
$givenCardHeaderClass = $this->getVar('headerClass');
$givenCardBodyClass = $this->getVar('bodyClass');
$givenCardFooterClass = $this->getVar('footerClass');

$givenHeader = $this->getVar('header');
$givenBody = $this->getVar('content');
$givenFooter = $this->getVar('footer');

$headlineOutput = FragmentOutputHelper::parseEachFragmentParts($givenHeader);
$bodyOutput = FragmentOutputHelper::parseEachFragmentParts($givenBody);
$footerOutput = FragmentOutputHelper::parseEachFragmentParts($givenFooter);

$showCardHeader = (!empty($headlineOutput));
$showCardBody = (!empty($bodyOutput));
$showCardFooter = (!empty($footerOutput));

$cardClass = array_merge([
    'class' => 'card',
    'margin' => '',
    'padding' => '',
], (is_array($givenCardClass) ? $givenCardClass : []));
$cardHeaderClass = array_merge([
    'class' => 'card-header',
    'margin' => '',
    'padding' => '',
], (is_array($givenCardHeaderClass) ? $givenCardHeaderClass : []));
$cardBodyClass = array_merge([
    'class' => 'card-body',
    'margin' => '',
    'padding' => '',
], (is_array($givenCardBodyClass) ? $givenCardBodyClass : []));
$cardFooterClass = array_merge([
    'class' => 'card-footer',
    'margin' => '',
    'padding' => '',
], (is_array($givenCardFooterClass) ? $givenCardFooterClass: []));

?>
<div class="<?= implode(' ', $cardClass) ?>">
    <?php if ($showCardHeader): ?>
    <div class="<?= implode(' ', $cardHeaderClass) ?>">
        <?= $headlineOutput ?>
    </div>
    <?php endif; ?>
    <?php if ($showCardBody): ?>
    <div class="<?= implode(' ', $cardBodyClass) ?>">
        <?= $bodyOutput ?>
    </div>
    <?php endif; ?>
    <?php if ($showCardFooter): ?>
    <div class="<?= implode(' ', $cardFooterClass) ?>">
        <?= $footerOutput ?>
    </div>
    <?php endif; ?>
</div>