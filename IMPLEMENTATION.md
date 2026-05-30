# Learning Allegro — WordPress Implementation Guide
## Step-by-Step Instructions for Reproducing the Site

This document is written for the person doing the build. Follow steps in order.
Content in `page-content/*.md` files is the source of truth for copy. Where this
guide conflicts with those files, this guide takes precedence — it incorporates
corrections from the live GoDaddy site.

---

## Part 1: Environment & First Boot

### 1.1 Start the local environment
```bash
cp .env.example .env
# Edit .env — set strong passwords. Leave SITE_URL=http://localhost:4040
docker compose up --build -d
```

### 1.2 Complete the WordPress install wizard
Visit **http://localhost:4040**

| Field | Value |
|---|---|
| Site Title | `Learning Allegro` |
| Username | *(your choice — don't use "admin")* |
| Password | *(strong password — save it)* |
| Admin Email | `ryan@provenchers.net` |

### 1.3 Set permalink structure
**Settings → Permalinks → Post name** → Save.

### 1.4 Set timezone
**Settings → General → Timezone → New York**

---

## Part 2: Theme Installation

### 2.1 Install Astra
**Appearance → Themes → Add New** → search "Astra" → Install → Activate.

### 2.2 Install Astra Starter Templates plugin
When prompted after activating Astra, install the **Starter Templates** plugin.
Also install **Elementor** (free) when prompted — it's the page builder used throughout.

### 2.3 Import a starter template
**Appearance → Starter Templates** → search **"Music School"** →
click **Full Site** → Import Complete Site.

> This gives a baseline layout to work from. You will replace all content in
> subsequent steps.

### 2.4 Color palette
The live site uses warm, family-friendly tones. Configure in
**Appearance → Customize → Global → Colors**:

| Role | Value |
|---|---|
| Primary accent | `#c0392b` (deep red — matches legacy site nav) |
| Secondary | `#2c3e50` (dark slate) |
| Background | `#ffffff` |
| Light section bg | `#f9f5f0` (warm off-white for alternating sections) |

> If the starter template provides a "Music School" palette that looks close,
> keep it rather than overriding manually.

### 2.5 Typography
**Appearance → Customize → Global → Typography**
- Body: **Lato** or **Open Sans**, 16px, line-height 1.6
- Headings: **Playfair Display** or **Montserrat Bold**

---

## Part 3: Plugin Installation

Install all plugins via **Plugins → Add New**:

| Plugin | Search term | Notes |
|---|---|---|
| Elementor | `Elementor` | Free version. Page builder for all content pages. |
| WPForms Lite | `WPForms` | Contact form with custom fields. |
| Simply Schedule Appointments | `Simply Schedule Appointments` | Free booking plugin. Replaces paid Amelia. |
| Yoast SEO | `Yoast SEO` | Free version is sufficient. |
| UpdraftPlus | `UpdraftPlus` | Free version. Configure after launch. |
| Wordfence | `Wordfence` | Free version. Configure after launch. |
| WP Super Cache | `WP Super Cache` | Free. Enable after launch. |
| WP Offload Media Lite | `WP Offload Media Lite` | Free. Set up with Cloudflare R2 before uploading production images on Railway. |

---

## Part 4: Page Scaffold

Run the scaffold script to create all pages and the nav menu automatically:

```bash
chmod +x wp-scaffold.sh
./wp-scaffold.sh
```

Verify in **Pages** that all pages were created. The script also sets the
static front page and permalink structure.

If the script fails, create pages manually to match the site map in `SETUP.md`.

---

## Part 5: Navigation Menu

**Appearance → Menus → Primary Navigation** (created by the scaffold script).

Verify the menu structure matches exactly:

```
Home
  └── About Us
  └── Teachers
Private Lessons
  ├── Piano Lessons
  ├── Guitar Lessons
  ├── Strings — Violin, Viola, Cello & Bass
  ├── Drum Lessons
  ├── Voice Lessons
  └── Brass & Woodwind Lessons
Group Classes
  ├── Toddler Music — Creative Crescendos
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

Assign to the **Primary Menu** location. Enable a **Mega Menu** option in
Astra's menu settings if available — the live site renders its mega-menu in
3–4 columns.

---

## Part 6: Page-by-Page Content

For each page: open it in the WP admin, click **Edit with Elementor**, and
build the sections described below. Use the content in `page-content/` as your
copy source.

---

### 6.1 Home (Front Page)

**Template:** Full Width (no sidebar). Set via **Page Attributes → Template**.

#### Section 1 — Hero
- **Widget:** Elementor Hero / Full-width section with background image
- **Background:** Photo of students in a lesson (warm, bright). Overlay: semi-transparent dark.
- **Headline:** `Where Chester County Kids Fall in Love with Music`
- **Subheadline:** `Private lessons and group classes for ages 2 and up — piano, guitar, strings, drums, voice, brass, woodwind, and more. Located in Glenmoore, PA.`
- **Button 1 (primary):** `Book a Trial Lesson` → `/contact-us/`
- **Button 2 (outlined):** `View Our Programs` → `/private-lessons/`

#### Section 2 — Trust Bar
- **Layout:** 3 columns, light background (`#f9f5f0`)
- Col 1: Icon + **10+ Instruments** / *Piano, Guitar, Strings & More*
- Col 2: Icon + **Expert Teachers** / *Credentialed, Performing Professionals*
- Col 3: Icon + **Annual Recitals** / *Fall & Spring Performances Every Year*

#### Section 3 — Why Learning Allegro
- **Headline:** `Our Approach to Music Education`
- **Layout:** 3 feature cards
- Card 1 — **Individualized Learning:** *No two students learn the same way. Every student receives a personalized lesson plan tailored to their age, skill level, goals, and learning style.*
- Card 2 — **The Whole Child:** *Our teachers design lessons to meet each student's intellectual, social, behavioral, and emotional needs — not just their musical ones.*
- Card 3 — **Community & Performance:** *From annual Fall and Spring Recitals to local community day performances and our Open House, students build confidence by sharing their music.*

#### Section 4 — Our Programs
- **Headline:** `Find the Right Program`
- **Layout:** 3 image tiles
- Tile 1: **Private Lessons** — *One-on-one instruction on piano, guitar, strings, drums, voice, brass, and woodwind. Ages 4 and up.* → `[Explore Private Lessons]` → `/private-lessons/`
- Tile 2: **Group Classes** — *From Toddler Music to Music Theory to Ensemble Groups — learn alongside peers and build camaraderie.* → `[Explore Group Classes]` → `/group-classes/`
- Tile 3: **Enrichment** — *Art classes, summer camps, and enrichment programs that complement and extend the musical experience.* → `[Explore Enrichment]` → `/enrichment/`

#### Section 5 — Testimonials
- **Headline:** `What Our Families Are Saying`
- **Layout:** 3-column cards or carousel
- **PLACEHOLDER — replace with real parent quotes.** Target 4–6 quotes; include first name, child's instrument, tenure at school.

#### Section 6 — Teacher Teaser
- **Headline:** `A Gifted, Dedicated Teaching Staff`
- **Body:** *Learning Allegro's instructors are credentialed, professionally performing musicians who are passionate about sharing their love of music. Each teacher brings a unique background — from classical conservatory training to Broadway pit orchestras to Grammy-nominated recordings.*
- **Photos:** Wendy Provencher (owner) + 2 others of your choice
- **Button:** `Meet the Full Team` → `/teachers/`

#### Section 7 — Location & Contact
- **Layout:** 2 columns
- **Left:** Google Maps embed — query `2938 Conestoga Rd, Glenmoore, PA 19343`
- **Right:**
  - 📍 2938 Conestoga Rd, Glenmoore, Pennsylvania 19343
  - 📞 484-341-8842
  - 🕐 [Add studio hours]
  - *Serving families from Chester Springs, Downingtown, Malvern, Glenmoore, Pottstown, Elverson, Kimberton, Phoenixville, Coatesville, and West Chester.*
  - Mini contact form (Name, Email, Message, Submit) using WPForms Lite shortcode

---

### 6.2 About Us (`/about-us/`)

**Template:** Full Width.

#### Section 1 — Hero
- **Headline:** `About Learning Allegro`
- **Subheadline:** `A music school built on the belief that every child has the power to learn, create, and grow.`

#### Section 2 — What We Believe
- **Headline:** `What We Believe`
- Intro: *THE TEACHERS AT LEARNING ALLEGRO ARE UNITED IN THEIR BELIEF THAT ALL STUDENTS:*
- Bullet list: Have the power to learn / Are curious and creative / Can succeed
- Body: *No two students have exactly the same skills or learning style. That's why we create an individual learning plan where we foster a passion for music in students of all ages and skill levels. Our mission is to create a warm and supportive environment where students, teachers, and families come together as a community of musicians.*

#### Section 3 — The Learning Allegro Difference
- **Headline:** `The Learning Allegro Difference`
- **Layout:** 3 cards
- Card 1 — **Individualized Instruction:** *We tailor every lesson plan to each student's unique needs, goals, learning style, and pace.*
- Card 2 — **The Whole Child:** *Our teachers design lessons to meet the intellectual, social, behavioral, and emotional needs of each student.*
- Card 3 — **Strong Foundation + Fun:** *We believe a strong foundation of technique mixed with a little fun will help each student reach their full musical potential.*

#### Section 4 — Parent's Role
- **Headline:** `Parents: Your Child's Biggest Support`
- Body: *Parents play a huge role in helping support each child's music education. Ensuring that your child arrives to their weekly lesson and making daily practice a priority will help your child reach their full potential.*
- **Download link:** Free Practice Log PDF

#### Section 5 — Steps for Success (Policies)
- **Headline:** `Steps for Success`
- Intro: *Learning Allegro's policies are thoughtfully designed to create an atmosphere of success by fostering a safe, respectful, and nurturing environment for all students.*
- Bullet list of policies (Attendance, Cancellations, Make-up Lessons, Practice, Communication) — full text in `page-content/about.md`

#### Section 6 — In the Community
- **Headline:** `Music Beyond the Studio`
- Body: *At Learning Allegro, we believe in the power of music to bring people together and enrich lives.* (full text in `page-content/about.md`)
- Include link to **[Allegro Event Music](http://www.allegroeventmusic.com)**

#### Section 7 — CTA
- **Headline:** `Ready to Join Our Family of Musicians?`
- **Button:** `Schedule a Trial Lesson` → `/contact-us/`

---

### 6.3 Teachers (`/teachers/`)

**Template:** Full Width.
**Note:** Use an Elementor Team widget or a grid of 3-column cards (photo, name, instruments, bio).

#### Section 1 — Hero
- **Headline:** `Meet Our Expert Music Teachers`
- **Subheadline:** `Credentialed, professionally performing musicians who are passionate about sharing their love of music.`

#### Section 2 — Intro
> *The right teacher can make all the difference...* (full text in `page-content/teachers.md`)

#### Section 3 — Teacher Grid

Add one card per teacher. **Use this data — it corrects the legacy site:**

| Teacher | Instruments | Source of correction |
|---|---|---|
| **Wendy Provencher** | Violin, Viola, Piano | Owner |
| **Joseph O'Brien** | Clarinet, Cello, Piano, Alto & Tenor Saxophone, Flute, Trumpet, Guitar, Voice Pedagogy | ⚠️ Legacy site had David Deratizian's bio here. See bio below. |
| **Sam Faust** | Piano, Organ, Voice Coaching | |
| **David Deratizian** | Bass, Cello, Brass | |
| **Krista Antenucci** | Trumpet, Recorder, Piano | |
| **Chuck Ramsey** | Piano, Guitar | |
| **Stephen Tolnay** | Drums, Piano | |
| **Tom Beideman** | Drums, Guitar, Piano, Ukulele | |
| **Katie Calderon** | Flute, Voice, Piano | |
| **Anna Tsemekhman** | Violin, Piano | |
| **Olivia Flickinger** | Violin, Viola, Piano | |
| **Julia Petters** | Voice, Piano, Flute | |
| **Molly Mendenhall** | Piano, Guitar, Ukulele | |

**Joseph O'Brien's correct bio** (from the live site — replaces the placeholder in teachers.md):
> Joseph O'Brien is a multi-instrumentalist with 25 years of experience on clarinet. He studied at Hofstra University and Immaculata University. Joseph focuses on technique, musicality, and performance skills across all instruments he teaches.

Full bios for all other teachers are in `page-content/teachers.md`.

#### Section 4 — CTA
- **Headline:** `Not Sure Which Teacher Is Right for You?`
- **Button:** `Get Matched with a Teacher` → `/contact-us/`

---

### 6.4 Private Lessons (`/private-lessons/`)

**Template:** Full Width.

#### Section 1 — Hero
- **Headline:** `Private Music Lessons in Chester County`
- **Subheadline:** `One-on-one instruction tailored to every student — from beginners to advanced players, ages 4 through adult.`

#### Section 2 — Benefits
Four benefit blocks (full copy in `page-content/private-lessons.md`):
Personalized Instruction / Expert Instructors / Comprehensive Curriculum / Flexible Scheduling

#### Section 3 — Instrument Grid
Icon cards linking to child pages:

| Icon | Label | Ages | Slug |
|---|---|---|---|
| 🎹 | Piano Lessons | Ages 4+ | `/piano-lessons/` |
| 🎸 | Guitar Lessons | Ages 5+ | `/guitar-lessons/` |
| 🎻 | Strings | Ages 5+ | `/strings/` |
| 🥁 | Drum Lessons | Ages 5+ | `/drum-lessons/` |
| 🎤 | Voice Lessons | Ages 5+ | `/voice-lessons/` |
| 🎺 | Brass & Woodwind | Ages 9+ | `/brass-woodwind/` |

#### Section 4 — Pricing
**⚠️ The live site has NO pricing. Add pricing to improve conversions.**
Contact the owner to get current rates, then add a table:

| Lesson Length | Monthly Rate (4 lessons) |
|---|---|
| 30 minutes | [Add price] |
| 45 minutes | [Add price] |
| 60 minutes | [Add price] |

Sibling / multi-lesson discount: **10% off**. No registration fee.

#### Section 5 — FAQ
Seven Q&As — full text in `page-content/private-lessons.md`. Use an Elementor
Accordion widget.

#### Section 6 — CTA
- **Button:** `Book a Trial Lesson` → `/contact-us/`
- Local SEO footer line: *Serving families from Chester Springs, Downingtown, Glenmoore, Malvern, Pottstown, Elverson, Kimberton, Phoenixville, Coatesville, and West Chester, PA.*

---

### 6.5 Instrument Sub-Pages (children of Private Lessons)

For each instrument page, follow this structure:
1. **Hero** — instrument name headline + "in Chester County, PA" + age range
2. **Why this instrument** — 3–4 benefit bullet points
3. **Skills developed** — list (technique, music theory, ear training, etc.)
4. **Benefits of private lessons** — reuse the 4-block layout from the parent page
5. **Geographic keywords** — Chester Springs, Glenmoore, Elverson, Downingtown, Pottstown, Malvern, Coatesville
6. **CTA** → `/contact-us/`

**Piano page specifically** (most content available from live site):
- Headline: `Piano Lessons near Downingtown, PA`
- Skills: Technical Proficiency, Musical Expression, Sight-Reading & Theory, Repertoire Expansion, Ear Training
- Ages: 4 through adult

---

### 6.6 Group Classes (`/group-classes/`)

**Template:** Full Width.

#### Section 1 — Hero
- **Headline:** `Group Music Classes for All Ages`
- **Subheadline:** `Learn alongside peers, build confidence, and discover the joy of making music together.`

#### Section 2 — Why Group Classes
Paragraph about social skills, confidence, ensemble, performance prep, affordability.
Full copy in `page-content/group-classes.md`.

**Highlights bullet list:**
- Motivating, energetic learning environment
- Develop ensemble and listening skills
- Preparation for recitals and public performance
- More affordable than private lessons
- Available during the day (for homeschool families) and evenings/weekends

#### Section 3 — Class Cards
One card per class, linking to child page:

| Class | Ages | Key detail |
|---|---|---|
| Creative Crescendos (Toddler Music) | **1–3** | Mommy & Me style; Wednesdays 10–10:45am; $60/month |
| Introduction to Music | 4+ | Explores ukulele, piano, violin, percussion |
| Group Guitar | 6+ | Chords, strumming, ensemble songs |
| Group Piano | 2–5 | Music notation, music alphabet, piano keyboard |
| Group Violin | 6+ | Violin parts, technique, simple ensemble pieces |
| Music Theory | 8–12 | Written language of music; National Music Theory Honor Roll eligible |
| Carnatic Music | 6+ | Indian classical music tradition |
| Ensemble Groups | [Ask owner for age/level] | Rehearse and perform as a group |

> ⚠️ The live site lists Toddler Music as **ages 1–3**, not 2–5 as in group-classes.md. Use 1–3.

#### Section 4 — Homeschool Note
Callout box: *Many of our group classes are offered during the day, making Learning Allegro an ideal enrichment partner for homeschool families.*
Button: `Contact Us About Daytime Availability` → `/contact-us/`

#### Section 5 — CTA
Button: `Contact Us to Enroll` → `/contact-us/`

---

### 6.7 Toddler Music Sub-Page (`/toddler-music/`)

Full detail from the live site:
- **Headline:** Creative Crescendos Toddler Music Class
- **Ages:** 1–3 years old
- **Schedule:** Wednesdays, 10:00–10:45am
- **Price:** $60/month
- **Description:** Mommy & Me style; incorporates live and recorded music, age-appropriate instruments, scarves, puppets, interactive songs and games. Parents/caregivers actively participate.
- **Benefits section** (5 headings): Stimulates Brain Development / Encourages Socialization / Improves Motor Skills / Promotes Language Skills / Strengthens Bonding
- **CTA:** form link to join

---

### 6.8 Enrichment (`/enrichment/`)

**Template:** Full Width.

#### Art Classes
- **Price (from live site):** $120/month — Thursdays 5:30–6:30pm with Miss Allison
- **Saturday single sessions:** $30/class — 10:00–11:00am (Ages 5+)
- **Includes:** Painting, drawing, jewelry making, clay sculpting, mixed media. All supplies included.
- **Sample Saturday themes:** Fall Tree Painting, Pixelated Self Portraits, Flower Weaving
- **Art Show:** mention upcoming show (update date each fall)

#### Summer Camps
- **⚠️ No pricing/dates on live site.** Add current details and update each spring.

#### Enrichment Classes
- **⚠️ No details on live site.** Add current offerings (e.g., Kids Yoga, seasonal programs).

---

### 6.9 Contact Us (`/contact-us/`)

**Template:** Full Width.
**Layout:** 2 columns.

#### Left: Contact Form (WPForms Lite)
Build a form with these fields (improvement over the legacy site's 5-field form):

- First Name * (text)
- Last Name * (text)
- Email Address * (email)
- Phone Number * (phone)
- Student Age * (dropdown: Under 4, 4–6, 7–10, 11–14, 15–18, Adult)
- Instrument(s) of Interest * (checkboxes: Piano, Guitar/Bass/Ukulele, Violin/Viola, Cello/Bass, Drums, Voice, Flute/Woodwind, Trumpet/Brass, Not sure yet)
- Private Lessons or Group Classes? (radio: Private, Group, Both, Not sure)
- How did you hear about us? (dropdown: Google Search, Friend/Family Referral, Facebook/Instagram, Drove by / Local, Other)
- Message (textarea, optional — "Anything else you'd like us to know?")
- ☐ Sign me up for the Learning Allegro newsletter
- [Submit]

**Confirmation message:** *"Thank you for reaching out! We'll be in touch within 24 hours to discuss the best program for you."*

**Configure WPForms notifications** to send submissions to the studio's email.

#### Right: Contact Info + Map
```
Learning Allegro Music School
📍 2938 Conestoga Rd, Glenmoore, Pennsylvania 19343
📞 484-341-8842
🕐 [Add studio hours]
```
Embed Google Maps: search `2938 Conestoga Rd, Glenmoore, PA 19343`.
**Appearance → Widgets** or Elementor HTML widget → paste the Google Maps embed iframe.

#### Service Area
*Chester Springs · Glenmoore · Downingtown · Malvern · Pottstown · Elverson · Kimberton · Phoenixville · Coatesville · West Chester*

---

### 6.10 Careers (`/careers/`)

**Template:** Full Width. Full content in `page-content/careers.md`.

Key sections:
1. Hero — `Join the Learning Allegro Team`
2. Why teach here — bullet list of 5 benefits
3. Who we're looking for — requirements list
4. Instruments most needed — **⚠️ update this list based on current openings**
5. How to Apply — CTA button → `/contact-us/`
6. Add a direct email address for applications: **⚠️ ask owner for careers email**

---

## Part 7: Online Booking Setup (Simply Schedule Appointments)

1. **Appointments → Services → Add New Service**
   - Name: `Trial Lesson`
   - Duration: 30 minutes
   - Buffer: 15 minutes (recovery time between bookings)

2. **Appointments → Team Members** → add owner/admin as the booking contact.

3. Connect **Google Calendar** in Settings → Integrations (free, requires Google account).

4. **Embed the booking calendar** on the Contact Us page:
   - Copy the shortcode from Appointments → Embed
   - In the WPForms Lite contact page, add an Elementor Shortcode widget above the form
   - Label it: *"Book a Trial Lesson Online"*

5. Test a booking end-to-end before going live.

---

## Part 8: Yoast SEO Configuration

1. **SEO → General → Site representation**
   - Organization name: `Learning Allegro`
   - Logo: upload studio logo

2. **SEO → Search Appearance → General**
   - Title separator: `|`
   - Meta description: `Music lessons for kids and adults in Glenmoore, PA. Piano, guitar, strings, drums, voice, and more. Serving Chester County and surrounding areas.`

3. **SEO → Local SEO** (if using the free Yoast Local SEO add-on):
   - Address: 2938 Conestoga Rd, Glenmoore, Pennsylvania 19343
   - Phone: 484-341-8842

4. For each page, set a **focus keyphrase** in the Yoast meta box:
   - Home: `music lessons Chester County PA`
   - Private Lessons: `private music lessons Chester Springs PA`
   - Piano: `piano lessons Downingtown PA`
   - Group Classes: `group music classes Glenmoore PA`
   - etc.

---

## Part 9: Footer Configuration

**Appearance → Customize → Footer**

| Column | Content |
|---|---|
| Left | Learning Allegro logo + tagline |
| Center | Quick links (mirrors primary nav top level) |
| Right | 📞 484-341-8842 · 📍 2938 Conestoga Rd, Glenmoore, PA · Social icons |

**Footer copy:**
```
© [Year] Learning Allegro Music School. All rights reserved.
2938 Conestoga Rd, Glenmoore, PA 19343 | 484-341-8842
Music lessons and classes serving Chester Springs, Downingtown, Malvern,
West Chester, Pottstown, and surrounding communities.
```

---

## Part 10: Known Issues to Fix (from Legacy Site)

These errors exist on the current GoDaddy site and must NOT be carried over:

| Issue | Fix |
|---|---|
| Joseph O'Brien's bio shows David Deratizian's text | Use the correct bio in Section 6.3 of this guide |
| "thoughout" on homepage | → "throughout" |
| "Contact F0rm" (zero instead of O) | → "Contact Form" |
| "CCopyright" in footer | → "Copyright" |
| GoDaddy badge in footer | Does not carry over to WordPress |
| No pricing on Private Lessons page | Add pricing table (Section 6.4) |
| No testimonials anywhere | Add placeholder section on homepage (Section 6.1); replace with real quotes |
| Contact form too minimal (5 fields) | Use expanded WPForms form (Section 6.9) |
| Three inconsistent nav menus | Replaced by single Primary Navigation menu (Part 5) |

---

## Part 11: Pre-Launch Checklist

- [ ] All 27+ pages created and content entered
- [ ] Joseph O'Brien bio corrected
- [ ] All typos fixed (thoughout, Contact F0rm, CCopyright)
- [ ] Pricing added to Private Lessons page
- [ ] Real testimonials added (replace placeholders)
- [ ] Studio hours added to Contact page and homepage
- [ ] Careers email address added to Careers page
- [ ] Contact form tested — submissions arrive by email
- [ ] Simply Schedule Appointments booking tested end-to-end
- [ ] Google Maps embed displaying correctly
- [ ] Yoast SEO focus keyphrases set on all major pages
- [ ] Footer copyright year correct
- [ ] UpdraftPlus backup configured (daily DB, weekly full → Google Drive)
- [ ] Wordfence scan run and alerts configured
- [ ] WP Super Cache enabled
- [ ] Site tested on mobile (Astra is responsive by default)
- [ ] All CTAs link to the correct pages (no broken links)
- [ ] Allegro Event Music link (allegroeventmusic.com) on About page is live

---

## Part 12: Railway Deployment

Railway uses the `Dockerfile` directly — `docker-compose.yml` is local dev only
and is never run on Railway. Follow the steps below in order.

### 12.1 Deploy the image
```bash
railway login
railway init   # Select "Empty Project", name it "learning-allegro"
railway up
```

### 12.2 Add MySQL
In the Railway dashboard: **+ New Service → Database → MySQL**.
Railway provisions the database and exposes connection variables automatically.

### 12.3 Set environment variables in the Railway dashboard

> ⚠️ Do not copy from your `.env` file — Railway provides its own DB credentials
> and variable names differ from those in `docker-compose.yml`.

| Variable | Value |
|---|---|
| `WORDPRESS_DB_HOST` | `${{MySQL.MYSQLHOST}}:${{MySQL.MYSQLPORT}}` |
| `WORDPRESS_DB_NAME` | `${{MySQL.MYSQLDATABASE}}` |
| `WORDPRESS_DB_USER` | `${{MySQL.MYSQLUSER}}` |
| `WORDPRESS_DB_PASSWORD` | `${{MySQL.MYSQLPASSWORD}}` |
| `WORDPRESS_TABLE_PREFIX` | `wp_` |
| `WORDPRESS_DEBUG` | `false` |
| `SITE_URL` | `https://<yourapp>.railway.app` |
| `WORDPRESS_CONFIG_EXTRA` | *(see below)* |

Use Railway's variable reference syntax (`${{MySQL.MYSQLHOST}}` etc.) so the
values update automatically if Railway rotates credentials.

### 12.4 WORDPRESS_CONFIG_EXTRA for Railway

Set this as a single environment variable in the Railway dashboard.
**Type it directly** — do not paste from `docker-compose.yml`. The local
`docker-compose.yml` had its `$_SERVER` silently wiped by Docker Compose's
variable interpolation (causing the original 500 error). In Railway's dashboard
the value is stored as-is, so `$_SERVER` reaches PHP intact.

```
define('WP_HOME', 'https://<yourapp>.railway.app');
define('WP_SITEURL', 'https://<yourapp>.railway.app');
define('FORCE_SSL_ADMIN', true);
if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https') {
    $_SERVER['HTTPS'] = 'on';
}
```

The `HTTP_X_FORWARDED_PROTO` check is safer than unconditionally setting HTTPS —
it only activates when Railway's proxy confirms the upstream connection is HTTPS.

### 12.5 Set up media offload BEFORE uploading images

Railway volumes can be wiped on redeploy. Configure **WP Offload Media Lite →
Cloudflare R2** immediately after the WordPress install wizard, before adding
any production images.

1. Create a free Cloudflare account → R2 → create a bucket named `learning-allegro-media`
2. Generate R2 API credentials (Access Key ID + Secret)
3. In WordPress: **Settings → Offload Media** → enter R2 credentials and bucket name
4. Test with a single image upload before proceeding

### 12.6 Complete the WordPress install wizard
Visit your Railway URL and run through the install wizard (same values as
local, Section 1.2). Or migrate your local DB instead:

```bash
# 1. Export local DB
docker compose exec db mysqldump -u wp_user -p learning_allegro > local_export.sql

# 2. Import to Railway (via TablePlus/DBeaver pointed at Railway MySQL creds,
#    or using railway run)
railway run mysql -h $MYSQLHOST -u $MYSQLUSER -p$MYSQLPASSWORD $MYSQLDATABASE \
  < local_export.sql

# 3. Fix the site URL in the DB
UPDATE wp_options
SET option_value = 'https://<yourapp>.railway.app'
WHERE option_name IN ('siteurl', 'home');
```

### 12.7 Run the scaffold script on Railway

Before running, edit the `WP=` line in `wp-scaffold.sh`:
```bash
# Change:
WP="docker compose exec wordpress wp --allow-root"
# To:
WP="wp --allow-root"
```
Then:
```bash
railway run bash wp-scaffold.sh
```
Restore the original line afterward so the script still works locally.

### 12.8 Connect the custom domain

1. Railway dashboard → your service → **Settings → Domains → Add Custom Domain**
   Enter `learningallegro.com` and `www.learningallegro.com`. Note the CNAME target.

2. In GoDaddy DNS Management:

| Type | Name | Value | TTL |
|---|---|---|---|
| CNAME | www | `<railway-cname>` | 600 |
| CNAME | @ | `<railway-cname>` | 600 |

If GoDaddy doesn't allow CNAME on `@`, use an A record pointing to Railway's IP.
Railway auto-provisions SSL (Let's Encrypt) once DNS propagates (~10–30 min).

3. After DNS propagates, update `SITE_URL` and the `WP_HOME`/`WP_SITEURL` values
   in `WORDPRESS_CONFIG_EXTRA` to `https://learningallegro.com`.

4. In **WordPress → Settings → General**, update both URL fields to match.

### 12.9 Pre-launch checks specific to Railway
- [ ] WP Offload Media Lite connected and a test image served from R2
- [ ] `railway logs` shows no PHP errors after deploy
- [ ] HTTPS padlock appears on the Railway URL before switching DNS
- [ ] After DNS switch, all internal links use `https://learningallegro.com` (run Yoast's crawl)
- [ ] UpdraftPlus configured to back up to Google Drive (Railway has no persistent backup)
