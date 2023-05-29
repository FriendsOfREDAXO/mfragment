<?php
namespace MFragment;

use MFragment\DTO\MediaElement;
use rex;
use rex_managed_media;
use rex_media;
use rex_media_manager;
use rex_path;
use rex_url;

class MediaOutputHelper {

    const MEDIA_DIR = 'media';

    /**
     * @param $mediaFile
     * @param $mediaType
     * @param bool $getDataSrc
     * @param bool $getValidHtml
     * @return string
     * @author Joachim Doerr
     */
    public static function getManagedMediaFile($mediaFile, $mediaType, bool$getDataSrc = false, bool $getValidHtml = true): string
    {
        $file = $mediaFile;
        if ($mediaFile instanceof rex_media) {
            $file = $mediaFile->getFileName();
        }

        // TODO handle each file types !!!

        // TODO improve
        $mediaType = (empty($mediaType)) ? 'original' : $mediaType;
        $urlMediaTypeQueryParameter = 'rex_media_type=' . $mediaType .'&';
        $urlMediaTypePathString = (!empty($mediaType)) ? self::MEDIA_DIR : '';
        $urlMediaType = (\rex_addon::get('yrewrite')->isAvailable()) ? $urlMediaTypePathString : 'index.php?' . $urlMediaTypeQueryParameter . 'rex_media_file=';

        $tempUrl = rex_url::frontend() . $urlMediaType . $file;
        $url = ($getValidHtml) ? htmlspecialchars($tempUrl) : $tempUrl;

        if (rex::isBackend()) {
            $tempUrl = rex_url::backendController() . '?' . $urlMediaTypeQueryParameter . 'rex_media_file=' . $file;
            $url = ($getValidHtml) ? htmlspecialchars($tempUrl) : $tempUrl;
        } else if ($getDataSrc) {
            $srcSet = self::getMediaImgSrcSet($file, $mediaType, $getValidHtml);
            if ($srcSet != '') {
                return 'data-srcset="'.$srcSet.'"';
            } else {
                return 'data-src="'.$url.'"';
            }
        }

        if ($getValidHtml) {
            return 'src="'.$url.'"';
        }

        return $url;
    }

    /**
     * @param string $mediaFile
     * @param string $mediaType
     * @param bool $getValidHtml
     * @return string
     * @author Joachim Doerr
     */
    public static function getMediaImgSrcSet(string $mediaFile, string $mediaType, bool $getValidHtml = true): string
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

        if ($srcSet != '' && class_exists('rex_media_srcset')) {
            $items = explode(',', $srcSet);
            $single_srcset = array();
            #$imgSrc = rex_media_srcset::generateMediaImageUrl($mediaType, $mediaFile);
            foreach ($items as $key => $item) {
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

    /**
     * @param rex_media $rexMedia
     * @param string|null $mediaType
     * @return string|null
     * @author Joachim Doerr
     */
    public static function getMediaUrlPath(rex_media $rexMedia, string $mediaType = null): ?string
    {
        return $rexMedia->getUrl();
    }
}