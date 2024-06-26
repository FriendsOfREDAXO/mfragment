<?php
/**
 * @author Joachim Doerr
 * @package redaxo5
 * @license MIT
 */

namespace FriendsOfRedaxo\MFragment\Helper;

use FriendsOfRedaxo\MFragment\DTO\MediaElement;
use rex_media;

class FragmentVarHelper
{
    public static function mergeDefaultConfigVariables(array $defaultConfigVar, array $var): array
    {
        return array_merge($defaultConfigVar, $var);
    }

    public static function mergeHelp(array $defaultHelp, array $help, bool $overwriteConfigInfo = true): array
    {
        if (isset($defaultHelp['config']) && isset($help['config']) && $overwriteConfigInfo) {
            $defaultHelp['config'] = array_merge($defaultHelp['config'], $help['config']);
            unset($help['config']);
        }
        return array_merge($defaultHelp, $help);
    }

    public static function getRexMedia($media): ?rex_media
    {
        $rexMedia = null;
        if (is_string($media)) {
            $rexMedia = rex_media::get($media);
        }
        return $rexMedia;
    }

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
            } else {
                $media->mediaType = $media->rexMedia->getType();
            }
            // add mediaConfig
            if (count($media->mediaConfig) <= 0 && is_array($config)) {
                $media->mediaConfig = $config;
            }
            return $media;
        }
        return null;
    }

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

    public static function getMediaType($media): string
    {
        $media = self::getMediaElement($media, []);
        return $media->mediaType;
    }

    public static function isMediaVideo($media): bool {
        return (self::getMediaType($media) == 'video');
    }

    public static function isMediaImg($media): bool {
        return (self::getMediaType($media) == 'img');
    }
    public static function isMediaAudio($media): bool {
        return (self::getMediaType($media) == 'audio');
    }
}