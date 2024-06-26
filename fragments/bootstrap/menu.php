<?php $nav = $this->getVar('navigation'); ?>
<ul class="<?=$this->getVar('ulClass', 'navbar-nav justify-content-end')?>" <?=$this->getVar('ulAttributes', '')?>>
    <?php if (is_array($nav) && sizeof($nav) > 0):
        foreach ($nav as $item) :
            $catObj = rex_category::get($item['catId']);
            if ($catObj instanceof rex_category && str_contains($catObj->getValue('cat_menu_type'),'|'.$this->getVar('catMenuTypeId', 2).'|')) : ?>
                <li class="<?=$this->getVar('liClass', 'nav-item')?> <?=($item['hasChildren'])?'dropdown dropdown-hover':''?> <?=($item['active']||$item['current'])?'active':''?>" <?=$this->getVar('liAttributes', '')?>>
                    <?php
                    if ($item['hasChildren']):
                        $show = false;
                        ?>
                        <a class="nav-link d-lg-none pt-lg-1" id="n<?=$item['catId']?>" <?="href=\"#\" data-bs-toggle=\"dropdown\" aria-expanded=\"false\""?>><?=$item['catName']?></a>
                        <a class="nav-link d-none pt-lg-1 d-lg-block" id="n<?=$item['catId']?>" <?="href=\"{$item['url']}\""?>><?=$item['catName']?></a>
                        <?php
                        foreach ($item['children'] as $child):
                            $catChildObj = rex_category::get($child['catId']);
                            if (str_contains($catChildObj->getValue('cat_menu_type'),'|2|')) :
                                $show = true;
//                                echo MFragment::parse('bootstrap/menu', ['navigation' => $item['children'], 'ulClass' => 'dropdown-menu', 'ulAttributes' => 'aria-labelledby="n'.$item['catId'].'"']);
//                                break;
                            endif;
                        endforeach;
                        if ($show):  ?>
                            <ul class="dropdown-menu" aria-labelledby="n<?=$item['catId']?>">
                                <li class="d-lg-none"><a class="dropdown-item <?=($item['active']||$item['current'])?'active':''?>" href="<?=$item['url']?>"><?=$item['catName']?></a></li>
                                <?php foreach ($item['children'] as $child):
                                    $catChildObj = rex_category::get($child['catId']);
                                    if (str_contains($catChildObj->getValue('cat_menu_type'),'|2|')) : ?>
                                        <li>
                                            <a class="dropdown-item <?=($child['active']||$child['current'])?'active':''?>" href="<?=$child['url']?>"><?=$child['catName']?></a>
                                        </li>
                                    <?php endif;
                                endforeach; ?>
                            </ul>
                        <?php  endif;?>
                    <?php else: ?>
                        <a class="nav-link pt-lg-1" id="n<?=$item['catId']?>" <?="href=\"{$item['url']}\""?>><?=$item['catName']?></a>
                    <?php endif; ?>
                </li>
            <?php endif; endforeach; endif; ?>
</ul>