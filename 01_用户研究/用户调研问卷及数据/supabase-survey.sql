-- Vowice user research survey, version 1.0
-- Run this file once in Supabase Dashboard > SQL Editor.

create table if not exists public.vowice_survey_responses (
  id uuid primary key default gen_random_uuid(),
  response_id text not null unique,
  survey_version text not null,
  submitted_at timestamptz not null default now(),
  duration_seconds integer not null check (duration_seconds >= 0),
  consent boolean not null default false,
  age_confirmed boolean not null default false,
  age_group text,
  gender text,
  answers jsonb not null
);

alter table public.vowice_survey_responses enable row level security;

-- The public survey can submit a response, but cannot read, edit, or delete responses.
revoke all on table public.vowice_survey_responses from anon, authenticated;
grant insert on table public.vowice_survey_responses to anon;

drop policy if exists "anonymous survey insert only" on public.vowice_survey_responses;
create policy "anonymous survey insert only"
on public.vowice_survey_responses
for insert
to anon
with check (
  consent is true
  and age_confirmed is true
  and survey_version = '1.0'
  and char_length(response_id) between 8 and 80
  and jsonb_typeof(answers) = 'object'
  and char_length(coalesce(answers ->> 'one_thing_wish', '')) <= 300
);

comment on table public.vowice_survey_responses is
  'Anonymous responses for Vowice product research. The survey does not request names or contact details.';
