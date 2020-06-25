update $ tags in file with
sed -e "s/\${TARGET_ROOT}/1/" -e "s/\${word}/dog/" pacman_env_var.conf > pacman.conf

MULTI INPUT BY SED
sed -e "s/\${TARGET_ROOT}/1/" -e "s/\${word}/dog/" pacman_env_var.conf > pacman.conf

# ALSO SAME NAME FOR LOCAL VARIABLE IN TEXT FILE AND  BASH VAR IS
POSSIBLE.

sed -e "s/\${TARGET_ROOT}/${TARGET_ROOT}/"pacman_env_var.conf > pacman.conf


####  THIS IS IT

sed -e "s|TARGET_ROOT|$TARGET_ROOT|g" pacman_env_var.conf
