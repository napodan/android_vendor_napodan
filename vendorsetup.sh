add_lunch_combo oxygen_bravo-user

lunch oxygen_bravo-user

export TOP=$ANDROID_BUILD_TOP
build()
{
  cd $ANDROID_BUILD_TOP
  [[ -d out ]] && \rm -rf out

  # Bionic update
  ./bionic/libc/kernel/tools/update_all.py
  ./bionic/libc/tools/gensyscalls.py

  # Build
  time make -j8 oxygen

  # Verification
  OUTFILE=`echo $OUT/update-oxygen-4.3.0-Bravo-*2014-signed.zip`
  if [[ -f "$OUTFILE" ]]
  then
      bDate=`date +%Y%m%d_%H%M%S`
      REP=../Build/$bDate
      mkdir -p $REP
      unzip -l $OUTFILE > $REP/listFiles.txt
      find out/target/product/bravo/root  -exec du -b {} \; | sort -k2 >> $REP/listFiles.txt
      cp $OUTFILE $REP/
      repo manifest -r -o $REP/build.xml
  fi
}

