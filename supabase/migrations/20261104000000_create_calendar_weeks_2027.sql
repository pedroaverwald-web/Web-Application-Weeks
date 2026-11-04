-- ISO 8601 calendar weeks of 2027 (already applied to Supabase project dgqapmbmhircvjgpzqvu)
create table public.calendar_weeks (
  iso_year    smallint not null,
  week_number smallint not null check (week_number between 1 and 53),
  start_date  date     not null unique,
  end_date    date     not null,
  month       smallint not null check (month between 1 and 12),
  quarter     smallint not null check (quarter between 1 and 4),
  label       text generated always as ('KW ' || lpad(week_number::text, 2, '0') || '/' || iso_year::text) stored,
  primary key (iso_year, week_number),
  check (end_date = start_date + 6)
);

comment on table public.calendar_weeks is 'ISO 8601 calendar weeks (Monday to Sunday). month/quarter follow the week''s Thursday, as ISO does.';

alter table public.calendar_weeks enable row level security;

create policy "Calendar weeks are readable by everyone"
  on public.calendar_weeks for select
  to anon, authenticated
  using (true);

insert into public.calendar_weeks (iso_year, week_number, start_date, end_date, month, quarter)
select extract(isoyear from d)::smallint,
       extract(week from d)::smallint,
       d::date,
       (d + interval '6 day')::date,
       extract(month from d + interval '3 day')::smallint,
       extract(quarter from d + interval '3 day')::smallint
from generate_series('2027-01-04'::date, '2027-12-31'::date, interval '7 day') as d
where extract(isoyear from d) = 2027;
