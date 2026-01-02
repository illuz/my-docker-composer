#!/bin/bash
# 在容器中执行

# 尝试使用默认密码连接并修改为新密码
# -u root -p taosdata (默认)
# -s 执行 SQL
taos -u root -p taosdata -s "ALTER USER root PASS 'sjgE0dPg3ySe8MwPwetMAS0W72beMsTf';"

echo "Password updated or already changed."


# 或者直接执行：
# docker exec -it tdengine taos -s "ALTER USER root PASS 'sjgE0dPg3ySe8MwPwetMAS0W72beMsTf';"