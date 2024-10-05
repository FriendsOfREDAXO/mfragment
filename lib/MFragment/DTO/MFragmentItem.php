<?php
/**
 * User: joachimdoerr
 * Date: 04.10.24
 * Time: 14:01
 */

namespace FriendsOfRedaxo\MFragment\DTO;

use FriendsOfRedaxo\MFragment;

class MFragmentItem
{
    public string|bool $tag;
    public string|bool $fragment;
    public MFragment|array|string $content;
    public array $attributes = [];
    public array $config;

    /**
     * MFragmentItem constructor.
     * @param string|bool $tag
     * @param string|bool $fragment
     * @param array|MFragment|string $content
     * @param array $config
     * @author Joachim Doerr
     */
    public function __construct(string|bool $tag, string|bool $fragment, array|string|MFragment $content, array $config, array $attributes = [])
    {
        $this->tag = $tag;
        $this->fragment = $fragment;
        $this->content = $content;
        $this->attributes = $attributes;
        $this->config = $config;
    }
}