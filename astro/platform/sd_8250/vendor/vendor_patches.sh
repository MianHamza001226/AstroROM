if CHECK_WORKDIR "stock"; then
                            
LOG_START "Fixing Face Unlock Biometrics"

# "Removing old face unlock 2.0 HALs"

REMOVE "vendor"  "bin/hw/vendor.samsung.hardware.biometrics.face@2.0-service"
REMOVE "vendor"  "etc/init/vendor.samsung.hardware.biometrics.face@2.0-service.rc"
BLOBS "$CODENAME" "vendor" "etc/vintf/manifest.xml"

LOG_START "Adding new working 3.0 HALs for OneUI6/7 Face Unlock Biometrics "

BLOBS "dm3q" "vendor" "bin/hw/vendor.samsung.hardware.biometrics.face@3.0-service"
BLOBS "dm3q" "vendor" "lib/vendor.samsung.hardware.biometrics.face@3.0.so"
BLOBS "dm3q" "vendor" "lib64/vendor.samsung.hardware.biometrics.face@3.0.so"
BLOBS "dm3q" "vendor" "etc/init/vendor.samsung.hardware.biometrics.face@3.0-service.rc"

ADD_CONTEXT "vendor" 	"vendor/etc/init/vendor.samsung.hardware.biometrics.face@3.0-service.rc"	"vendor_configs_file"
ADD_CONTEXT "vendor"  "vendor/lib/vendor.samsung.hardware.biometrics.face@3.0.so" "vendor_file"
ADD_CONTEXT "vendor"  "vendor/lib64/vendor.samsung.hardware.biometrics.face@3.0.so" "vendor_file"
ADD_CONTEXT "vendor"   "vendor/bin/hw/vendor.samsung.hardware.biometrics.face@3.0-service" "hal_face_default_exec"

LOG_START "Fix Wi-Fi HALs for OneUI6/7"
							 
BLOBS "dm3q" "vendor" "bin/hw/wpa_supplicant"
BLOBS "dm3q" "vendor" "bin/hw/vendor.samsung.hardware.wifi@2.0-service"
BLOBS "dm3q" "vendor" "bin/hw/android.hardware.wifi@1.0-service"

LOG_START "Fix Vibrator motor in OneUI6/7"

REMOVE "vendor"  "bin/hw/vendor.samsung.hardware.vibrator@2.2-service"
REMOVE "vendor"  "etc/init/vendor.samsung.hardware.vibrator@2.2-service.rc"
REMOVE "vendor"  "lib64/vendor.samsung.hardware.vibrator@2.0.so"
REMOVE "vendor"  "lib64/vendor.samsung.hardware.vibrator@2.1.so"
REMOVE "vendor"  "lib64/vendor.samsung.hardware.vibrator@2.2.so"

BLOBS "dm3q" "vendor" "lib64/vendor.samsung.hardware.vibrator-V3-ndk_platform.so"
BLOBS "dm3q" "vendor" "etc/init/vendor.samsung.hardware.vibrator-default.rc"
BLOBS "dm3q" "vendor" "bin/hw/vendor.samsung.hardware.vibrator-service"
BLOBS "dm3q" "vendor" "etc/vintf/manifest/vendor.samsung.hardware.vibrator-default.xml"

ADD_CONTEXT "vendor"  "vendor/lib64/vendor.samsung.hardware.vibrator-V3-ndk_platform.so" "vendor_file"
ADD_CONTEXT "vendor"  "vendor/etc/vintf/manifest/vendor.samsung.hardware.vibrator-default.xml" "vendor_configs_file"
ADD_CONTEXT "vendor"  "vendor/etc/init/vendor.samsung.hardware.vibrator-default.rc" "vendor_configs_file"
ADD_CONTEXT "vendor"  "vendor/bin/hw/vendor.samsung.hardware.vibrator-service" "hal_vibrator_default_exec"


# "Fix Torch/Flashlight on OneUI6/7"

BLOBS "$CODENAME" "vendor" "etc/init/hw/init.$CODENAME.rc"

# "Fix Random Reboot OneUI7"

REMOVE "vendor"  "lib64/vendor.samsung.hardware.tlc.iccc@1.0.so"
REMOVE "vendor"  "bin/hw/vendor.samsung.hardware.tlc.iccc@1.0-service"
REMOVE "vendor"  "etc/init/vendor.samsung.hardware.tlc.iccc@1.0-service.rc"
REMOVE "vendor"  "lib64/vendor.samsung.hardware.tlc.iccc@1.0-impl.so"

BLOBS "dm3q" "vendor" "lib64/vendor.samsung.hardware.tlc.iccc@1.0.so"
BLOBS "dm3q" "vendor" "bin/hw/vendor.samsung.hardware.tlc.iccc@1.0-service"
BLOBS "dm3q" "vendor" "etc/init/vendor.samsung.hardware.tlc.iccc@1.0-service.rc"
BLOBS "dm3q" "vendor" "lib64/vendor.samsung.hardware.tlc.iccc@1.0-impl.so"


LOG_START "Fix RIL , Mobile Data and VolTE , VoWifi"


_COPY_FW "main" "vendor" "bin/hw/rild" 
_COPY_FW "main" "vendor" "lib64/libril_sem.so" 
_COPY_FW "main" "vendor" "lib64/libsec-ril.so" 
_COPY_FW "main" "vendor" "lib64/libsemnativecarrierfeature.so" 
_COPY_FW "main" "vendor" "lib64/libSemTelephonyProps.so" 
_COPY_FW "main" "vendor" "lib/libril_sem.so"
_COPY_FW "main" "vendor" "lib/libsec_semRil.so"  
_COPY_FW "main" "vendor" "lib64/libsec_semRil.so" 
_COPY_FW "main" "vendor" "lib/libsec-ril.so"
_COPY_FW "main" "vendor" "lib/libsemnativecarrierfeature.so" 
_COPY_FW "main" "vendor" "lib/libSemTelephonyProps.so"  
_COPY_FW "main" "vendor" "etc/init/init.vendor.rilcommon.rc"
_COPY_FW "main" "vendor" "etc/init/vendor.samsung.rilchip.qcom.rc" 
_COPY_FW "main" "vendor" "etc/vintf/manifest/vendor.samsung.hardware.radio_manifest_2_30.xml" 
_COPY_FW "main" "vendor" "etc/vintf/manifest/vendor.samsung.hardware.radio.exclude.qcom.xml" 
_COPY_FW "main" "vendor" "etc/vintf/manifest/vendor.samsung.hardware.sehradio_manifest_2_30.xml" 
_COPY_FW "main" "vendor" "etc/mtu-conf.xml" 


ADD_CONTEXT "vendor" "/vendor/etc/vintf/manifest/vendor.samsung.hardware.radio_manifest_2_30.xml" "vendor_configs_file"
ADD_CONTEXT "vendor" "vendor/etc/init/vendor.samsung.rilchip.qcom.rc" "vendor_configs_file"
ADD_CONTEXT "vendor" "vendor/etc/vintf/manifest/vendor.samsung.hardware.radio.exclude.qcom.xml" "vendor_configs_file"
ADD_CONTEXT "vendor" "vendor/etc/vintf/manifest/vendor.samsung.hardware.sehradio_manifest_2_30.xml" "vendor_configs_file"

echo "Remove DualDAR mount points"
sed -i "/keydata/d" "$WORKSPACE/vendor/etc/fstab.qcom"
sed -i "/keyrefuge/d" "$WORKSPACE/vendor/etc/fstab.qcom"

fi