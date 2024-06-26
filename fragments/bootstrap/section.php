<?php
/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 * https://developer.mozilla.org/en-US/docs/Web/HTML/Element/audio
 */

use FriendsOfRedaxo\MFragment\Helper\FragmentOutputHelper;

$givenSectionClass = $this->getVar('sectionClass');
$givenContainerClass = $this->getVar('containerClass');
$givenSectionAttributes = $this->getVar('sectionAttributes');
$givenContainerAttributes = $this->getVar('containerAttributes');

$output = FragmentOutputHelper::eachFragmentParts($this->getVar('content'));
$darkLayout = $this->getVar('darkLayout', false);

$showSection = $this->getVar('showSection', true);
$showContainer = $this->getVar('showContainer', true);

$containerClass = array_merge([
    'container' => 'container-fluid',
], (is_array($givenContainerClass)) ? $givenContainerClass : []);
$sectionClass = array_merge([
], (is_array($givenSectionClass)) ? $givenSectionClass : []);
$sectionAttributes = (!empty($givenSectionAttributes) && is_array($givenSectionAttributes)) ? ' ' . rex_string::buildAttributes($givenSectionAttributes) : '';
$containerAttributes = (!empty($givenContainerAttributes) && is_array($givenContainerAttributes)) ? ' ' . rex_string::buildAttributes($givenContainerAttributes) : '';
?>
<?php if ($showSection): ?><section class="<?= implode(' ', $sectionClass) . (($darkLayout) ? ' inverted' : '') ?>"<?=$sectionAttributes?>><?php endif; ?>
    <?php if ($showContainer): ?><div class="<?= implode(' ', $containerClass) ?>"<?=$containerAttributes?>><?php endif; ?>
        <?= $output ?>
    <?php if ($showContainer): ?></div><?php endif; ?>
<?php if ($showSection): ?></section><?php endif; ?>
