# resize2fs

- [resize2fs](https://TBD/man/8/resize2fs)

<br>

## NAME

resize2fs - ext2/ext3/ext4 file system resizer

<br>

## EXAMPLES

```bash
# Display all block devices in a tree-like format.
root@host:/# lsblk
# Output: The disk is 20G, but the partition is only 8G.
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
nvme0n1     259:0    0   20G  0 disk
└─nvme0n1p1 259:1    0    8G  0 part /

# Run the 'growpart' command to extend the partition. '/dev/nvme0n1' is the disk, '1' is the partition number.
root@host:/# sudo growpart /dev/nvme0n1 1 
# Output: This shows that the partition has been resized.
CHANGED: partition=1 start=2048 old: size=16775135 end=16777183 new: size=41940959 end=41943007

# Display disk usage. The '-h' flag makes the output human-readable, and '.' represents the current directory.
root@host:/# df -kh .
# Output: Despite the partition having been resized, the filesystem still shows as 7.7G.
Filesystem      Size  Used Avail Use% Mounted on
/dev/root       7.7G  7.7G   44M 100% /

# The 'resize2fs' command is used to resize the ext2, ext3, or ext4 file system.
root@host:/# resize2fs /dev/root
# Output: The filesystem has been resized successfully.
resize2fs 1.45.5 (07-Jan-2020)
Filesystem at /dev/root is mounted on /; on-line resizing required
old_desc_blocks = 1, new_desc_blocks = 3
The filesystem on /dev/root is now 5242619 (4k) blocks long.

# Check the disk space again. Now, it should reflect the changes we made above.
root@host:/# df -kh .
# Output: The filesystem now shows as 20G, reflecting the additional disk space.
Filesystem      Size  Used Avail Use% Mounted on
/dev/root        20G  7.7G   12G  40% /

```