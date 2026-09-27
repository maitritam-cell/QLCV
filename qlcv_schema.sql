create table if not exists public.qlcv_profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text not null,
  unit text default '',
  role text not null default 'Cán bộ thực hiện'
    check (role in ('Quản trị viên','Chỉ huy','Cán bộ thực hiện','Chỉ xem')),
  phone text default '',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create table if not exists public.qlcv_tasks (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text default '',
  assignee_id uuid references public.qlcv_profiles(id) on delete set null,
  created_by uuid not null references public.qlcv_profiles(id) on delete restrict,
  due_date date,
  progress integer not null default 0 check(progress between 0 and 100),
  status text not null default 'Chưa bắt đầu'
    check(status in ('Chưa bắt đầu','Đang thực hiện','Đã hoàn thành','Quá hạn')),
  priority text not null default 'Bình thường'
    check(priority in ('Bình thường','Quan trọng','Khẩn')),
  task_group text not null default 'Thường xuyên'
    check(task_group in ('Thường xuyên','Chuyên đề','Đột xuất')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create table if not exists public.qlcv_task_updates (
  id uuid primary key default gen_random_uuid(),
  task_id uuid not null references public.qlcv_tasks(id) on delete cascade,
  updated_by uuid not null references public.qlcv_profiles(id) on delete restrict,
  progress integer not null check(progress between 0 and 100),
  status text not null,
  note text,
  created_at timestamptz not null default now()
);
alter table public.qlcv_profiles enable row level security;
alter table public.qlcv_tasks enable row level security;
alter table public.qlcv_task_updates enable row level security;
