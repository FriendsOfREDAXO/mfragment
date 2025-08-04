<?php
# path: src/addons/mfragment/boot.php

/** @var rex_addon $this */

// Responsive Media Helper Funktionen laden (vollständiges System)
require_once rex_path::addon('mfragment', 'lib/responsive_media_helpers.php');

// Namespaces für externe Komponenten beim REDAXO-Autoloader registrieren
rex_extension::register('PACKAGES_INCLUDED', function() {
    // Komponenten-Registry initialisieren
    $components = [];

    // 1. Theme Components registrieren, wenn Theme-Addon installiert ist
    if (rex_addon::exists('theme') && rex_addon::get('theme')->isAvailable()) {
        $themeAddon = rex_addon::get('theme');

        // Theme-Komponenten gehören in den privaten Bereich (private/)
        $themePrivateDir = $themeAddon->getPath('private/components');

        // Fallback: wenn im privaten Bereich kein components-Verzeichnis existiert,
        // dann schaue direkt im Addon-Verzeichnis
        if (!is_dir($themePrivateDir)) {
            $themePrivateDir = $themeAddon->getPath('components');
        }

        if (is_dir($themePrivateDir)) {
            // Theme Komponenten Verzeichnis beim REDAXO Autoloader registrieren
            rex_autoload::addDirectory($themePrivateDir, 'Theme\\Components');

            // Komponenten scannen und registrieren
            $themeComponents = scanComponentsDirectory($themePrivateDir, 'Theme\\Components');
            $components = array_merge($components, $themeComponents);
        }
    }

    // 2. Addon components registrieren
    $addonComponentsDir = rex_path::addon('mfragment', 'components');
    if (is_dir($addonComponentsDir)) {
        // Addon Komponenten Verzeichnis beim REDAXO Autoloader registrieren
        rex_autoload::addDirectory($addonComponentsDir, 'FriendsOfRedaxo\\MFragment\\AddonComponents');

        // Komponenten scannen und registrieren
        $addonComponents = scanComponentsDirectory($addonComponentsDir, 'FriendsOfRedaxo\\MFragment\\AddonComponents');
        $components = array_merge($components, $addonComponents);
    }

    // 3. src/components registrieren
    $srcDir = rex_path::base('src/components');
    if (is_dir($srcDir)) {
        // src Komponenten Verzeichnis beim REDAXO Autoloader registrieren
        rex_autoload::addDirectory($srcDir, 'App\\Components');

        // Komponenten scannen und registrieren
        $srcComponents = scanComponentsDirectory($srcDir, 'App\\Components');
        $components = array_merge($components, $srcComponents);
    }

    // Komponenten-Registry im MFragment-Addon speichern
    if (!empty($components)) {
        rex_addon::get('mfragment')->setProperty('components', $components);
    }
}, rex_extension::LATE);

// Backend-spezifische Funktionen
if (rex::isBackend()) {
    // Debug-Seite für responsive Media Types (nur für Admins)
    if (rex::getUser() && rex::getUser()->isAdmin() && rex_request('debug_responsive', 'bool', false)) {
        echo "<div style='margin: 20px;'>";
        echo "<h2>MFragment Responsive Media Types Debug</h2>";
        debugResponsiveMediaTypes();
        echo "</div>";
    }
}

/**
 * Scannt ein Verzeichnis nach MFragmentComponents-Klassen
 *
 * @param string $directory Verzeichnis
 * @param string $namespace Namespace-Präfix
 * @return array Gefundene Komponenten mit Name => Klassenname
 */
if (!function_exists('scanComponentsDirectory')) {
    function scanComponentsDirectory($directory, $namespace) {
        $components = [];

        // PHP-Dateien im Verzeichnis suchen
        $files = glob($directory . '/*.php');
        foreach ($files as $file) {
            $className = $namespace . '\\' . pathinfo($file, PATHINFO_FILENAME);

            // Klasse laden und prüfen ob sie das Interface implementiert
            if (class_exists($className) &&
                in_array('FriendsOfRedaxo\MFragment\Components\ComponentInterface', class_implements($className))) {

                // Komponenten-Namen ermitteln
                if (method_exists($className, 'getName')) {
                    $name = $className::getName();
                    $components[$name] = $className;
                }
            }
        }

        // Unterverzeichnisse durchsuchen
        $dirs = glob($directory . '/*', GLOB_ONLYDIR);
        foreach ($dirs as $dir) {
            $subNamespace = $namespace . '\\' . basename($dir);
            $subComponents = scanComponentsDirectory($dir, $subNamespace);
            $components = array_merge($components, $subComponents);
        }

        return $components;
    }
}