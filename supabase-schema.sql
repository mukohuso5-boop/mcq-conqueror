-- MCQ CONQUEROR (Created by MD. RAID)
-- Supabase Multi-User Comparative & Admin-Only MCQ Bank Schema
-- Run in Supabase Dashboard -> SQL Editor

-- 1. Practice Sessions (any user can practice & submit scores)
create table if not exists public.practice_sessions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete set null,
  display_name text not null default 'Learner',
  subject_code text not null,
  accuracy_pct numeric(5,2) not null check (accuracy_pct >= 0 and accuracy_pct <= 100),
  avg_time_sec numeric(6,2) not null check (avg_time_sec >= 0),
  total_questions int not null check (total_questions > 0),
  correct_count int not null check (correct_count >= 0),
  created_at timestamptz not null default now()
);

create index if not exists idx_practice_sessions_subject
  on public.practice_sessions (subject_code, created_at desc);

alter table public.practice_sessions enable row level security;

create policy "Allow session inserts"
  on public.practice_sessions for insert
  with check (true);

create or replace view public.subject_leaderboard as
select
  subject_code,
  display_name,
  round(avg(accuracy_pct), 1) as avg_accuracy,
  round(avg(avg_time_sec), 1) as avg_time_sec,
  count(*)::int as session_count
from public.practice_sessions
group by subject_code, display_name;

grant select on public.subject_leaderboard to anon, authenticated;
grant insert on public.practice_sessions to anon, authenticated;

-- 2. Shared MCQ Question Bank (Public Read, Admin-Only Write)
-- Replace YOUR_ADMIN_EMAIL@example.com with MD. RAID's Supabase Auth email
create table if not exists public.questions (
  id uuid primary key default gen_random_uuid(),
  subject_code text not null,
  chapter text not null,
  topic text not null,
  type text not null default 'Theory',
  difficulty text not null default 'Moderate',
  question text not null,
  options jsonb not null,
  correct_index int not null,
  created_at timestamptz not null default now()
);

alter table public.questions enable row level security;

create policy "Anyone can read MCQs for practice"
  on public.questions for select
  using (true);

create policy "Only Admin can insert/update/delete MCQs"
  on public.questions for all
  using ((auth.jwt() ->> 'email') = 'YOUR_ADMIN_EMAIL@example.com')
  with check ((auth.jwt() ->> 'email') = 'YOUR_ADMIN_EMAIL@example.com');

grant select on public.questions to anon, authenticated;
grant insert, update, delete on public.questions to authenticated;
