<?php
/**
 * @var rex_fragment $this
 * @psalm-scope-this rex_fragment
 */

use FriendsOfRedaxo\MFragment\Helper\MFragmentHelper;
use FriendsOfRedaxo\MFragment\Core\MFragmentProcessor;

$content = $this->getVar('content', []);
$config = $this->getVar('config', []);

$defaultConfig = [
    'wrapper' => [
        'tag' => 'div',
        'attributes' => ['class' => ['default' => 'button-group']]
    ],
    'button' => [
        'tag' => 'a',
        'attributes' => ['class' => ['default' => 'btn', 'primary' => 'btn-primary']]
    ]
];

$config = MFragmentHelper::mergeConfigs($defaultConfig, $config);

$buttons = [];

if (is_array($content) && count($content) > 0) {
    foreach ($content as $button) {
        if (!isset($button['text']) || !isset($button['link'])) {
            continue;
        }

        $url = $button['link']['id'];
        if (strpos($url, 'redaxo://') === 0) {
            $articleId = substr($url, 9);
            $article = rex_article::get($articleId);

            if ($article) {
                $url = $article->getUrl();
                $button['text'] = ((!empty($button['text'])) ? $button['text'] : $article->getName());
            } else {
                continue;
            }
        }

        $buttonConfig = MFragmentHelper::mergeConfigs($config['button'], $button['config'] ?? []);
        $buttonAttributes = array_merge($buttonConfig['attributes'], [
            'href' => $url,
            'title' => $button['title'] ?? $button['text']
        ]);

        $buttons[] = MFragmentHelper::createTag(
            $buttonConfig['tag'],
            $button['text'],
            ['attributes' => $buttonAttributes]
        );
    }
}

$buttonGroup = MFragmentHelper::createTag(
    $config['wrapper']['tag'],
    $buttons,
    ['attributes' => $config['wrapper']['attributes']]
);

$processor = new MFragmentProcessor();
echo $processor->process($buttonGroup);