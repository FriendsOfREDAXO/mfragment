<?php
/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 */

use FriendsOfRedaxo\MFragment\Core\MFragmentProcessor;
use FriendsOfRedaxo\MFragment\Helper\MFragmentHelper;

$config = $this->getVar('config', []);
$content = $this->getVar('content', '');

$showSection = $config['showSection'] ?? true;
$showContainer = $config['showContainer'] ?? true;
$darkLayout = $config['darkLayout'] ?? false;

$sectionConfig = $config['section'] ?? [];
$containerConfig = $config['container'] ?? [];

$sectionClass = $sectionConfig['attributes']['class'] ?? ['section-wrapper'];
$containerClass = $containerConfig['attributes']['class'] ?? ['container'];

$sectionAttributes = $sectionConfig['attributes'] ?? [];
$sectionAttributes['class'] = $sectionClass;

$containerAttributes = $containerConfig['attributes'] ?? [];
$containerAttributes['class'] = $containerClass;

$sectionContent = [];

if ($showContainer) {
    $containerContent = MFragmentHelper::createTag('div', $content, [
        'attributes' => $containerAttributes
    ]);
} else {
    $containerContent = $content;
}

if ($showSection) {
    $sectionContent = MFragmentHelper::createTag('section', $containerContent, [
        'attributes' => $sectionAttributes
    ]);
} else {
    $sectionContent = $containerContent;
}

$processor = new MFragmentProcessor();
echo $processor->process($sectionContent);
