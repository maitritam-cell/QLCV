# QLCV – Quản lý công việc

Ứng dụng web tĩnh quản lý và giao việc, dùng Supabase Auth + PostgreSQL/RLS. Có thể triển khai trực tiếp trên Vercel hoặc hosting tĩnh.

## Chức năng
- Đăng nhập/đăng ký Supabase Auth
- Dashboard thống kê
- Tạo, phân công, cập nhật và xóa công việc
- Lọc/tìm kiếm theo trạng thái, mức độ
- Tiến độ 0–100%
- Hồ sơ cán bộ
- Vai trò: Quản trị viên, Chỉ huy, Cán bộ thực hiện, Chỉ xem
- Dữ liệu tách riêng trong các bảng `qlcv_*`

## Supabase
Đã thiết kế cho project NhiemVuPro. Chỉ dùng publishable key ở frontend; không đưa service-role key vào mã nguồn.

## Triển khai Vercel
Project là static site: không cần build command, output directory là thư mục gốc.

## Cấp quyền quản trị lần đầu
Sau khi đăng ký tài khoản, chạy trong Supabase SQL Editor:
```sql
update public.qlcv_profiles p
set role = 'Quản trị viên'
where p.id = (select id from auth.users where email = 'EMAIL_CUA_BAN');
```
