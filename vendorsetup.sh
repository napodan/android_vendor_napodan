export DISABLE_DEXPREOPT=true


function build ()
{
	croot;
	[[ -f $OUT/system/build.prop ]] && rm $OUT/system/build.prop
	make -j4 update-api
	make -j4 bacon
}
