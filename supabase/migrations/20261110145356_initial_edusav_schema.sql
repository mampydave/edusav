create extension if not exists pgcrypto with schema extensions;

create table public.sie_role (
	id text primary key,
	nom_role text not null unique,
	description text
);

create table public.sie_permissions (
	id text primary key,
	code text not null unique
);

create table public.sie_role_permissions (
	role_id text not null references public.sie_role(id) on delete cascade,
	perm_id text not null references public.sie_permissions(id) on delete cascade,
	primary key (role_id, perm_id)
);

create table public.sie_ecole (
	id text primary key,
	nom text not null,
	ville text,
	date_crea bigint not null,
	version bigint not null default 1,
	updated_at timestamptz not null default now(),
	deleted_at timestamptz
);

create table public.sie_niveaux (
	id text primary key,
	nom_niveau text not null,
	ecole_id text not null references public.sie_ecole(id) on delete restrict,
	version bigint not null default 1,
	updated_at timestamptz not null default now(),
	deleted_at timestamptz
);

create table public.sie_utilisateurs (
	id text primary key,
	auth_user_id uuid unique references auth.users(id) on delete cascade,
	nom text not null,
	prenom text,
	email text not null unique,
	role_id text references public.sie_role(id) on delete set null,
	date_crea bigint not null,
	date_del bigint,
	version bigint not null default 1,
	updated_at timestamptz not null default now(),
	deleted_at timestamptz
);

create table public.sie_appartenance (
	id text primary key,
	user_id text not null references public.sie_utilisateurs(id) on delete cascade,
	ecole_id text not null references public.sie_ecole(id) on delete restrict,
	niveau_id text references public.sie_niveaux(id) on delete set null,
	annee_sco text not null,
	est_actif boolean not null default true,
	date_mise_a_jour bigint not null,
	version bigint not null default 1,
	updated_at timestamptz not null default now(),
	deleted_at timestamptz
);

create table public.assignations_ecole (
	id text primary key,
	user_id text not null references public.sie_utilisateurs(id) on delete cascade,
	ecole_id text not null references public.sie_ecole(id) on delete restrict,
	role_id text not null references public.sie_role(id) on delete restrict,
	date_debut timestamptz not null,
	date_fin timestamptz,
	statut text not null default 'PENDING'
		check (statut in ('PENDING', 'APPROVED', 'REJECTED')),
	est_actif boolean not null default true,
	version bigint not null default 1,
	updated_at timestamptz not null default now(),
	deleted_at timestamptz
);

create table public.sie_matieres (
	id text primary key,
	nom text not null,
	code_matiere text unique,
	version bigint not null default 1,
	updated_at timestamptz not null default now(),
	deleted_at timestamptz
);

create table public.sie_curriculum (
	id text primary key,
	ecole_id text not null references public.sie_ecole(id) on delete cascade,
	niveau_id text not null references public.sie_niveaux(id) on delete cascade,
	matiere_id text not null references public.sie_matieres(id) on delete cascade,
	version bigint not null default 1,
	updated_at timestamptz not null default now(),
	deleted_at timestamptz,
	unique (ecole_id, niveau_id, matiere_id)
);

create table public.sie_lecon (
	id text primary key,
	titre text not null,
	contenu_brut text,
	contenu_styl text,
	visibilite text not null default 'PRIVE',
	auteur_id text references public.sie_utilisateurs(id) on delete set null,
	matiere_id text references public.sie_matieres(id) on delete set null,
	niveau_id text references public.sie_niveaux(id) on delete set null,
	ecole_id text references public.sie_ecole(id) on delete set null,
	date_upd bigint not null,
	date_del bigint,
	source_type text not null default 'scan',
	version bigint not null default 1,
	updated_at timestamptz not null default now(),
	deleted_at timestamptz
);

create table public.sie_pages (
	id text primary key,
	lecon_id text not null references public.sie_lecon(id) on delete cascade,
	numero_page integer not null,
	storage_key text,
	ocr_texte text,
	contenu_styl text,
	ordre integer not null,
	version bigint not null default 1,
	updated_at timestamptz not null default now(),
	deleted_at timestamptz
);

create table public.sie_flashcards (
	id text primary key,
	ecole_id text references public.sie_ecole(id) on delete set null,
	niveau_id text references public.sie_niveaux(id) on delete set null,
	lecon_id text references public.sie_lecon(id) on delete set null,
	matiere_id text not null references public.sie_matieres(id) on delete restrict,
	user_id text not null references public.sie_utilisateurs(id) on delete cascade,
	question text not null,
	reponse text not null,
	explication text,
	interval_days integer not null default 1,
	repetitions integer not null default 0,
	easiness_factor double precision not null default 2.5,
	next_review_date bigint not null,
	is_active boolean not null default true,
	created_at timestamptz not null default now(),
	version bigint not null default 1,
	updated_at timestamptz not null default now(),
	deleted_at timestamptz
);

create index sie_niveaux_ecole_id_idx on public.sie_niveaux(ecole_id);
create index sie_appartenance_user_id_idx on public.sie_appartenance(user_id);
create index sie_appartenance_ecole_id_idx on public.sie_appartenance(ecole_id);
create index assignations_ecole_user_id_idx on public.assignations_ecole(user_id);
create index assignations_ecole_ecole_id_idx on public.assignations_ecole(ecole_id);
create index sie_curriculum_context_idx
	on public.sie_curriculum(ecole_id, niveau_id, matiere_id);
create index sie_lecon_auteur_id_idx on public.sie_lecon(auteur_id);
create index sie_lecon_context_idx
	on public.sie_lecon(ecole_id, niveau_id, matiere_id);
create index sie_pages_lecon_ordre_idx on public.sie_pages(lecon_id, ordre);
create index sie_flashcards_user_id_idx on public.sie_flashcards(user_id);
create index sie_flashcards_next_review_idx
	on public.sie_flashcards(user_id, next_review_date)
	where is_active and deleted_at is null;

create or replace function public.current_profile_id()
returns text
language sql
stable
security definer
set search_path = ''
as $$
	select profile.id
	from public.sie_utilisateurs as profile
	where profile.auth_user_id = (select auth.uid())
		and profile.date_del is null
	limit 1
$$;

create or replace function public.is_edusav_admin()
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
	select exists (
		select 1
		from public.sie_utilisateurs as profile
		join public.sie_role as role on role.id = profile.role_id
		where profile.auth_user_id = (select auth.uid())
			and profile.date_del is null
			and upper(role.nom_role) = 'ADMIN'
	)
$$;

create or replace function public.handle_new_auth_user()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
	student_role_id text;
	profile_name text;
begin
	select role.id into student_role_id
	from public.sie_role as role
	where role.nom_role = 'ELEVE';

	if student_role_id is null then
		raise exception 'Required ELEVE role is missing';
	end if;

	profile_name := coalesce(
		nullif(trim(new.raw_user_meta_data ->> 'nom'), ''),
		nullif(split_part(coalesce(new.email, ''), '@', 1), ''),
		'Utilisateur'
	);

	insert into public.sie_utilisateurs (
		id,
		auth_user_id,
		nom,
		prenom,
		email,
		role_id,
		date_crea
	) values (
		new.id::text,
		new.id,
		profile_name,
		nullif(trim(new.raw_user_meta_data ->> 'prenom'), ''),
		coalesce(new.email, new.id::text || '@no-email.invalid'),
		student_role_id,
		(extract(epoch from now()) * 1000)::bigint
	);

	return new;
end;
$$;

revoke all on function public.handle_new_auth_user() from public, anon, authenticated;

create trigger on_auth_user_created
	after insert on auth.users
	for each row execute function public.handle_new_auth_user();

revoke all on function public.current_profile_id() from public, anon;
revoke all on function public.is_edusav_admin() from public, anon;
grant execute on function public.current_profile_id() to authenticated;
grant execute on function public.is_edusav_admin() to authenticated;

alter table public.sie_role enable row level security;
alter table public.sie_permissions enable row level security;
alter table public.sie_role_permissions enable row level security;
alter table public.sie_ecole enable row level security;
alter table public.sie_niveaux enable row level security;
alter table public.sie_utilisateurs enable row level security;
alter table public.sie_appartenance enable row level security;
alter table public.assignations_ecole enable row level security;
alter table public.sie_matieres enable row level security;
alter table public.sie_curriculum enable row level security;
alter table public.sie_lecon enable row level security;
alter table public.sie_pages enable row level security;
alter table public.sie_flashcards enable row level security;

create policy "authenticated users read roles"
	on public.sie_role for select to authenticated using (true);
create policy "authenticated users read permissions"
	on public.sie_permissions for select to authenticated using (true);
create policy "authenticated users read role permissions"
	on public.sie_role_permissions for select to authenticated using (true);

create policy "authenticated users read schools"
	on public.sie_ecole for select to authenticated using (deleted_at is null);
create policy "authenticated users read levels"
	on public.sie_niveaux for select to authenticated using (deleted_at is null);
create policy "authenticated users read subjects"
	on public.sie_matieres for select to authenticated using (deleted_at is null);
create policy "authenticated users read curriculum"
	on public.sie_curriculum for select to authenticated using (deleted_at is null);

create policy "users read own profile and admins read all profiles"
	on public.sie_utilisateurs for select to authenticated
	using (auth_user_id = (select auth.uid()) or (select public.is_edusav_admin()));
create policy "users read own memberships and admins read all memberships"
	on public.sie_appartenance for select to authenticated
	using (
		user_id = (select public.current_profile_id())
		or (select public.is_edusav_admin())
	);
create policy "users read own assignments and admins read all assignments"
	on public.assignations_ecole for select to authenticated
	using (
		user_id = (select public.current_profile_id())
		or (select public.is_edusav_admin())
	);
create policy "admins manage assignments"
	on public.assignations_ecole for all to authenticated
	using ((select public.is_edusav_admin()))
	with check ((select public.is_edusav_admin()));

create policy "users read visible lessons"
	on public.sie_lecon for select to authenticated
	using (
		deleted_at is null
		and (
			upper(visibilite) = 'PUBLIC'
			or auteur_id = (select public.current_profile_id())
			or (select public.is_edusav_admin())
		)
	);
create policy "users create own lessons"
	on public.sie_lecon for insert to authenticated
	with check (auteur_id = (select public.current_profile_id()));
create policy "users update own lessons"
	on public.sie_lecon for update to authenticated
	using (auteur_id = (select public.current_profile_id()) or (select public.is_edusav_admin()))
	with check (auteur_id = (select public.current_profile_id()) or (select public.is_edusav_admin()));
create policy "users delete own lessons"
	on public.sie_lecon for delete to authenticated
	using (auteur_id = (select public.current_profile_id()) or (select public.is_edusav_admin()));

create policy "users read pages of visible lessons"
	on public.sie_pages for select to authenticated
	using (
		exists (
			select 1 from public.sie_lecon as lesson
			where lesson.id = lecon_id
				and lesson.deleted_at is null
				and (
					upper(lesson.visibilite) = 'PUBLIC'
					or lesson.auteur_id = (select public.current_profile_id())
					or (select public.is_edusav_admin())
				)
		)
	);
create policy "users manage pages of own lessons"
	on public.sie_pages for all to authenticated
	using (
		exists (
			select 1 from public.sie_lecon as lesson
			where lesson.id = lecon_id
				and (lesson.auteur_id = (select public.current_profile_id()) or (select public.is_edusav_admin()))
		)
	)
	with check (
		exists (
			select 1 from public.sie_lecon as lesson
			where lesson.id = lecon_id
				and (lesson.auteur_id = (select public.current_profile_id()) or (select public.is_edusav_admin()))
		)
	);

create policy "users read own flashcards"
	on public.sie_flashcards for select to authenticated
	using (user_id = (select public.current_profile_id()) or (select public.is_edusav_admin()));
create policy "users create own flashcards"
	on public.sie_flashcards for insert to authenticated
	with check (user_id = (select public.current_profile_id()));
create policy "users update own flashcards"
	on public.sie_flashcards for update to authenticated
	using (user_id = (select public.current_profile_id()) or (select public.is_edusav_admin()))
	with check (user_id = (select public.current_profile_id()) or (select public.is_edusav_admin()));
create policy "users delete own flashcards"
	on public.sie_flashcards for delete to authenticated
	using (user_id = (select public.current_profile_id()) or (select public.is_edusav_admin()));

insert into storage.buckets (id, name, public)
values ('lesson-pages', 'lesson-pages', false)
on conflict (id) do nothing;

create policy "users upload to own page folder"
	on storage.objects for insert to authenticated
	with check (
		bucket_id = 'lesson-pages'
		and (storage.foldername(name))[1] = (select auth.uid())::text
	);
create policy "users read own page folder"
	on storage.objects for select to authenticated
	using (
		bucket_id = 'lesson-pages'
		and (storage.foldername(name))[1] = (select auth.uid())::text
	);
create policy "users update own page folder"
	on storage.objects for update to authenticated
	using (
		bucket_id = 'lesson-pages'
		and (storage.foldername(name))[1] = (select auth.uid())::text
	)
	with check (
		bucket_id = 'lesson-pages'
		and (storage.foldername(name))[1] = (select auth.uid())::text
	);
create policy "users delete own page folder"
	on storage.objects for delete to authenticated
	using (
		bucket_id = 'lesson-pages'
		and (storage.foldername(name))[1] = (select auth.uid())::text
	);
