system_ext_path=$(FIND_SYSTEM_EXT)
local target_dir="${WORKSPACE}/${system_ext_path}/etc/selinux/"
    if [[ -d "$target_dir" ]]; then
        LOG_INFO "Removing existing folder: ${target_dir}"
        rm -rf "$target_dir" || ERROR_EXIT "Failed to remove ${target_dir}"
    fi

    mkdir -p "$target_dir"
    sudo cp -r "${OBJECTIVE}/selinux_fix/selinux/"* "$target_dir/" || ERROR_EXIT "Failed to copy SELinux patches to ${target_dir}"
    LOG_SUCCESS "SELinux patches applied to ${target_dir}"
