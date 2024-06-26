<?php
/**
 * @author Joachim Doerr
 * @package redaxo5
 * @license MIT
 */

namespace FriendsOfRedaxo\MFragment\DTO;

class MediaElement
{
    public string $mediaName;
    public string $mediaTitle;
    public string $mediaType;
    public string $mediaUrl;
    public \rex_media $rexMedia;
    public array $mediaConfig;

    public function __construct(string $mediaName, string $mediaTitle, string $mediaType, string $mediaUrl, \rex_media $rexMedia, array $mediaConfig = [])
    {
        $this->mediaName = $mediaName;
        $this->mediaTitle = $mediaTitle;
        $this->mediaType = $mediaType;
        $this->mediaUrl = $mediaUrl;
        $this->rexMedia = $rexMedia;
        $this->mediaConfig = $mediaConfig;
    }
}