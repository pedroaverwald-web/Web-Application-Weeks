# Calendar weeks 2027

A small web app that shows all ISO calendar weeks (KW) of 2027. The data lives in Supabase; the app is hosted on Cloudflare Workers.

- **Database:** Supabase project `calendar-weeks-2027` (Frankfurt), table `public.calendar_weeks`, 52 rows, read-only for the public via row level security.
- **App:** `public/index.html`, a single page that reads the table through Supabase's REST API.
- **Hosting:** Cloudflare Workers static assets, configured in `wrangler.jsonc`.

## Put it on GitHub

1. Create a new, empty repository on github.com, for example `calendar-weeks-2027`.
2. In this folder run:

   ```bash
   git init
   git add .
   git commit -m "Calendar weeks 2027"
   git branch -M main
   git remote add origin https://github.com/<your-user>/calendar-weeks-2027.git
   git push -u origin main
   ```

## Publish it on Cloudflare

1. In the Cloudflare dashboard open **Workers & Pages → Create → Import a repository**.
2. Connect your GitHub account and pick `calendar-weeks-2027`.
3. Keep the defaults (deploy command `npx wrangler deploy`) and click **Deploy**.

Your app is then live at `https://calendar-weeks-2027.<your-subdomain>.workers.dev`, and every push to `main` publishes a new version.

## Run it locally

```bash
npm install
npm run dev
```

## Database

The SQL that created the table is in `supabase/migrations/`. The publishable key in `index.html` is meant to be public; it can only read `calendar_weeks`, because that is the only thing the row level security policy allows.
