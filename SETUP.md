# Learning Allegro — WordPress on Railway
## Setup, Deployment & Content Migration Guide

---

## Project Structure

```
wordpress-railway/
├── Dockerfile                  # Custom WordPress image
├── docker-compose.yml          # Local dev orchestration
├── apache.conf                 # Apache configuration
├── uploads.ini                 # PHP upload settings
├── .env.example                # Environment variable template
├── .env                        # Your local secrets (never commit)
├── .gitignore
├── SETUP.md                    # This file
└── page-content/               # Starter content for each page
    ├── home.md
    ├── about.md
    ├── teachers.md
    ├── private-lessons.md
    ├── group-classes.md
    ├── enrichment.md
    ├── contact.md
    └── careers.md
```

---

## Part 1: WordPress Site Map

This is the cleaned-up site map for the WordPress rebuild. It consolidates
the three overlapping nav menus from the legacy GoDaddy site into one
consistent hierarchy.

```
Home
├── About Us
└── Teachers

Private Lessons
├── Piano Lessons          (ages 4+)
├── Guitar Lessons         (ages 5+, incl. bass, ukulele, mandolin)
├── Strings                (violin, viola, cello, upright bass, ages 5+)
├── Drum Lessons           (ages 5+)
├── Voice Lessons          (ages 5+)
└── Brass & Woodwind       (flute, sax, clarinet, trumpet, trombone, tuba, ages 9+)

Group Classes
├── Toddler Music (Creative Crescendos)
├── Introduction to Music
├── Group Guitar
├── Group Piano
├── Group Violin
├── Music Theory
├── Carnatic Music
└── Ensemble Groups

Enrichment
├── Art Classes
├── Summer Camps
└── Enrichment Classes

News & Events
├── Blog
├── Newsletter
└── Special Events

Careers
Contact Us
```

### Changes from the Legacy Site
- **Resources** section eliminated — Blog, Newsletter, and Special Events promoted
  directly into "News & Events" top-level nav item
- **Enrichment** is a new top-level bucket consolidating Art Classes, Summer Camps,
  and Enrichment Classes, which were scattered in the legacy nav
- **Careers** promoted to primary nav (was hidden in secondary menu only)
- **About Us** and **Teachers** consolidated under the Home dropdown
- One consistent nav menu replaces the three conflicting menus on the legacy site

---

## Part 2: Content Audit — What to Fix in the Rebuild

### Issues Found in the Legacy Site

**Navigation (critical)**
The legacy site renders three separate nav menus per page with inconsistent
ordering and items between them. WordPress with a single menu definition
fixes this automatically.

**Homepage is too thin**
The homepage has very little actual content — several sections show only
placeholder arrows (▸) suggesting incomplete content. The rebuild homepage
should include:
- Hero section with headline, subheadline, and a "Book a Trial Lesson" CTA
- Brief "Why Learning Allegro" section (3 key factors)
- Featured programs grid (Private Lessons / Group Classes / Enrichment)
- Testimonials section (currently absent from the entire site)
- Upcoming events or recital announcements
- Location and contact info in footer

**No pricing information**
The Private Lessons page mentions monthly tuition and a 10% sibling discount
but never states actual rates. Add at minimum a "Pricing" section or page with
starting rates per lesson length (30 min / 45 min / 60 min).

**No testimonials or social proof**
There are no parent or student reviews anywhere on the site. This is a
significant conversion gap for a children's education business. Add a
testimonials section to the homepage and consider a dedicated Reviews page.

**Contact form too minimal**
Current form: Name, Email, Phone, Subject, Message.
Recommended additions:
- Student age (dropdown)
- Instrument(s) of interest (multi-select or dropdown)
- How did you hear about us?
This pre-qualifies leads and saves back-and-forth emails.

**No online scheduling**
All CTAs link to the contact form. Simply Schedule Appointments (free WordPress
plugin, unlimited appointment types, Google Calendar sync) or a Calendly embed
(free plan, 1 event type, no plugin required) would allow prospective students
to book a trial lesson directly without a phone call.

**Teachers page has a copy-paste error**
Joseph O'Brien's bio is actually David Deratizian's bio copied verbatim.
This needs to be corrected with Joseph's actual bio.

**Typos to fix**
- "thoughout" → "throughout" (homepage, community performances blurb)
- "Contact F0rm" → "Contact Form" (contact page heading, zero instead of O)
- "CCopyright" → "Copyright" (footer, all pages)

**GoDaddy badge in footer**
The legacy site footer has a GoDaddy Website Builder badge linking to GoDaddy's
product page. This disappears naturally on migration.

### What to Keep
- All instrument-specific lesson page content (well-written, SEO-rich)
- The FAQ section on the Private Lessons page (strong conversion asset)
- The "3 key factors / whole-child approach" framing from About Us
- The Allegro Event Music cross-link on the About Us page
- Local SEO keyword strategy in copy and alt text (Chester Springs, Downingtown,
  Glenmoore, Malvern, Pottstown, Coatesville, West Chester)
- All teacher bios (minus the copy-paste error on Joseph O'Brien)
- The free Practice Log download offer

---

## Part 3: Local Development Setup

### Prerequisites
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed locally
- [Railway CLI](https://docs.railway.app/develop/cli): `npm install -g @railway/cli`
- Git installed

### 1. Initialize the repo
```bash
git init learning-allegro
cd learning-allegro
# Copy all project files here
```

### 2. Set up environment
```bash
cp .env.example .env
# Edit .env with local credentials
```

### 3. Build and start
```bash
docker compose up --build
```

### 4. Complete WordPress setup
Visit http://localhost:8080. Complete the install wizard:
- Site Title: `Learning Allegro`
- Set a strong admin username/password
- Admin email: your address

### 5. Install Astra theme
1. **Appearance → Themes → Add New** → search "Astra" → Install & Activate
2. **Appearance → Starter Templates** → install plugin when prompted
3. Search "Music School" → import the full demo

### 6. Configure the nav menu
**Appearance → Menus → Create New Menu** named "Primary Navigation"
Build it to match the site map in Part 1. Assign to "Primary Menu" location.
Delete or leave unused any demo menus that come with the starter template.

### 7. Recommended plugins
| Plugin | Purpose |
|---|---|
| Astra Starter Templates | One-click demo import |
| Elementor (free) | Page builder |
| Simply Schedule Appointments | Lesson booking — free, unlimited appointment types, Google Calendar sync. Alternatively, embed a free Calendly widget (1 event type on free plan, no plugin needed) |
| WPForms Lite | Contact form with custom fields |
| Yoast SEO | Local SEO, meta descriptions |
| UpdraftPlus | Automated backups |
| Wordfence | Security |
| WP Super Cache | Performance |
| WP Offload Media Lite | Offload uploads to S3/R2 (recommended for Railway) |

---

## Part 4: Deploy to Railway

### 1. Login and initialize
```bash
railway login
railway init   # Select "Empty Project", name it "learning-allegro"
```

### 2. Add MySQL in Railway dashboard
**+ New Service → Database → MySQL**
Railway provisions MySQL and exposes connection variables automatically.

### 3. Set environment variables in Railway dashboard
```
MYSQL_DATABASE=learning_allegro
MYSQL_USER=<from Railway MySQL>
MYSQL_PASSWORD=<from Railway MySQL>
MYSQL_ROOT_PASSWORD=<from Railway MySQL>
SITE_URL=https://<your-app>.railway.app
WORDPRESS_DEBUG=false
WORDPRESS_TABLE_PREFIX=wp_
```

### 4. Deploy
```bash
railway up
railway logs   # watch for errors
```

### 5. Complete WordPress setup on Railway URL
Visit your Railway URL and run through the WordPress install wizard again
(or migrate your local DB — see migration steps below).

### Migrating Local DB to Railway
```bash
# 1. Export from local
docker compose exec db mysqldump -u wp_user -p learning_allegro > local_export.sql

# 2. Import to Railway MySQL
# Use a GUI client (TablePlus, DBeaver) connected to Railway MySQL credentials
# Or use railway run:
railway run mysql -h $MYSQLHOST -u $MYSQLUSER -p$MYSQLPASSWORD $MYSQLDATABASE < local_export.sql

# 3. Update site URLs in the DB
UPDATE wp_options SET option_value = 'https://your-railway-url.railway.app'
WHERE option_name IN ('siteurl', 'home');
```

---

## Part 5: Connect GoDaddy Domain

### 1. Add custom domain in Railway
Dashboard → your service → **Settings → Domains → Add Custom Domain**
Enter `learningallegro.com` and `www.learningallegro.com`
Note the CNAME target Railway provides.

### 2. Update GoDaddy DNS
DNS Management for `learningallegro.com`:

| Type | Name | Value | TTL |
|---|---|---|---|
| CNAME | www | `<railway-cname>` | 600 |
| CNAME | @ | `<railway-cname>` | 600 |

If GoDaddy doesn't allow CNAME on root (@), use an A record with Railway's IP.
Railway auto-provisions SSL (Let's Encrypt) for custom domains.

### 3. Update SITE_URL after DNS propagates
```
SITE_URL=https://learningallegro.com
```
Then in **WordPress → Settings → General** update both URL fields to match.

---

## Part 6: Ongoing Maintenance

### Backups
UpdraftPlus → configure daily DB backups and weekly full backups to Google Drive
or Dropbox. Retain at least 4 weeks of history.

### Media storage (important for Railway)
Railway volumes can be ephemeral on lower plans. Set up WP Offload Media Lite
with Cloudflare R2 (generous free tier) early — before uploading production images.

### WordPress / image updates
```bash
# Update base image version in Dockerfile, then:
railway up
```

### Provider portability
This Docker setup runs on any provider without changes:
- **Render**: point at GitHub repo
- **Fly.io**: `fly launch`
- **DigitalOcean App Platform**: connect repo
- **Any Linux VPS**: `docker compose up -d`

Migration steps: export DB → copy wp_data volume → update SITE_URL.

---

## Troubleshooting

**"Error establishing a database connection"**
Check container health: `docker compose ps`
Verify .env credentials match docker-compose.yml

**WordPress redirects to wrong URL**
Fix via DB: `UPDATE wp_options SET option_value='http://localhost:8080' WHERE option_name IN ('siteurl','home');`

**Uploads not persisting on Railway**
Set up WP Offload Media Lite + Cloudflare R2 (see plugin list above)

**Joseph O'Brien bio shows wrong content**
The legacy site has his bio replaced with David Deratizian's text. Use the
content in page-content/teachers.md which has a placeholder for his correct bio.
