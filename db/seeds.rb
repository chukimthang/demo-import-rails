unless Admin.find_by(email: 'super_admin@gmail.com')
  admin = Admin.new(
    id: 1,
    email: 'super_admin@gmail.com',
    password: '12345678',
    password_confirmation: '12345678',
    role: Admin.roles[:super_admin]
  )
  admin.save
end
