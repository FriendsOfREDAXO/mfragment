<?php
/**
 * User: joachimdoerr
 * Date: 25.05.23
 * Time: 13:05
 */

namespace MFragment\DTO;

class MediaElement
{
    public string $mediaName;
    public string $mediaTitle;
    public string $mediaType;
    public string $mediaUrl;
    public \rex_media $rexMedia;
    public array $mediaConfig;

    /**
     * MediaElement constructor.
     * @param string $mediaName
     * @param string $mediaTitle
     * @param string $mediaType
     * @param string $mediaUrl
     * @param \rex_media $rexMedia
     * @param array $mediaConfig
     * @author Joachim Doerr
     */
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