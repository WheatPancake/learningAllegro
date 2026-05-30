#!/bin/bash
# wp-scaffold.sh
# Creates the full Learning Allegro page structure in WordPress using WP-CLI.
# Run this AFTER completing the WordPress install wizard and installing Astra.
#
# Usage (local Docker):
#   chmod +x wp-scaffold.sh
#   ./wp-scaffold.sh
#
# Usage (Railway, via railway run):
#   railway run bash wp-scaffold.sh

set -e

WP="docker compose exec wordpress wp --allow-root"

echo "======================================"
echo " Learning Allegro — Page Scaffold"
echo "======================================"

# ── TOP-LEVEL PAGES ───────────────────────────────────────────

echo "Creating top-level pages..."

HOME_ID=$($WP post create \
  --post_type=page \
  --post_title="Home" \
  --post_status=publish \
  --post_name="home" \
  --porcelain)
echo "  ✓ Home (ID: $HOME_ID)"

$WP option update show_on_front 'page'
$WP option update page_on_front $HOME_ID
echo "  ✓ Set Home as static front page"

LESSONS_ID=$($WP post create \
  --post_type=page \
  --post_title="Private Lessons" \
  --post_status=publish \
  --post_name="private-lessons" \
  --porcelain)
echo "  ✓ Private Lessons (ID: $LESSONS_ID)"

GROUP_ID=$($WP post create \
  --post_type=page \
  --post_title="Group Classes" \
  --post_status=publish \
  --post_name="group-classes" \
  --porcelain)
echo "  ✓ Group Classes (ID: $GROUP_ID)"

ENRICHMENT_ID=$($WP post create \
  --post_type=page \
  --post_title="Enrichment" \
  --post_status=publish \
  --post_name="enrichment" \
  --porcelain)
echo "  ✓ Enrichment (ID: $ENRICHMENT_ID)"

NEWS_ID=$($WP post create \
  --post_type=page \
  --post_title="News & Events" \
  --post_status=publish \
  --post_name="news-events" \
  --porcelain)
echo "  ✓ News & Events (ID: $NEWS_ID)"

CONTACT_ID=$($WP post create \
  --post_type=page \
  --post_title="Contact Us" \
  --post_status=publish \
  --post_name="contact-us" \
  --porcelain)
echo "  ✓ Contact Us (ID: $CONTACT_ID)"

CAREERS_ID=$($WP post create \
  --post_type=page \
  --post_title="Careers" \
  --post_status=publish \
  --post_name="careers" \
  --porcelain)
echo "  ✓ Careers (ID: $CAREERS_ID)"

# ── HOME CHILDREN ─────────────────────────────────────────────

echo "Creating Home sub-pages..."

$WP post create \
  --post_type=page \
  --post_title="About Us" \
  --post_status=publish \
  --post_name="about-us" \
  --post_parent=$HOME_ID \
  --porcelain > /dev/null
echo "  ✓ About Us"

$WP post create \
  --post_type=page \
  --post_title="Teachers" \
  --post_status=publish \
  --post_name="teachers" \
  --post_parent=$HOME_ID \
  --porcelain > /dev/null
echo "  ✓ Teachers"

# ── PRIVATE LESSONS CHILDREN ──────────────────────────────────

echo "Creating Private Lessons sub-pages..."

for SLUG_TITLE in \
  "piano-lessons:Piano Lessons" \
  "guitar-lessons:Guitar Lessons" \
  "strings:Strings — Violin, Viola, Cello & Bass" \
  "drum-lessons:Drum Lessons" \
  "voice-lessons:Voice Lessons" \
  "brass-woodwind:Brass & Woodwind Lessons"
do
  SLUG="${SLUG_TITLE%%:*}"
  TITLE="${SLUG_TITLE##*:}"
  $WP post create \
    --post_type=page \
    --post_title="$TITLE" \
    --post_status=publish \
    --post_name="$SLUG" \
    --post_parent=$LESSONS_ID \
    --porcelain > /dev/null
  echo "  ✓ $TITLE"
done

# ── GROUP CLASSES CHILDREN ────────────────────────────────────

echo "Creating Group Classes sub-pages..."

for SLUG_TITLE in \
  "toddler-music:Toddler Music — Creative Crescendos" \
  "intro-to-music:Introduction to Music" \
  "group-guitar:Group Guitar Classes" \
  "group-piano:Group Piano Classes" \
  "group-violin:Group Violin Classes" \
  "music-theory:Music Theory Classes" \
  "carnatic-music:Carnatic Music" \
  "ensemble-groups:Ensemble Groups"
do
  SLUG="${SLUG_TITLE%%:*}"
  TITLE="${SLUG_TITLE##*:}"
  $WP post create \
    --post_type=page \
    --post_title="$TITLE" \
    --post_status=publish \
    --post_name="$SLUG" \
    --post_parent=$GROUP_ID \
    --porcelain > /dev/null
  echo "  ✓ $TITLE"
done

# ── ENRICHMENT CHILDREN ───────────────────────────────────────

echo "Creating Enrichment sub-pages..."

for SLUG_TITLE in \
  "art-classes:Art Classes" \
  "summer-camps:Summer Camps" \
  "enrichment-classes:Enrichment Classes"
do
  SLUG="${SLUG_TITLE%%:*}"
  TITLE="${SLUG_TITLE##*:}"
  $WP post create \
    --post_type=page \
    --post_title="$TITLE" \
    --post_status=publish \
    --post_name="$SLUG" \
    --post_parent=$ENRICHMENT_ID \
    --porcelain > /dev/null
  echo "  ✓ $TITLE"
done

# ── NEWS & EVENTS CHILDREN ────────────────────────────────────

echo "Creating News & Events sub-pages..."

BLOG_ID=$($WP post create \
  --post_type=page \
  --post_title="Blog" \
  --post_status=publish \
  --post_name="blog" \
  --post_parent=$NEWS_ID \
  --porcelain)
echo "  ✓ Blog (ID: $BLOG_ID)"

$WP option update page_for_posts $BLOG_ID
echo "  ✓ Set Blog page as posts archive"

for SLUG_TITLE in \
  "newsletter:Newsletter" \
  "special-events:Special Events"
do
  SLUG="${SLUG_TITLE%%:*}"
  TITLE="${SLUG_TITLE##*:}"
  $WP post create \
    --post_type=page \
    --post_title="$TITLE" \
    --post_status=publish \
    --post_name="$SLUG" \
    --post_parent=$NEWS_ID \
    --porcelain > /dev/null
  echo "  ✓ $TITLE"
done

# ── PRIMARY NAV MENU ──────────────────────────────────────────

echo "Creating primary navigation menu..."

MENU_ID=$($WP menu create "Primary Navigation" --porcelain)
echo "  ✓ Menu created (ID: $MENU_ID)"

# Top-level items
$WP menu item add-post $MENU_ID $HOME_ID --title="Home" --porcelain > /dev/null
$WP menu item add-post $MENU_ID $LESSONS_ID --title="Private Lessons" --porcelain > /dev/null
$WP menu item add-post $MENU_ID $GROUP_ID --title="Group Classes" --porcelain > /dev/null
$WP menu item add-post $MENU_ID $ENRICHMENT_ID --title="Enrichment" --porcelain > /dev/null
$WP menu item add-post $MENU_ID $NEWS_ID --title="News & Events" --porcelain > /dev/null
$WP menu item add-post $MENU_ID $CAREERS_ID --title="Careers" --porcelain > /dev/null
$WP menu item add-post $MENU_ID $CONTACT_ID --title="Contact Us" --porcelain > /dev/null

echo "  ✓ Top-level menu items added"

# Assign to primary location
$WP menu location assign $MENU_ID primary
echo "  ✓ Menu assigned to primary location"

# ── PERMALINK STRUCTURE ───────────────────────────────────────

echo "Setting pretty permalink structure..."
$WP rewrite structure '/%postname%/' --hard
$WP rewrite flush --hard
echo "  ✓ Permalinks set to /%postname%/"

# ── DONE ──────────────────────────────────────────────────────

echo ""
echo "======================================"
echo " Scaffold complete!"
echo "======================================"
echo ""
echo "Next steps:"
echo "  1. Open WordPress admin and verify all pages were created"
echo "  2. Import page content from page-content/*.md files"
echo "  3. Install and configure WPForms on the Contact Us page"
echo "  4. Configure Yoast SEO with local business details"
echo "  5. Add real testimonials to the homepage"
echo "  6. Add Joseph O'Brien's correct bio to the Teachers page"
echo "  7. Add pricing to the Private Lessons page"
echo "  8. Add studio hours to the Contact page"
echo ""
