
Pacman stores its downloaded packages in /var/cache/pacman/pkg/ and does not remove the old or uninstalled versions automatically. This has some advantages:

    It allows to downgrade a package without the need to retrieve the previous version through other means, such as the Arch Linux Archive.
    A package that has been uninstalled can easily be reinstalled directly from the cache folder, not requiring a new download from the repository.

However, it is necessary to deliberately clean up the cache periodically to prevent the folder to grow indefinitely in size.

The paccache script, provided within the pacman-contrib package, deletes all cached versions of installed and uninstalled packages, except for the most recent 3, by default:

# paccache -r

Enable and start paccache.timer to discard unused packages weekly.
Tip: You can create #Hooks to run this automatically after every pacman transaction, see examples.

You can also define how many recent versions you want to keep. To retain only one past version use:

# paccache -rk1

Add the u switch to limit the action of paccache to uninstalled packages. For example to remove all cached versions of uninstalled packages, use the following:

# paccache -ruk0

See paccache -h for more options.

Pacman also has some built-in options to clean the cache and the leftover database files from repositories which are no longer listed in the configuration file /etc/pacman.conf. However pacman does not offer the possibility to keep a number of past versions and is therefore more aggressive than paccache default options.

To remove all the cached packages that are not currently installed, and the unused sync database, execute:

# pacman -Sc

To remove all files from the cache, use the clean switch twice, this is the most aggressive approach and will leave nothing in the cache folder:

# pacman -Scc

