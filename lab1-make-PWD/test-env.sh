# PWD := $(CURDI) 必要性


# Makefile中没有PWD := $(CURDIR)语句，则使用sudo make可能无法正确编译。
# 因为某些环境变量是由安全策略指定的，它们无法被继承。默认的安全策略是sudoers。
# 在sudoers安全策略中，默认启用了env_reset，它限制了环境变量。
# 具体来说，路径变量不会从用户环境中保留，而是被设置为默认值（更多信息请参阅：sudoers手册）。
# 您可以通过以下方式查看环境变量设置：
sudo -s 
sudo -V

#我们可以使用-p标志来打印出环境变量的值
make -p | grep PWD
sudo make -p | grep PWD



# PWD变量在使用sudo时不会被继承。
# workspace/learn-lkmpg/lab1-make-PWD
# > make -p | grep PWD
# echo /home/pem/workspace/learn-lkmpg/lab1-make-PWD
# /home/pem/workspace/learn-lkmpg/lab1-make-PWD
# PWD = /home/pem/workspace/learn-lkmpg/lab1-make-PWD
# OLDPWD = /home/pem/workspace/learn-lkmpg
# CURDIR := /home/pem/workspace/learn-lkmpg/lab1-make-PWD
#         echo $(PWD)
# workspace/learn-lkmpg/lab1-make-PWD
# > sudo make -p | grep PWD
# CURDIR := /home/pem/workspace/learn-lkmpg/lab1-make-PWD
#         echo $(PWD)


# 然而，解决这个问题有三种方法。
# 1. you can use the -E flag to temporarily preserve them.
     sudo -E make -p | grep PWD
    # PWD = /home/ubuntu/temp
    # OLDPWD = /home/ubuntu
    # echo $(PWD

# 2. 你可以通过使用root和visudo编辑/etc/sudoers文件来禁用env_reset。
    ## sudoers file.
    ###
    #...
    #Defaults env_reset
    ### Change env_reset to !env_reset in previous line to keep all
    #environment variable
    # 然后分别执行 env 和 sudo env。
# 3.你可以通过将环境变量追加到 在/etc/sudoers的env_keep来保留它们。
