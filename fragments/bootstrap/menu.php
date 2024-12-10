<?php
/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 */

use FriendsOfRedaxo\MFragment;

$config = $this->vars;
$items = [];
$count = 0;

$wrapperTag = $tag = 'div';
$wrapperClass = (!empty($config['class']['wrapper'])) ? $config['class']['wrapper'] : 'navbar-nav';
$wrapperAttributes = (!empty($config['attributes']['wrapper'])) ? rex_string::buildAttributes($config['attributes']['wrapper']) : '';
if (isset($config['type']) && ($config['type'] == 'list' || $config['type'] == 'ul')) {
    $wrapperTag = 'ul';
    $tag = 'li';
}

foreach ($this->getVar('items', []) as $item) {
    if (!is_array($item) ||
        // (isset($item['catId']) && $item['catId'] == \BSC\base::getYComAuthConfig('article_id_logout')) ||
        // bricht für alle elemente ab die visible false sind
        (isset($item['visible']) && $item['visible'] === false)
    ) continue;
    $items[] = $item;
}

?>
<!--begin::<?= ucfirst($wrapperTag) ?> wrapper-->
<<?=$wrapperTag?> class="<?=$wrapperClass?>" <?=$wrapperAttributes?>>
<?php
foreach ($items as $item):
    $count++;

    if (isset($item['fragment'])) {
        echo MFragment::parse($item['fragment'], $item);
        continue;
    }

    // url & name
    $url = (isset($item['url'])) ? $item['url'] : '#';
    $url = '#';
    $name = (isset($item['name'])) ? $item['name'] : '';
    if (empty($name)) $name = (isset($item['catName'])) ? $item['catName'] : $name;
    if (empty($name) && isset($item['catObject']) && $item['catObject'] instanceof rex_category) {
        $name = $item['catObject']->getValue('name');
    }

    // visible
    $showBullet = false;
    $showIcon = (isset($config['visible']['icon'])) ? $config['visible']['icon'] : false;
    $showArrow = false;

    // classes
    $linkClass = (isset($config['class']['link'])) ? $config['class']['link'] : 'nav-link-li';
    $itemClass = (isset($config['class']['item'])) ? $config['class']['item'] : 'nav-item-it';
    $textClass = (isset($config['class']['text'])) ? $config['class']['text'] : 'nav-text-te';

    // attributes
    $linkAttributes = (isset($item['attributes']['link'])) ? $item['attributes']['link'] : [];
    $itemAttributes = (isset($item['attributes']['item'])) ? $item['attributes']['item'] : [];
    $textAttributes = (isset($item['attributes']['text'])) ? $item['attributes']['text'] : [];

    if (isset($item['id'])) $itemAttributes['id'] = $item['id'];

    $childrenConfig = (!empty($config['childrenConfig'])) ? $config['childrenConfig'] : [];

    // add other in definition added child items
    if (isset($item['hasChildren']) && !empty($item['children'])) {

        $childrenConfig['items'] = $item['children'];

        $linkClass .= ((!empty($config['hasChild']['class']['link'])) ? ' ' . $config['hasChild']['class']['link'] : ' hasChild');
        $itemClass .= ((!empty($config['hasChild']['class']['item'])) ? ' ' . $config['hasChild']['class']['item'] : ' hasChild');
        $textClass .= ((!empty($config['hasChild']['class']['text'])) ? ' ' . $config['hasChild']['class']['text'] : '');

        if (isset($config['hasChild']['attributes']['link'])) $linkAttributes = array_merge($linkAttributes, $config['hasChild']['attributes']['link']);
        if (isset($config['hasChild']['attributes']['item'])) $itemAttributes = array_merge($itemAttributes, $config['hasChild']['attributes']['link']);
        if (isset($config['hasChild']['attributes']['text'])) $textAttributes = array_merge($textAttributes, $config['hasChild']['attributes']['text']);

        // overwrite each children by config navItems -> catId
//        if (isset($childrenConfig['navItems']) && is_array($childrenConfig['navItems'])) {
//            foreach ($childrenConfig['navItems'] as $navItem) {
//                if ($navItem['catId'] == $item['catId']) {
//                    $item = array_merge($item, $navItem);
//                }
//            }
//        }
//        if (!empty($item['childLegend'])) {
//            $legendConfig = [
//                'legend' => $item['childLegend'],
//                'showIcon' => false,
//                'showBullet' => false,
//            ];
//            if (!empty($item['childLegendClass'])) $legendConfig['legendClass'] = $item['childLegendClass'];
//            if (!empty($item['childLegendTextWrapperClass'])) $legendConfig['legendTextWrapperClass'] = $item['childLegendTextWrapperClass'];
//            $childrenConfig['items'] = array_merge([$legendConfig], $childrenConfig['items']);
//        }
//        if (!empty($childrenConfig['parentItemClass'])) $itemClass = $childrenConfig['parentItemClass'];
//        if (!empty($childrenConfig['parentItemAttributes'])) $attributes = $childrenConfig['parentItemAttributes'];
//        if (isset($childrenConfig['removeParentUrl']) && $childrenConfig['removeParentUrl'] === true) unset($item['url']);
//        if (!empty($childrenConfig['parentCurrentClass'])) $item['currentClass'] = $childrenConfig['parentCurrentClass'];
//        if (!empty($childrenConfig['parentActiveClass'])) $item['activeClass'] = $childrenConfig['parentActiveClass'];
//        if (!empty($childrenConfig['parentShowArrow'])) $item['showArrow'] = $childrenConfig['parentShowArrow'];
    }

    // first item classes
    if ($count == 1) {
        $linkClass .= ' ' . $this->getVar('firstChildLinkClass', 'first-link-child');
        $itemClass .= ' ' . $this->getVar('firstChildItemClass', 'first-child');
    }
    // last item classes
    if ($count == count($items)) {
        $linkClass .=  ' ' . $this->getVar('lastChildLinkClass', 'last-link-child');
        $itemClass .=  ' ' . $this->getVar('lastChildItemClass', 'last-child');
    }

    // classes
    if (isset($item['active']) && $item['active']) {
        $linkClass .= ((!empty($config['active']['class']['link'])) ? ' ' . $config['active']['class']['link'] : ' active');
        $itemClass .= ((!empty($config['active']['class']['item'])) ? ' ' . $config['active']['class']['item'] : ' active');
        $textClass .= ((!empty($config['active']['class']['text'])) ? ' ' . $config['active']['class']['text'] : '');

        if (isset($config['active']['attributes']['link'])) $linkAttributes = array_merge($linkAttributes, $config['active']['attributes']['link']);
        if (isset($config['active']['attributes']['item'])) $itemAttributes = array_merge($itemAttributes, $config['active']['attributes']['link']);
        if (isset($config['active']['attributes']['text'])) $textAttributes = array_merge($textAttributes, $config['active']['attributes']['text']);
    }
    if (isset($item['current']) && $item['current']) {
        $linkClass .= ((!empty($config['current']['class']['link'])) ? ' ' . $config['current']['class']['link'] : ' current');
        $itemClass .= ((!empty($config['current']['class']['item'])) ? ' ' . $config['current']['class']['item'] : ' current');
        $textClass .= ((!empty($config['current']['class']['text'])) ? ' ' . $config['current']['class']['text'] : '');

        if (isset($config['current']['attributes']['link'])) $linkAttributes = array_merge($linkAttributes, $config['current']['attributes']['link']);
        if (isset($config['current']['attributes']['item'])) $itemAttributes = array_merge($itemAttributes, $config['current']['attributes']['link']);
        if (isset($config['current']['attributes']['text'])) $textAttributes = array_merge($textAttributes, $config['current']['attributes']['text']);
    }

    // fix class JS count
    $linkClass .= ' ed0';
    $itemClass .= ' ed0';

//    // icon
//    $icon = (isset($item['icon'])) ? $item['icon'] : null;
//    $iconType = (isset($item['iconType'])) ? $icon['iconType'] : $this->getVar('iconType', 'outline'); // duotone
//    $showIcon = (isset($item['showIcon'])) ? $item['showIcon'] : $this->getVar('showIcon', true);
//    $showArrow = (isset($item['showArrow'])) ? $item['showArrow'] : $this->getVar('showArrow', false);
//    $showBullet = (isset($item['showBullet'])) ? $item['showBullet'] : $this->getVar('showBullet', false);
//    if (isset($item['catObject']) && $item['catObject'] instanceof rex_category && !empty($item['catObject']->getValue('cat_icon'))) {
//        $icon = $item['catObject']->getValue('cat_icon');
//    }
//
//    $iconWrapperClass = (!empty($item['iconWrapperClass'])) ? $item['iconWrapperClass'] : $this->getVar('iconWrapperClass', 'nav-icon');
//    $textWrapperClass = (!empty($item['textWrapperClass'])) ? $item['textWrapperClass'] : $this->getVar('textWrapperClass', 'nav-title');
//    $iconClass = ' ' . ((isset($item['iconClass'])) ? $item['iconClass'] : $this->getVar('iconClass', 'fs-2'));
//
    if (!empty($item['legend'])) {
        $name = $item['legend'];
//        $textWrapperClass = 'nav-content';
//        if (!empty($item['legendTextWrapperClass'])) $textWrapperClass = $item['legendTextWrapperClass'];
//        if (!empty($item['legendClass'])) $name = '<span class="' . $item['legendClass'] . '">' . $name . '</span>';
        unset($item['url']);
        $linkClass = '';
    }
//
//    if ($this->getVar('showLink', true) === false) {
//        unset($item['url']);
//    }
    ?>
    <!--begin::<?= ucfirst($tag) ?> item-->
    <<?= $tag ?> class="<?= $itemClass ?>" <?= rex_string::buildAttributes($itemAttributes) ?>>
    <?php if (isset($item['url'])) : ?>
        <a class="<?=$linkClass?>" href="<?= $item['url'] ?>" <?= rex_string::buildAttributes($linkAttributes) ?>>
    <?php elseif (!empty($linkClass)): ?><span class="<?= $linkClass ?>"><?php endif; ?>
    <?php if($showIcon && !$showBullet): /* ?>
    <span class="<?= $iconWrapperClass ?>">
                <i class="ki-<?= $iconType ?> ki-<?= $icon . $iconClass ?>"><?php if ($iconType === 'duotone'): ?><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span><span class="path7"></span><span class="path8"></span><span class="path9"></span><span class="path10"></span><?php endif; ?></i>
            </span>
<?php */ endif; ?>
    <?php if(!$showIcon && $showBullet): ?>
    <span class="menu-bullet">
                <span class="bullet bullet-dot"></span>
            </span>
<?php endif; ?>
    <span class="<?= $textClass ?>" <?= rex_string::buildAttributes($textAttributes) ?>><?= $name ?></span>
    <?php if($showArrow) : ?><span class="menu-arrow"></span><?php endif; ?>
    <?php if (isset($item['url'])) : ?></a><?php elseif (!empty($linkClass)): ?></span><?php endif; ?>
    <?php if(isset($childrenConfig['items'])) {
        echo MFragment::parse('bootstrap/menu', $childrenConfig);
    } ?>
    </<?= $tag ?>>
    <!--end::<?= ucfirst($tag) ?> item-->
<?php endforeach; ?>
</<?=$wrapperTag?>>
<!--end::<?= ucfirst($wrapperTag) ?> wrapper-->
