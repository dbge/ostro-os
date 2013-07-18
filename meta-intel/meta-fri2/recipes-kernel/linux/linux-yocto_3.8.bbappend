FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

LINUX_VERSION = "3.8.13"

COMPATIBLE_MACHINE_fri2 = "fri2"
KMACHINE_fri2 = "fri2"
KBRANCH_fri2 = "standard/fri2"
KERNEL_FEATURES_fri2_append = " features/drm-emgd/drm-emgd-1.18 cfg/vesafb"
SRCREV_meta_fri2 = "8ef9136539464c145963ac2b8ee0196fea1c2337"
SRCREV_machine_fri2 = "f20047520a57322f05d95a18a5fbd082fb15cb87"
SRCREV_emgd_fri2 = "a18cbb7a2886206815dbf6c85caed3cb020801e0"
SRC_URI_fri2 = "git://git.yoctoproject.org/linux-yocto-3.8.git;protocol=git;nocheckout=1;branch=${KBRANCH},${KMETA},emgd-1.18;name=machine,meta,emgd"

COMPATIBLE_MACHINE_fri2-noemgd = "fri2-noemgd"
KMACHINE_fri2-noemgd = "fri2"
KBRANCH_fri2-noemgd = "standard/fri2"
KERNEL_FEATURES_fri2_append = " cfg/vesafb"
SRCREV_meta_fri2-noemgd = "8ef9136539464c145963ac2b8ee0196fea1c2337"
SRCREV_machine_fri2-noemgd = "f20047520a57322f05d95a18a5fbd082fb15cb87"

module_autoload_iwlwifi = "iwlwifi"

