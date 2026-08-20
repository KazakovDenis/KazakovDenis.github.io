# CLAUDE.md

This file provides guidance to agentic coding tools (e.g. Claude Code, Codex, OpenCode, etc) when working with code in this repository.

## Committing is the owner's job — never the agent's

**Do not run `git commit`, `git push`, `git tag`, or any other history-writing or remote-writing git
command.** Denis commits personally; every commit in this repo must be authored by a human. This
holds even when the change is finished, verified, and obviously correct, and even when the task was
phrased as "fix it" or approved with a plain "yes" — approval of the *change* is never approval to
commit it.

Leave finished work in the working tree, say what you changed, and stop there. If a change can only
be validated by CI (as with `.github/workflows/`), say so and let Denis push it — do not push to
find out.

Corollary: never force-push, rewrite history, or move a remote branch to undo your own commit.
Cleaning up a commit you should not have made compounds the mistake. Ask instead.

## Overview

Hugo static site for deniskazakov.com — a personal site and the primary publication source for
Denis Kazakov's writing. Bilingual (English + Russian), themed with PaperMod, deployed to GitHub
Pages.

## Commands

```bash
make install    # apt install hugo + init/update the PaperMod submodule (Debian/Ubuntu; on macOS use `brew install hugo`)
make run        # hugo server -D — local dev server, drafts included
hugo --minify   # production build into public/ (same command CI runs)

hugo new posts/my-post.en.md   # new English post (uses archetypes/posts.md)
hugo new posts/my-post.ru.md   # new Russian post
```

Hugo **extended** is required (the theme compiles SCSS). There are no tests or linters.

## Architecture

**Theme as a git submodule.** `themes/PaperMod` is a submodule pinned to a commit. Never edit files
under `themes/` — a fresh clone or CI checkout will not have those changes. To change theme
behavior, copy the template into the matching path under `layouts/` and edit the copy; Hugo's
lookup order prefers project `layouts/` over the theme's.

**Existing overrides in `layouts/`** (each is a deliberate copy-and-modify of a theme file):
- `partials/home_info.html` — adds social icons to the homepage intro block
- `partials/header.html` — adds `target="_blank" rel="noopener noreferrer"` to nav entries whose
  URL has a scheme, so off-site links (Habr) open in a new tab. Scheme-based rather than
  name-based, so new external menu items need no template change
- `partials/comments.html` — Disqus embed (`kazakov-ru-net` shortname)
- `partials/svg.html` — full copy of the theme's icon set with a `substack` branch added before
  the fallback. `socialIcons` entries whose `name` has no branch here silently render a generic
  chain-link icon, so adding a social link means adding its mark here too
- `partials/post_meta.html` — adds `| safeHTML` to the `delimit` separator. Upstream passes
  `"&nbsp;·&nbsp;"` through `delimit`, which returns a plain string, so Hugo escapes the `&` and
  the separator shows up as literal `&nbsp;·&nbsp;` text in the meta line
- `partials/templates/opengraph.html`, `twitter_cards.html` — copies that read `site.Params.social.*`
  instead of the removed `.Site.Social` API; they exist only to keep newer Hugo versions from erroring
- `_internal/google_analytics.html` — overrides Hugo's built-in template to inject **both** GA4 and
  Yandex.Metrika. Yandex.Metrika lives here, not in config, because this is the only hook Hugo calls
  for analytics
- `_internal/google_news.html` — intentionally empty, suppresses the built-in template
- `_default/rss.xml` — RSS copy updated for the `site.Params.author` map/slice form

`assets/css/extended/custom.css` is PaperMod's supported extension point (`params.assets.extended:
true` in config.yml) — put CSS there, never in the theme's assets.

**Multilingual content.** Language is encoded in the filename suffix, not in directories:
`content/about.en.md` / `content/about.ru.md`. English is `weight: 1` and served at the root; Russian
is `weight: 2` and served under `/ru/`. Every content page and menu entry needs an `.en` and a `.ru`
counterpart, and internal links must be language-aware (`/projects/` in English content,
`/ru/projects/` in Russian). Menus and homepage intro text are per-language under
`languages.<lang>.menu` / `languages.<lang>.params.homeInfoParams` in `config.yml`.

**`mainSections: []` in config.yml intentionally hides the posts list from the homepage.** The
`content/posts/` section currently holds only `_index.*` files with no posts. Restore the homepage
feed by setting `mainSections: ["posts"]` once posts exist.

## Publishing conventions

Publish originals here first. Hugo derives the canonical URL from `baseURL`, so a page published
here declares deniskazakov.com as its canonical source; when reposting to Substack, LinkedIn, Habr,
or Telegram, link back to the deniskazakov.com URL. `archetypes/posts.md` carries this reminder as a
comment in every new post. New posts start with `draft: true` — `buildDrafts: false` means they stay
out of production until that flips.

`archetypes/page.md` (`hugo new -k page ...`) doubles as a reference listing every PaperMod
front-matter key, with the rarely-used ones commented out. Prefer `archetypes/posts.md` for actual
posts — it is the minimal set plus the canonical-URL reminder.

## Deployment

`.github/workflows/gh-pages.yml` builds on every push and PR, and deploys `./public` to the
`gh-pages` branch only from `master`. The checkout uses `submodules: true` and `fetch-depth: 0`
(needed for `.GitInfo`/`.Lastmod`).

`public/` is gitignored — never commit build output. `static/CNAME` (`deniskazakov.com`) and
`static/.nojekyll` are published as-is and must stay; deleting either breaks the custom domain or
lets GitHub run Jekyll over the output. README.md documents the DNS/A-record setup.

## History worth knowing

`bae7ca5` ("make deniskazakov.com the publication site") refocused the site on writing: it deleted
`content/projects.{en,ru}.md` and `content/search.{en,ru}.md` and added `content/posts/`. Don't
reintroduce those pages as a "fix" for missing content — their removal was deliberate. The site also
emits deprecation warnings for `languages.<lang>.languageName` in `config.yml` (Hugo ≥ 0.158 wants
`label` instead); harmless today, but that key will eventually be removed.