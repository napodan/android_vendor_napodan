add_lunch_combo oxygen_bravo-user

lunch oxygen_bravo-user

build()
{
  cd $ANDROID_BUILD_TOP
  [[ -d out ]] && \rm -rf out
  ./bionic/libc/kernel/tools/update_all.py
  ./bionic/libc/tools/gensyscalls.py
  time make -j oxygen
}
