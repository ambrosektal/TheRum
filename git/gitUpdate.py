import os
import subpocess

for root, dir, files in os.walk("/home/ambrose/"):
    if dir.__contains__(".git"):
        os.chdir(root)
        subprocess.Popen("git", "pull")
