def build_roles
  Role.create
  Role.create(name: "store_admin")
  Role.create(name: "platform_admin")
end
