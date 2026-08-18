# deniskazakov.com

Personal site and the primary publication source for Denis Kazakov, built with Hugo and PaperMod.

## Publishing a post

Create an English post with `hugo new posts/my-post.en.md` or a Russian one with
`hugo new posts/my-post.ru.md`. Publish the original here first; Hugo uses
`baseURL` to generate its canonical URL. When reposting to Substack, LinkedIn,
Habr, or Telegram, link to the original page on `https://deniskazakov.com/`.

## GitHub Pages domain setup

The repository publishes `static/CNAME`, so the generated site requests
`deniskazakov.com` as its custom GitHub Pages domain. In the GitHub Pages
settings, set **Custom domain** to `deniskazakov.com` and enable **Enforce HTTPS**
after DNS has propagated.

At the domain registrar, point the apex `deniskazakov.com` to GitHub Pages with
these `A` records, and point `www` to `kazakovdenis.github.io` with a `CNAME`
record. Do not use a CNAME at the apex unless the DNS provider explicitly
supports ALIAS/ANAME flattening.

```
185.199.108.153
185.199.109.153
185.199.110.153
185.199.111.153
```
