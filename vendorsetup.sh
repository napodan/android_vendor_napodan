export DISABLE_DEXPREOPT=true


function build ()
{
	croot;
	cd vendor/napodan
	make mkfile
	croot
	[[ -f $OUT/system/build.prop ]] && rm $OUT/system/build.prop
	make -j4 update-api
	make -j4 bacon
}
