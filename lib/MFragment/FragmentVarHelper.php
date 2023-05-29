<?php
/**
 * User: joachimdoerr
 * Date: 14.05.23
 * Time: 12:47
 */

namespace MFragment;

use MFragment\DTO\MediaElement;
use rex_fragment;
use rex_media;
use rex_url;

class FragmentVarHelper
{
    /**
     * @param array $defaultConfigVar
     * @param array $var
     * @return array
     * @author Joachim Doerr
     */
    public static function mergeDefaultConfigVariables(array $defaultConfigVar, array $var): array
    {
        return array_merge($defaultConfigVar, $var);
    }

    /**
     * @param array $defaultHelp
     * @param array $help
     * @param bool $overwriteConfigInfo
     * @return array
     * @author Joachim Doerr
     */
    public static function mergeHelp(array $defaultHelp, array $help, bool $overwriteConfigInfo = true): array
    {
        if (isset($defaultHelp['config']) && isset($help['config']) && $overwriteConfigInfo) {
            $defaultHelp['config'] = array_merge($defaultHelp['config'], $help['config']);
            unset($help['config']);
        }
        return array_merge($defaultHelp, $help);
    }

    /**
     * @param $media
     * @return rex_media|null
     * @author Joachim Doerr
     */
    public static function getRexMedia($media): ?rex_media
    {
        $rexMedia = null;
        if (is_string($media)) {
            $rexMedia = rex_media::get($media);
        }
        return $rexMedia;
    }

    /**
     * @param $media
     * @param $config
     * @return MediaElement|null
     * @author Joachim Doerr
     */
    public static function getMediaElement($media, $config): ?MediaElement
    {
        if (is_string($media)) {
            // load media object
            $media = self::getRexMedia($media);
        }
        if ($media instanceof rex_media) {
            // create MediaElement
            $media = new MediaElement($media->getFileName(), $media->getTitle(), $media->getType(), $media->getUrl(), $media);
        }
        if ($media instanceof MediaElement) {
            // add mediaType
            if (str_contains($media->rexMedia->getType(), 'image')) {
                $media->mediaType = 'img';
            } else if (str_contains($media->rexMedia->getType(), 'video')) {
                $media->mediaType = 'video';
            } else if (str_contains($media->rexMedia->getType(), 'audio')) {
                $media->mediaType = 'audio';
            }
            // add mediaConfig
            if (count($media->mediaConfig) <= 0 && is_array($config)) {
                $media->mediaConfig = $config;
            }
            return $media;
        }
        return null;
    }

    /**
     * @param $media
     * @param $config
     * @return array|null
     * @author Joachim Doerr
     */
    public static function getMediaElementArray($media, $config): ?array
    {
        $mediaElements = [];
        if (!is_array($media)) {
            $mediaElements[] = self::getMediaElement($media, $config);
        } else if (count($media) > 0) {
            foreach ($media as $item) {
                $mediaElements[] = self::getMediaElement($item, $config);
            }
        }
        return $mediaElements;
    }
}