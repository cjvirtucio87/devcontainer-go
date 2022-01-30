# go-devc

Simple devcontainers for golang. Builds with UID 1000 and GID 1000,
but these can be overridden with `UID` and `GID` build args, respectively.

Only `rockylinux:8` is supported, at the moment.

## Usage

### Building

To build the image, run:

```bash
./build.sh
```

### Running in vscode

Add the [sample config file](./devcontainer.json) to your golang project:

```txt
# some golang project
.devcontainer/devcontainer.json
```

Open your project with `vscode` and run the following command from the
command pallete:

```txt
Remote-Containers: Reopen folder in container
```

`vscode` should then re-open, build and start the container, then open a
terminal with a shell inside the container.

### Running adhoc

The image is also designed to support ad-hoc execution. In this case, it
won't be running a vscode server. Instead, it will be a simple container
with golang installed and your code mounted into your `containerWorkspaceFolder`.

You will need to run a certain docker command, but an example of this can
be found in the [`dev.sh` script](./dev.sh):

```txt
[dev@4b6d52cf7955 cjvirtucio87-tftp-go]$ pwd
/workspaces/cjvirtucio87-tftp-go
[dev@4b6d52cf7955 cjvirtucio87-tftp-go]$ ls -al
total 40
drwxrwxr-x 6 dev  dev  4096 Jan 30 14:50 .
drwxr-xr-x 3 root root 4096 Jan 30 14:13 ..
drwxr-xr-x 2 dev  dev  4096 Jan 30 14:23 .devcontainer
-rw-rw-r-- 1 dev  dev    12 Jan 23 20:58 .dockerignore
drwxrwxr-x 8 dev  dev  4096 Jan 30 14:50 .git
-rw-rw-r-- 1 dev  dev    12 Jan 23 20:23 .gitignore
-rwxrwxr-- 1 dev  dev   975 Jan 27 21:24 build.sh
-rwxrwxr-- 1 dev  dev   789 Jan 27 21:27 dev.sh
drwxrwxr-x 3 dev  dev  4096 Jan 30 00:14 docker
drwxrwxr-x 2 dev  dev  4096 Jan 30 14:50 pkg
[dev@4b6d52cf7955 cjvirtucio87-tftp-go]$ id -u
1000
[dev@4b6d52cf7955 cjvirtucio87-tftp-go]$ id -g
1000
[dev@4b6d52cf7955 cjvirtucio87-tftp-go]$
```
