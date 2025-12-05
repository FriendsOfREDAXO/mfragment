# MFragment - Structured HTML Generation for REDAXO

[![REDAXO Version](https://img.shields.io/badge/REDAXO-%3E%3D5.10-red.svg)](https://redaxo.org)
[![PHP Version](https://img.shields.io/badge/PHP-%3E%3D7.4-blue.svg)](https://php.net)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

> **Programmatic HTML Structures for Modern REDAXO Websites**

MFragment is a REDAXO addon for structured HTML generation with component-oriented architecture. It enables programmatic creation of HTML structures, responsive media management and Bootstrap 5 integration.

## Key Features

### **Structured HTML Generation**
- **Programmatic HTML Creation** - Create HTML structures with PHP code
- **Direct HTML Rendering** - No template engine required
- **Bootstrap 5 Integration** - Includes standard Bootstrap components
- **Method Chaining** - Fluent API design for improved developer experience

### **Create Custom Components**
- **Extensible Architecture** - Custom components through AbstractComponent inheritance
- **MFragment Integration** - All MFragment tools available
- **HTML Element Creation** - Create arbitrary HTML structures with MFragment methods
- **Modular Structure** - Components can be used in all contexts

### **HTML Structure Generation**
**As MForm is for forms, MFragment is for HTML structures** - create HTML layouts programmatically:

- **Complete HTML Coverage** - Generation of arbitrary HTML elements, attributes and structures
- **Nested Components** - Complex layouts with unlimited nesting depth
- **Dynamic Content Generation** - Generate HTML programmatically based on data
- **Layout Systems** - From simple divs to complex grid systems and components
- **Template Alternative** - Replace static templates with dynamic PHP structures

### **Responsive Media System**
- **360 Media Manager Types** - Complete responsive image system
- **4 Image Series** - `small`, `half`, `full`, `hero` for every use case
- **Automatic WebP Conversion** - 25-35% smaller files for better performance
- **Bootstrap 5 Breakpoints** - Perfect integration with modern grid systems
- **Hero Series** - Full-screen images up to 1920px for modern websites

### **Performance Characteristics**
- **Direct HTML Rendering** - No template engine required
- **Performance Monitoring** - Render times measurable
- **Database Query Optimization** - Request-local caching for Media Manager Types
- **Memory Efficient** - Low resource consumption

### **Developer Experience**
- **Documented APIs** - Well-documented interfaces with type hints
- **Debug Mode** - Detailed development information
- **IDE Support** - Complete type hints and documentation
- **Extensible** - Easy creation of custom components

## Installation

### Via REDAXO Installer
1. Go to **System → Packages**
2. Search for "MFragment"
3. Click **Install**

### Manual Installation
1. Download the latest version from [GitHub](https://github.com/FriendsOfREDAXO/mfragment)
2. Extract to `redaxo/src/addons/mfragment/`
3. Install via REDAXO backend

### Media Manager Types (Recommended)
Install the comprehensive responsive media system:

```sql
-- Import via REDAXO SQL Import
source install/responsive_complete_system.sql
```

This adds **360 responsive Media Manager types** with automatic WebP conversion.

## Quick Start

### Basic Component Usage

```php
<?php
use FriendsOfRedaxo\MFragment\Components\Bootstrap\Card;
use FriendsOfRedaxo\MFragment\Components\Default\Figure;

// Create a Bootstrap Card with responsive image
$card = Card::factory()
    ->setHeader('Welcome to MFragment')
    ->setBody('Build modern websites with component architecture.')
    ->setImage('hero-image.jpg', 'full_16x9')
    ->addClass('shadow-sm');

echo $card->show();
```

### Responsive Image Helper

```php
<?php
use FriendsOfRedaxo\MFragment\Components\Default\Figure;

// Generate responsive picture element
$responsiveImage = Figure::factory()
    ->setMedia('hero-background.jpg')
    ->setMediaManagerType('hero_16x9')  // Use Hero series for fullscreen
    ->enableAutoResponsive()
    ->addClass('hero-bg');

echo $responsiveImage->show();
```

### Advanced Component Examples

#### Hero Section with Card Grid

```php
<?php
use FriendsOfRedaxo\MFragment\Components\Bootstrap\Card;
use FriendsOfRedaxo\MFragment\Components\Bootstrap\Carousel;
use FriendsOfRedaxo\MFragment\Components\Default\Figure;
use FriendsOfRedaxo\MFragment;

// Hero carousel with responsive images
$heroCarousel = Carousel::factory('hero-carousel')
    ->addSlide(
        Figure::factory()
            ->setMedia('slide1.jpg')
            ->setMediaManagerType('hero_21x9')
            ->setCaption('Modern Web Development with MFragment')
            ->addClass('carousel-image')
    )
    ->addSlide(
        Figure::factory()
            ->setMedia('slide2.jpg')
            ->setMediaManagerType('hero_21x9')  
            ->setCaption('Responsive Design for All Devices')
    )
    ->setControls(true)
    ->setIndicators(true)
    ->setAutoplay(5000)
    ->addClass('hero-section');

// Service cards grid
$servicesGrid = MFragment::factory()
    ->addDiv(
        MFragment::factory()
            ->addDiv(
                Card::factory()
                    ->setImage('service-webdev.jpg', 'full_4x3')
                    ->setHeader('Web Development')
                    ->setBody('Modern websites with REDAXO and MFragment - performant, maintainable and future-proof.')
                    ->setFooter('
                        <a href="/services/webdev" class="btn btn-primary">Learn More</a>
                    ')
                    ->addClass('h-100'),
                ['class' => 'col-lg-4 mb-4']
            )
            ->addDiv(
                Card::factory()
                    ->setImage('service-design.jpg', 'full_4x3') 
                    ->setHeader('Responsive Design')
                    ->setBody('Optimal display on all devices - from smartphone to desktop.')
                    ->setFooter('
                        <a href="/services/design" class="btn btn-primary">View Portfolio</a>
                    ')
                    ->addClass('h-100'),
                ['class' => 'col-lg-4 mb-4']
            )
            ->addDiv(
                Card::factory()
                    ->setImage('service-support.jpg', 'full_4x3')
                    ->setHeader('Support & Maintenance')
                    ->setBody('Continuous support and updates for your REDAXO installation.')
                    ->setFooter('
                        <a href="/services/support" class="btn btn-primary">Contact</a>
                    ')
                    ->addClass('h-100'),
                ['class' => 'col-lg-4 mb-4']
            ),
        ['class' => 'row']
    );

// Complete page section assembly
$heroSection = MFragment::factory()
    ->addDiv($heroCarousel, ['class' => 'hero-wrapper mb-5'])
    ->addDiv(
        MFragment::factory()
            ->addHeading(2, 'Our Services', ['class' => 'text-center mb-5'])
            ->addFragment($servicesGrid),
        ['class' => 'container']
    );

echo $heroSection->show();
```

#### Interactive FAQ Section with Accordion

```php
<?php
use FriendsOfRedaxo\MFragment\Components\Bootstrap\Accordion;
use FriendsOfRedaxo\MFragment;

$faqData = [
    [
        'question' => 'What is MFragment and why should I use it?',
        'answer' => 'MFragment is a REDAXO addon for structured HTML generation. It enables programmatic creation of HTML elements with component-oriented architecture, similar to how MForm works for forms.',
    ],
    [
        'question' => 'How does MFragment differ from regular templates?',
        'answer' => 'Instead of static templates, MFragment enables dynamic HTML generation directly in PHP. This allows you to create complex layouts programmatically, conditionally include content, and develop reusable components.',
    ],
    [
        'question' => 'What benefits does the responsive media system offer?',
        'answer' => 'The media system provides 360 predefined Media Manager types with automatic WebP conversion. It supports 4 image series (small, half, full, hero) and various aspect ratios for optimal performance on all devices.',
    ]
];

$faqAccordion = Accordion::factory('faq-accordion');
foreach ($faqData as $index => $item) {
    $faqAccordion->addItem(
        $item['question'],
        MFragment::factory()
            ->addParagraph($item['answer'])
            ->addDiv(
                '<small class="text-muted">More questions? <a href="/contact">Contact us</a></small>',
                ['class' => 'mt-3']
            )
    );
}

$faqSection = MFragment::factory()
    ->addDiv(
        MFragment::factory()
            ->addHeading(2, 'Frequently Asked Questions', ['class' => 'text-center mb-5'])
            ->addDiv($faqAccordion, ['class' => 'col-lg-8 mx-auto']),
        ['class' => 'container py-5']
    );

echo $faqSection->show();
```

## Available Components

### Bootstrap 5 Components
- **Card** - Content cards with images, headers and actions
- **Carousel** - Image and content sliders
- **Modal** - Overlay dialogs and lightboxes
- **Accordion** - Collapsible content sections
- **Tabs** - Tab navigation for content
- **Alert** - Notifications and messages
- **Badge** - Status indicators and labels
- **Progress** - Progress bars and loading indicators
- **Collapse** - Expandable content areas

### Default Components
- **Figure** - Images with captions and responsive behavior
- **HTMLElement** - Generic HTML elements with attribute management
- **ListElement** - Ordered and unordered lists
- **Table** - Data tables with responsive features

## Responsive Media System

### Image Series Overview

| Series | Breakpoints | Usage | Examples |
|--------|-------------|--------|----------|
| **small** | 320-768px | Thumbnails, Icons | Avatars, small previews |
| **half** | 320-1400px | Content images | Article images, galleries |
| **full** | 320-1400px | Large content | Hero areas, main images |
| **hero** | 768-1920px | Fullscreen areas | Headers, landing pages |

### Supported Aspect Ratios
- **1:1** - Square images (avatars, thumbnails)
- **4:3** - Standard photos (content images)
- **16:9** - Video format (hero areas, media)
- **21:9** - Cinema format (fullscreen headers)
- **3:2** - Photography standard
- **5:2** - Wide banners

### Usage Examples

```php
// Hero header with video aspect ratio
rex_media_manager::getUrl('hero_16x9_max_1920', 'header-bg.jpg')

// Content image for articles
rex_media_manager::getUrl('half_4x3_768', 'article-image.jpg')

// Small thumbnail
rex_media_manager::getUrl('small_1x1_320', 'avatar.jpg')

// Fullscreen cinema format
rex_media_manager::getUrl('hero_21x9_max_1920', 'cinema-bg.jpg')
```

## Creating Custom Components

### Basic Principle

MFragment allows you to create **arbitrary HTML structures** using the built-in tools. You can develop custom components that integrate seamlessly into the system and use all MFragment features.

### Simple Custom Component

```php
<?php
namespace App\Components;

use FriendsOfRedaxo\MFragment\Components\AbstractComponent;
use FriendsOfRedaxo\MFragment;

/**
 * Testimonial component for customer reviews
 */
class Testimonial extends AbstractComponent
{
    private string $quote = '';
    private string $author = '';
    private string $position = '';
    private string $company = '';
    private string $avatar = '';
    private int $rating = 5;

    public function setQuote(string $quote): self
    {
        $this->quote = $quote;
        return $this;
    }

    public function setAuthor(string $author): self
    {
        $this->author = $author;
        return $this;
    }

    public function setPosition(string $position): self
    {
        $this->position = $position;
        return $this;
    }

    public function setCompany(string $company): self
    {
        $this->company = $company;
        return $this;
    }

    public function setAvatar(string $avatar): self
    {
        $this->avatar = $avatar;
        return $this;
    }

    public function setRating(int $rating): self
    {
        $this->rating = max(1, min(5, $rating));
        return $this;
    }

    protected function renderHtml(): string
    {
        // Avatar image with responsive Media Manager
        $avatarImg = '';
        if ($this->avatar) {
            $avatarImg = '<img src="' . rex_media_manager::getUrl('small_1x1_160', $this->avatar) . '" 
                              alt="' . htmlspecialchars($this->author) . '" 
                              class="testimonial-avatar rounded-circle">';
        }

        // Generate star rating
        $stars = '';
        for ($i = 1; $i <= 5; $i++) {
            $starClass = $i <= $this->rating ? 'star-filled' : 'star-empty';
            $stars .= '<i class="star ' . $starClass . '">★</i>';
        }

        $attributesStr = $this->buildAttributesString();

        return '
        <div class="testimonial' . ($this->hasClass('testimonial') ? '' : ' testimonial') . '"' . $attributesStr . '>
            <div class="testimonial-content">
                <blockquote class="testimonial-quote">
                    "' . htmlspecialchars($this->quote) . '"
                </blockquote>
                <div class="testimonial-rating">' . $stars . '</div>
            </div>
            <div class="testimonial-author">
                ' . $avatarImg . '
                <div class="author-info">
                    <h4 class="author-name">' . htmlspecialchars($this->author) . '</h4>
                    ' . ($this->position ? '<p class="author-position">' . htmlspecialchars($this->position) . '</p>' : '') . '
                    ' . ($this->company ? '<p class="author-company">' . htmlspecialchars($this->company) . '</p>' : '') . '
                </div>
            </div>
        </div>';
    }
}

// Using the Testimonial component
$testimonial = Testimonial::factory()
    ->setQuote('MFragment reduced our development time by 40% and significantly improved code quality.')
    ->setAuthor('Maria Miller')
    ->setPosition('Lead Developer')
    ->setCompany('Digital Innovations Ltd')
    ->setAvatar('maria-miller.jpg')
    ->setRating(5)
    ->addClass('featured-testimonial shadow-lg');

echo $testimonial->show();
```

### Advanced Component with Nested Elements

```php
<?php
namespace App\Components;

use FriendsOfRedaxo\MFragment\Components\AbstractComponent;
use FriendsOfRedaxo\MFragment\Components\Bootstrap\Badge;
use FriendsOfRedaxo\MFragment\Components\Default\Figure;

/**
 * Product card for e-commerce with complex structure
 */
class ProductCard extends AbstractComponent
{
    private string $title = '';
    private string $description = '';
    private float $price = 0.0;
    private float $oldPrice = 0.0;
    private string $image = '';
    private array $badges = [];
    private array $features = [];
    private bool $inStock = true;
    private string $ctaText = 'Add to Cart';

    public function setTitle(string $title): self
    {
        $this->title = $title;
        return $this;
    }

    public function setDescription(string $description): self
    {
        $this->description = $description;
        return $this;
    }

    public function setPrice(float $price): self
    {
        $this->price = $price;
        return $this;
    }

    public function setOldPrice(float $oldPrice): self
    {
        $this->oldPrice = $oldPrice;
        return $this;
    }

    public function setImage(string $image): self
    {
        $this->image = $image;
        return $this;
    }

    public function addBadge(string $text, string $type = 'primary'): self
    {
        $this->badges[] = ['text' => $text, 'type' => $type];
        return $this;
    }

    public function addFeature(string $feature): self
    {
        $this->features[] = $feature;
        return $this;
    }

    public function setInStock(bool $inStock): self
    {
        $this->inStock = $inStock;
        return $this;
    }

    public function setCtaText(string $ctaText): self
    {
        $this->ctaText = $ctaText;
        return $this;
    }

    protected function renderHtml(): string
    {
        // Product image with lazy loading
        $productImage = '';
        if ($this->image) {
            $productImage = Figure::factory()
                ->setMedia($this->image)
                ->setMediaManagerType('full_4x3')
                ->setAlt($this->title)
                ->addClass('product-image w-100')
                ->show();
        }

        // Render badges
        $badgesHtml = '';
        foreach ($this->badges as $badge) {
            $badgesHtml .= Badge::factory()
                ->setText($badge['text'])
                ->setType($badge['type'])
                ->addClass('me-1 mb-1')
                ->show();
        }

        // Features list
        $featuresHtml = '';
        if (!empty($this->features)) {
            $features = '';
            foreach ($this->features as $feature) {
                $features .= '<li>' . htmlspecialchars($feature) . '</li>';
            }
            $featuresHtml = '<ul class="product-features list-unstyled small text-muted">' . $features . '</ul>';
        }

        // Price section
        $priceHtml = '';
        if ($this->oldPrice > $this->price) {
            $discount = round((($this->oldPrice - $this->price) / $this->oldPrice) * 100);
            $priceHtml = '
                <div class="price-wrapper">
                    <span class="current-price text-success fw-bold">$' . number_format($this->price, 2) . '</span>
                    <span class="old-price text-muted text-decoration-line-through ms-2">$' . number_format($this->oldPrice, 2) . '</span>
                    <span class="discount-badge badge bg-danger ms-2">-' . $discount . '%</span>
                </div>';
        } else {
            $priceHtml = '<div class="price text-success fw-bold">$' . number_format($this->price, 2) . '</div>';
        }

        // CTA button
        $ctaButton = '';
        if ($this->inStock) {
            $ctaButton = '<button type="button" class="btn btn-primary w-100">' . htmlspecialchars($this->ctaText) . '</button>';
        } else {
            $ctaButton = '<button type="button" class="btn btn-outline-secondary w-100" disabled>Out of Stock</button>';
        }

        $attributesStr = $this->buildAttributesString();

        return '
        <div class="product-card card h-100' . ($this->inStock ? '' : ' out-of-stock') . '"' . $attributesStr . '>
            <div class="position-relative">
                ' . $productImage . '
                ' . ($badgesHtml ? '<div class="product-badges position-absolute top-0 start-0 m-2">' . $badgesHtml . '</div>' : '') . '
            </div>
            <div class="card-body d-flex flex-column">
                <h5 class="card-title">' . htmlspecialchars($this->title) . '</h5>
                <p class="card-text flex-grow-1">' . htmlspecialchars($this->description) . '</p>
                ' . $featuresHtml . '
                <div class="mt-auto">
                    ' . $priceHtml . '
                    <div class="mt-3">
                        ' . $ctaButton . '
                    </div>
                </div>
            </div>
        </div>';
    }
}

// Using the ProductCard component
$product = ProductCard::factory()
    ->setTitle('MacBook Pro 16" M3 Max')
    ->setDescription('Professional laptop for creative workflows and development.')
    ->setPrice(2799.00)
    ->setOldPrice(2999.00)
    ->setImage('macbook-pro-16.jpg')
    ->addBadge('New', 'success')
    ->addBadge('Bestseller', 'warning')
    ->addFeature('M3 Max Chip')
    ->addFeature('32GB RAM')
    ->addFeature('1TB SSD')
    ->addFeature('Retina Display')
    ->setInStock(true)
    ->addClass('product-featured shadow-sm')
    ->setAttribute('data-product-id', '12345');

echo $product->show();
```

### Integrating Custom Components

Custom components can be easily combined with standard MFragment elements:

```php
<?php
use FriendsOfRedaxo\MFragment;
use FriendsOfRedaxo\MFragment\Components\Bootstrap\Card;

// Combine custom components with standard components
$productGrid = MFragment::factory()
    ->addDiv(
        MFragment::factory()
            ->addDiv(
                ProductCard::factory()
                    ->setTitle('Gaming Setup')
                    ->setDescription('Complete gaming setup for professionals')
                    ->setPrice(1899.00)
                    ->setImage('gaming-setup.jpg')
                    ->addBadge('Gaming', 'danger')
                    ->setInStock(true),
                ['class' => 'col-lg-4 mb-4']
            )
            ->addDiv(
                Card::factory()
                    ->setHeader('Service Package')
                    ->setBody('Installation and 2-year warranty included')
                    ->setFooter('<a href="/service" class="btn btn-outline-primary">More Info</a>')
                    ->addClass('h-100'),
                ['class' => 'col-lg-4 mb-4']
            )
            ->addDiv(
                Testimonial::factory()
                    ->setQuote('Outstanding quality and great service!')
                    ->setAuthor('Peter Smith')
                    ->setRating(5)
                    ->setAvatar('peter.jpg'),
                ['class' => 'col-lg-4 mb-4']
            ),
        ['class' => 'row']
    );

echo $productGrid->show();
```
## Building HTML Structures

**MFragment is for HTML what MForm is for forms** - create HTML layouts programmatically:

### Complex Layout Example
```php
// Create a complete article layout
$article = MFragment::factory()
    ->addDiv(
        MFragment::factory()
            ->addHeading(1, 'Article Title', ['class' => 'display-4'])
            ->addParagraph('Published on ' . date('F j, Y'), ['class' => 'text-muted'])
            ->addClass('article-header'),
        ['class' => 'container mb-4']
    )
    ->addDiv(
        MFragment::factory()
            ->addDiv(
                MFragment::factory()
                    ->addParagraph('Article introduction...')
                    ->addImage('/media/hero-image.jpg', 'Hero Image', ['class' => 'img-fluid rounded'])
                    ->addParagraph('Main article content...'),
                ['class' => 'col-lg-8']
            )
            ->addDiv(
                MFragment::factory()
                    ->addHeading(3, 'Related Articles')
                    ->addList(['Article 1', 'Article 2', 'Article 3'], 'ul', ['class' => 'list-unstyled'])
                    ->addButton('Subscribe', 'button', ['class' => 'btn btn-primary']),
                ['class' => 'col-lg-4']
            ),
        ['class' => 'container']
    );

echo $article->show();
```

### Dynamic Navigation Menu
```php
// Create navigation from database data
$navigation = MFragment::factory()->addClass('navbar-nav');

foreach ($menuItems as $item) {
    $link = MFragment::factory()
        ->addLink($item['title'], $item['url'], [
            'class' => 'nav-link' . ($item['active'] ? ' active' : ''),
            'aria-current' => $item['active'] ? 'page' : null
        ]);
    
    $navigation->addDiv($link, ['class' => 'nav-item']);
}

echo $navigation->show();
```

### Form with Validation Display
```php
// Complex form structure with dynamic error handling
$form = MFragment::factory()
    ->addTagElement('form', 
        MFragment::factory()
            ->addDiv(
                MFragment::factory()
                    ->addTagElement('label', 'Email Address', ['for' => 'email', 'class' => 'form-label'])
                    ->addTagElement('input', null, [
                        'type' => 'email',
                        'class' => 'form-control' . ($hasEmailError ? ' is-invalid' : ''),
                        'id' => 'email',
                        'name' => 'email'
                    ])
                    ->addDiv($emailError ?? '', ['class' => 'invalid-feedback']),
                ['class' => 'mb-3']
            )
            ->addDiv(
                MFragment::factory()
                    ->addButton('Submit', 'submit', ['class' => 'btn btn-primary'])
                    ->addButton('Cancel', 'button', ['class' => 'btn btn-secondary ms-2']),
                ['class' => 'd-flex justify-content-end']
            ),
        ['method' => 'post', 'action' => '/submit']
    );

echo $form->show();
```

### Data-Driven Component Lists
```php
// Generate structures based on data
$productGrid = MFragment::factory()->addClass('row g-4');

foreach ($products as $product) {
    $card = MFragment::factory()
        ->addDiv(
            MFragment::factory()
                ->addDiv(
                    MFragment::factory()
                        ->addImage($product['image'], $product['title'], ['class' => 'card-img-top'])
                        ->addDiv(
                            MFragment::factory()
                                ->addHeading(5, $product['title'], ['class' => 'card-title'])
                                ->addParagraph($product['description'], ['class' => 'card-text'])
                                ->addDiv(
                                    MFragment::factory()
                                        ->addSpan($product['price'], ['class' => 'h5 text-primary'])
                                        ->addButton('Add to Cart', 'button', [
                                            'class' => 'btn btn-outline-primary btn-sm ms-2',
                                            'data-product-id' => $product['id']
                                        ]),
                                    ['class' => 'd-flex justify-content-between align-items-center']
                                ),
                            ['class' => 'card-body']
                        ),
                    ['class' => 'card h-100']
                ),
            ['class' => 'col-md-6 col-lg-4']
        );
    
    $productGrid->addComponent($card);
}

echo $productGrid->show();
```

### API Reference

All components inherit these methods:

### Base Methods for All Components

All components inherit these methods:

```php
// Attribute Management
->setAttribute(string $name, mixed $value)
->addClass(string $class)
->setId(string $id)
->setData(string $key, mixed $value)

// Content Management  
->setContent(string $content)
->appendContent(string $content)
->prependContent(string $content)

// Rendering
->show(): string
->__toString(): string
```

### Responsive Image Helpers

```php
// Generate srcset for responsive images
generateSrcset(string $mediaFile, string $baseType): string

// Generate sizes attribute
generateSizesForType(string $baseType): string

// Generate complete picture element
generateResponsivePicture(string $mediaFile, array $options): string
```

## Advanced Configuration

### Creating and Placing Custom Components

MFragment offers several ways to organize custom components:

#### 1. Project Components (Recommended)
**Directory:** `src/components/`  
**Namespace:** Free choice (e.g., `App\Components\`, `MyProject\Components\`)

```
src/components/
├── Cards/
│   ├── ProductCard.php      -> App\Components\Cards\ProductCard
│   └── NewsCard.php         -> MyProject\Components\Cards\NewsCard
├── Navigation/
│   ├── MainMenu.php         -> App\Components\Navigation\MainMenu
│   └── Breadcrumb.php       -> YourNamespace\Components\Navigation\Breadcrumb
└── Layout/
    ├── Hero.php             -> App\Components\Layout\Hero
    └── Footer.php           -> CustomNamespace\Components\Layout\Footer
```

#### 2. Theme Components (with Theme Addon)
**Directory:** `src/addons/theme/components/` or `src/addons/theme/private/components/`  
**Namespace:** Free choice (e.g., `Theme\Components\`, `MyTheme\Components\`)

```
src/addons/theme/components/
├── Sections/
│   └── HeroSection.php      -> Theme\Components\Sections\HeroSection
└── Widgets/
    └── ContactWidget.php    -> MyTheme\Components\Widgets\ContactWidget
```

#### 3. Addon Components (for Addon Developers)
**Directory:** `src/addons/{addon_name}/components/`  
**Namespace:** Free choice according to your addon namespace

```
src/addons/myproject/components/
├── Custom/
│   └── SpecialComponent.php -> MyProject\Components\Custom\SpecialComponent
```

### Creating Components - Step by Step

#### 1. Create File
```php
<?php
// File: src/components/Cards/ProductCard.php
namespace YourNamespace\Components\Cards;

use FriendsOfRedaxo\MFragment\Components\AbstractComponent;

class ProductCard extends AbstractComponent
{
    private string $title = '';
    private string $price = '';
    
    public function setTitle(string $title): self
    {
        $this->title = $title;
        return $this;
    }
    
    public function setPrice(string $price): self
    {
        $this->price = $price;
        return $this;
    }
    
    protected function renderHtml(): string
    {
        return '<div' . $this->buildAttributesString() . '>
            <h3>' . htmlspecialchars($this->title) . '</h3>
            <span class="price">' . htmlspecialchars($this->price) . '</span>
        </div>';
    }
}
```

#### 2. Use Component
```php
<?php
use YourNamespace\Components\Cards\ProductCard;

// Direct usage
$card = ProductCard::factory()
    ->setTitle('Gaming Laptop')
    ->setPrice('€ 1,299.00')
    ->addClass('product-card');

echo $card->show();

// In MFragment Container
$container = MFragment::factory()
    ->addComponent($card)
    ->addClass('product-grid');
```

### Automatic Loading

MFragment automatically loads components when properly placed:

```php
// These directories are automatically scanned:
src/components/                         -> Your chosen namespace
theme_addon_path/components/            -> Your theme namespace
theme_addon_path/private/components/    -> Your theme namespace
src/addons/mfragment/components/        -> FriendsOfRedaxo\MFragment\Components\*
```

**Important:** 
- The namespace is freely selectable
- Namespace structure must match directory structure
- Composer autoload or corresponding configuration required

## Debugging

### Debug Mode

Enable debug output for development:

```php
// In development environment
\FriendsOfRedaxo\MFragment\Core\RenderEngine::enableDebug();

// Components output debug information
$card = Card::factory()->setHeader('Debug Card')->show();
// Output: <!-- MFragment Debug: Card rendered in 0.5ms -->
```

### Performance Optimization

```php
// Enable performance monitoring in development
if (rex::isDebugMode()) {
    \FriendsOfRedaxo\MFragment\Core\RenderEngine::enableDebug();
}

// Retrieve performance statistics
$stats = \FriendsOfRedaxo\MFragment\Core\RenderEngine::getStats();
echo "Render calls: " . $stats['renderCalls'];
echo "Total time: " . $stats['processingTime'] . "ms";
```

### Developer Debugging Workflow

```php
<?php
// debug.php - Debugging helper for custom components

use FriendsOfRedaxo\MFragment\Core\RenderEngine;
use FriendsOfRedaxo\MFragment\Components\Bootstrap\Card;
use App\Components\ProductCard;

// Enable debug mode
if (rex::isDebugMode()) {
    RenderEngine::enableDebug();
}

// Test various components
$components = [
    'Standard Card' => Card::factory()->setHeader('Test Card')->setBody('Test Content'),
    'Product Card' => ProductCard::factory()->setTitle('Test Product')->setPrice('$99.99'),
    'Complex Layout' => MFragment::factory()
        ->addDiv(
            Card::factory()->setHeader('Nested Test'),
            ['class' => 'col-md-6']
        )
];

foreach ($components as $name => $component) {
    echo "<h3>{$name}</h3>";
    $startTime = microtime(true);
    
    $output = $component->show();
    
    $renderTime = round((microtime(true) - $startTime) * 1000, 2);
    echo "<p><small>Render time: {$renderTime}ms</small></p>";
    echo $output;
    echo "<hr>";
}

// Overall statistics
$stats = RenderEngine::getStats();
echo "<h3>Performance Overview</h3>";
echo "<ul>";
echo "<li>Total render calls: " . $stats['renderCalls'] . "</li>";
echo "<li>Total render time: " . $stats['processingTime'] . "ms</li>";
echo "<li>Average render time: " . round($stats['processingTime'] / max($stats['renderCalls'], 1), 2) . "ms</li>";
echo "</ul>";
```

### Media Manager Tests and Validation

```php
<?php
// media_debug.php - Test responsive media system

// Check if all Media Manager types are available
function validateMediaTypes(): array
{
    $requiredTypes = [
        'small_1x1_320', 'small_4x3_320', 'small_16x9_320',
        'half_1x1_768', 'half_4x3_768', 'half_16x9_768',
        'full_1x1_1200', 'full_4x3_1200', 'full_16x9_1200',
        'hero_16x9_1400', 'hero_21x9_1920'
    ];
    
    $available = [];
    $missing = [];
    
    foreach ($requiredTypes as $type) {
        if (rex_sql::factory()->getArray('SELECT id FROM ' . rex::getTable('media_manager_type') . ' WHERE name = ?', [$type])) {
            $available[] = $type;
        } else {
            $missing[] = $type;
        }
    }
    
    return compact('available', 'missing');
}

// Test responsive image generation
function testResponsiveImages(string $mediaFile): void
{
    $types = ['small', 'half', 'full', 'hero'];
    
    echo "<h3>Responsive Image Test: {$mediaFile}</h3>";
    
    foreach ($types as $baseType) {
        echo "<h4>{$baseType} Series</h4>";
        
        if (function_exists('generateSrcset')) {
            $srcset = generateSrcset($mediaFile, $baseType);
            echo "<p><strong>Srcset:</strong> " . htmlspecialchars($srcset) . "</p>";
            
            $sizes = generateSizesForType($baseType);
            echo "<p><strong>Sizes:</strong> " . htmlspecialchars($sizes) . "</p>";
        }
        
        // Test individual sizes
        $breakpoints = [320, 576, 768, 992, 1200, 1400];
        foreach ($breakpoints as $bp) {
            $typeName = "{$baseType}_16x9_{$bp}";
            if (rex_media_manager::getUrl($typeName, $mediaFile)) {
                echo "<span class='badge bg-success'>{$typeName} ✓</span> ";
            }
        }
        echo "<br><br>";
    }
}

// Run tests
$validation = validateMediaTypes();
echo "<h2>Media Manager Validation</h2>";
echo "<p><strong>Available Types:</strong> " . count($validation['available']) . " of " . (count($validation['available']) + count($validation['missing'])) . "</p>";

if (!empty($validation['missing'])) {
    echo "<div class='alert alert-warning'>";
    echo "<strong>Missing Types:</strong> " . implode(', ', $validation['missing']);
    echo "<br><em>Run the SQL schema: install/responsive_complete_system.sql</em>";
    echo "</div>";
}

// Test with example file
if ($media = rex_media::get('example.jpg')) {
    testResponsiveImages('example.jpg');
}
```
```

## Optional Dependencies
- **FOR Html** - Extended HTML generation (automatically detected)
- **Media Manager** - For responsive image functionality

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

- **Documentation**: [https://github.com/FriendsOfREDAXO/mfragment/wiki](https://github.com/FriendsOfREDAXO/mfragment/wiki)
- **Issues**: [https://github.com/FriendsOfREDAXO/mfragment/issues](https://github.com/FriendsOfREDAXO/mfragment/issues)  
- **Community**: [REDAXO Slack](https://redaxo.org/slack/)

## Credits

**MFragment** is developed and maintained by [Friends Of REDAXO](https://github.com/FriendsOfREDAXO).