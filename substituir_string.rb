#temporario
test = "http://localhost:1025/users/password/edit?reset_password_token=1eBjPa2nmXHQaYT2dVww".delete("1025")
test.insert(test.index("t:") + 2, '3000')

#final
var = "http://localhost:1025/users/password/edit?reset_password_token=1eBjPa2nmXHQaYT2dVww".delete_prefix("http://localhost:1025")
var.prepend("http://localhost:", "3000")
puts test