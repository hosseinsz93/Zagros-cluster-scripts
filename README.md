# Zagros Cluster Scripts

## Scripts

### 1. `mount_check.sh`

Checks all PBS nodes and reports nodes where Lustre is not visible through `df`.

What it does:
- Gets node hostnames from `pbsnodes -a` output (`Mom = ...`).
- Runs `df -h | grep lustre` on each node over SSH.
- Prints only failing nodes.

Sample output:

```text
	node123 missing Lustre
	node207 missing Lustre
```

Requirements:
- PBS tools (`pbsnodes`)
- SSH access from the execution host to all compute nodes
- Remote `df` command on nodes

Run:

```bash
bash mount_check.sh
```

### 2. `lustre_size_by_user.sh`

Prints per-user directory sizes under Lustre and sorts by size.

Path behavior:
- Uses `/mnt/lustre` by default.
- If `/mnt/lustre/users` exists, it uses that instead.

What it does:
- Iterates over first-level subdirectories (treated as users).
- Uses `du -sb` for exact byte counts.
- Converts bytes to human-readable format with `numfmt`.
- Sorts output by size (`sort -hk2`).

Sample output:

```text
user                             size
----------------------------------------------
alice                             14GiB
bob                              128GiB
carol                            1.2TiB
```

Requirements:
- `du` with `-b` support (GNU coreutils)
- `numfmt`
- Read permission on Lustre directories

Run:

```bash
bash lustre_size_by_user.sh
```

## Notes

- Run these scripts from a management/login node with cluster access.
- If needed, make scripts executable:

```bash
chmod +x mount_check.sh lustre_size_by_user.sh
```