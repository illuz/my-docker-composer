#!/bin/bash

# 尝试使用默认密码连接并修改为新密码
# -u root -p taosdata (默认)
# -s 执行 SQL
taos -u root -p taosdata -s "ALTER USER root PASS 'YourStrongPassword';"

echo "Password updated or already changed."
