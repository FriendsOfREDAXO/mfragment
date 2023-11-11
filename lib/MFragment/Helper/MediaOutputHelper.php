<?php
/**
 * @author Joachim Doerr
 * @package redaxo5
 * @license MIT
 */

namespace MFragment\Helper;

use rex;
use rex_managed_media;
use rex_media;
use rex_media_manager;
use rex_media_srcset;
use rex_path;
use rex_url;

class MediaOutputHelper {
    const MEDIA_REWRITE_DIR = 'images';

    public static function getManagedMediaFile($mediaFile, $mediaType, bool $getDataSrc = false, bool $getSrc = true): string
    {
        $file = $mediaFile;
        if ($mediaFile instanceof rex_media) {
            $file = $mediaFile->getFileName();
        }

        // TODO handle each file types !!!

        // TODO improve
        $mediaType = (empty($mediaType)) ? 'original' : $mediaType;
        $urlMediaTypeQueryParameter = 'rex_media_type=' . $mediaType .'&';
        $urlMediaTypePathString = (!empty($mediaType)) ? self::MEDIA_REWRITE_DIR . '/' . $mediaType . '/' : '';
        $urlMediaType = (\rex_addon::get('yrewrite')->isAvailable()) ? $urlMediaTypePathString : 'index.php?' . $urlMediaTypeQueryParameter . 'rex_media_file=';

        $tempUrl = rex_url::frontend() . $urlMediaType . $file;
        $url = ($getSrc) ? htmlspecialchars($tempUrl) : $tempUrl;

        if (rex::isBackend()) {
            $tempUrl = rex_url::backendController() . '?' . $urlMediaTypeQueryParameter . 'rex_media_file=' . $file;
            $url = ($getSrc) ? htmlspecialchars($tempUrl) : $tempUrl;
        } else if ($getDataSrc) {
            $srcSet = self::getMediaImgSrcSet($file, $mediaType, $getSrc);
            if ($srcSet != '') {
                return 'data-srcset="'.$srcSet.'"';
            } else {
                return 'data-src="'.$url.'"';
            }
        }

        if ($getSrc) {
            return 'src="'.$url.'"';
        }

        return $url;
    }

    public static function getSrcSet(string $mediaFile, string $mediaType): array
    {
        $srcSet = '';
        if($media = new rex_managed_media(rex_path::media($mediaFile))) {
            if($manager = new rex_media_manager($media)) {
                $effects = $manager->effectsFromType($mediaType);
                if (is_array($effects)) {
                    foreach ($effects as $effect) {
                        if ($effect['effect'] == 'srcset' && isset($effect['params']['srcset'])) {
                            $srcSet = $effect['params']['srcset'];
                        }
                    }
                }
            }
        }
        return array_filter(explode(',', $srcSet));
    }

    public static function getMediaImgSrcSet(string $mediaFile, string $mediaType, bool $getValidHtml = true): string
    {
        $srcSet = self::getSrcSet($mediaFile, $mediaType);
        if (count($srcSet) > 0 && class_exists('rex_media_srcset')) {
            $single_srcset = array();
            #$imgSrc = rex_media_srcset::generateMediaImageUrl($mediaType, $mediaFile);
            foreach ($srcSet as $key => $item) {
                if ($set = rex_media_srcset::getSingleSet($item)) {
                    #if ($key == 0) $imgSrc = rex_media_srcset::generateMediaImageUrl($mediaType . '__' . ((string)$set['image_width']), $mediaFile);
                    $tempUrl = rex_media_srcset::generateMediaImageUrl($mediaType . '__' . ((string)$set['image_width']), $mediaFile) . ' ' . ((string)$set['viewport_width']) . 'w';
                    $single_srcset[$key] = ($getValidHtml) ? htmlspecialchars($tempUrl) : $tempUrl;
                }
                unset($set);
            }
            return implode(', ', $single_srcset);
        }
        return '';
    }

    public static function getMediaUrlPath(rex_media $rexMedia, string $mediaType = null): ?string
    {
        // TODO set correct url path
        return $rexMedia->getUrl();
    }
}