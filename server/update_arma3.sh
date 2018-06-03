USER=$1
PASS=$2
ARMA_ID=107410
ARMA_SERVER_ID=233780
RHSUSAF_ID=843577117
RHSAFRF_ID=843425103
RHSGREF_ID=843593391
INSTALL_DIR=/home/redguard/Arma3
WORKSHOP_DIR=/home/redguard/steamcmd/steamapps/workshop/content

download_mod() {
	MODID=$1
	./steamcmd.sh +login $USER $PASS +force_install_dir $INSTALL_DIR +workshop_download_item $ARMA_ID $MODID validate +quit
}

./steamcmd.sh +login $USER $PASS +force_install_dir $INSTALL_DIR +app_update $ARMA_SERVER_ID +quit
download_mod $RHSUSAF_ID
download_mod $RHSAFRF_ID
download_mod $RHSGREF_ID

ln -s -T $WORKSHOP_DIR/$ARMA_ID/$RHSUSAF_ID $INSTALL_DIR/@rhsusaf
ln -s -T $WORKSHOP_DIR/$ARMA_ID/$RHSAFRF_ID $INSTALL_DIR/@rhsafrf
ln -s -T $WORKSHOP_DIR/$ARMA_ID/$RHSGREF_ID $INSTALL_DIR/@rhsgref
