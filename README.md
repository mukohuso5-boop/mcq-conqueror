# MCQ CONQUEROR — Universal MCQ Practice & Performance-Analysis Platform

Created by **MD. RAID**.

## Quick Start (Zero Build Step)
1. Open `index.html` directly in any modern browser (Chrome, Brave, Edge, Safari, Firefox) — or host it on GitHub Pages, Netlify, or Vercel.
2. Switch subjects from the top bar, click **Add Subject** to create new subjects, or click **Upload / Paste MCQs** to import `sample-mcqs.csv`, `sample-mcqs.json`, or quick pipe-formatted text.
3. Click **Practice All** or **Attempt Chapter** to start a timed session. Every question is dynamically timed and flagged as **Under time** (<70% est.), **On time** (70%–125% est.), or **Overtime** (>125% est.).
4. After submitting, review **Session Summary & Review**, **Deeper Analysis** (weak/slow areas, Guessing vs. Low Confidence, topic/chapter breakdown), and **Multi-Session Progress** charts.

## Enabling Live Multi-User Comparative Analytics (Supabase)
By default, the **Comparative** tab compares your sessions against a local benchmark cohort so it works offline immediately. To compare against real users across devices:
1. Create a free project at https://supabase.com.
2. Open the **SQL Editor** in Supabase and run `supabase-schema.sql`.
3. Copy your **Project URL** (`https://xxxx.supabase.co`) and **Anon Public Key** from **Project Settings -> API**.
4. In the app, go to **Comparative -> Multi-User Setup & SQL**, enter your display name, URL, and key, and enable **Auto-sync completed sessions**.
5. (Recommended for production) Enable Supabase Auth (Email or Google Sign-In) and tighten the RLS insert policy in `supabase-schema.sql` to `auth.uid() = user_id`.
