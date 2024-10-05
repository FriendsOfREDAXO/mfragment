<?php
/**
 * @author Joachim Doerr
 * @package redaxo5
 * @license MIT
 */

namespace FriendsOfRedaxo\MFragment\Helper;

use rex;
use rex_managed_media;
use rex_media;
use rex_media_manager;
use rex_media_srcset;
use rex_path;
use rex_url;

class MFragmentMediaHelper {
    const MEDIA_REWRITE_DIR = 'images';

    private static function getRexMedia(rex_media|string $mediaFile): ?rex_media
    {
        if (!$mediaFile instanceof rex_media) {
            return rex_media::get($mediaFile);
        }
        return $mediaFile;
    }

    public static function getManagedMediaImage(rex_media $media, $mediaType, bool $addDataSrc = true): array
    {
        $file = $media->getFileName();

        // TODO
        //  check file type image return false if not

        $mediaType = (empty($mediaType)) ? 'original' : $mediaType;
        $urlMediaTypeQueryParameter = 'rex_media_type=' . $mediaType .'&';
        $urlMediaTypePathString = (!empty($mediaType)) ? self::MEDIA_REWRITE_DIR . '/' . $mediaType . '/' : '';
        $urlMediaType = (\rex_addon::get('yrewrite')->isAvailable()) ? $urlMediaTypePathString : 'index.php?' . $urlMediaTypeQueryParameter . 'rex_media_file=';

        $image = array_merge(
            ['src' => rex_url::frontend() . $urlMediaType . $file],
            ['attributes' => self::getManagedMediaDimensions($media, $mediaType)]
        );

        if (rex::isBackend()) {
            $image['src'] = rex_url::backendController() . '?' . $urlMediaTypeQueryParameter . 'rex_media_file=' . $file;
        } else if ($addDataSrc) {
            $image['attributes']['data-src'] = $image['src'];
        }

        return $image;
    }

    public static function getManagedMediaDimensions(rex_media $media, $mediaType): ?array
    {
        $manager = rex_media_manager::create($mediaType, $media->getFileName());
        if($manager instanceof rex_media_manager) {
            $media = $manager->getMedia();
        }

        if ($media instanceof rex_media || $media instanceof rex_managed_media) {
            return [
                'width' => $media->getWidth(),
                'height' => $media->getHeight()
            ];
        }

        return null;
    }
}