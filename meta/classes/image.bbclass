inherit rootfs_${IMAGE_PKGTYPE}

# We need to recursively follow RDEPENDS and RRECOMMENDS for images
BUILD_ALL_DEPS = "1"
do_rootfs[recrdeptask] = "do_package_write"

# Images are generally built explicitly, do not need to be part of world.
EXCLUDE_FROM_WORLD = "1"

USE_DEVFS ?= "0"

DEPENDS += "makedevs-native"
PACKAGE_ARCH = "${MACHINE_ARCH}"

def get_image_deps(d):
	import bb
	str = ""
	for type in (bb.data.getVar('IMAGE_FSTYPES', d, 1) or "").split():
		deps = bb.data.getVar('IMAGE_DEPENDS_%s' % type, d) or ""
		if deps:
			str += " %s" % deps
	return str

DEPENDS += "${@get_image_deps(d)}"

IMAGE_DEVICE_TABLE ?= "${@bb.which(bb.data.getVar('BBPATH', d, 1), 'files/device_table-minimal.txt')}"
IMAGE_POSTPROCESS_COMMAND ?= ""

# Must call real_do_rootfs() from inside here, rather than as a separate
# task, so that we have a single fakeroot context for the whole process.
fakeroot do_rootfs () {
	set -x
	rm -rf ${IMAGE_ROOTFS}

	if [ "${USE_DEVFS}" != "1" ]; then
		mkdir -p ${IMAGE_ROOTFS}/dev
		makedevs -r ${IMAGE_ROOTFS} -D ${IMAGE_DEVICE_TABLE}
	fi

	rootfs_${IMAGE_PKGTYPE}_do_rootfs

	${IMAGE_PREPROCESS_COMMAND}
		
	export TOPDIR=${TOPDIR}

	for type in ${IMAGE_FSTYPES}; do
		if test -z "$FAKEROOTKEY"; then
			fakeroot -i ${TMPDIR}/fakedb.image bbimage -t $type -e ${FILE}
		else
			bbimage -n "${IMAGE_NAME}" -t "$type" -e "${FILE}"
		fi

		rm -f ${DEPLOY_DIR_IMAGE}/${IMAGE_LINK_NAME}.*
		ln -s ${DEPLOY_DIR_IMAGE}/${IMAGE_NAME}.rootfs.$type ${DEPLOY_DIR_IMAGE}/${IMAGE_LINK_NAME}.$type
	done

	${IMAGE_POSTPROCESS_COMMAND}
}
