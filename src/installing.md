# Installing Ferrocene today

## Ferrocene 23.06

* Ships as tarballs
* Unpack tarballs into, e.g. `/opt/ferrocene-23.06`

## Step-by-step

1. Set up Ubuntu 18.04 for AMD64
2. Install:
   * `gcc-aarch64-linux-gnu`
   * `gcc` and `build-essential`
   * `xz-utils`
3. `mkdir /opt/ferrocene-23.06`
4. `tar xvf <tarball> -C /opt/ferrocene-23.06`
5. Modify `~/.bashrc` to put `/opt/ferrocene-23.06/bin` in your `$PATH`

I use Docker for this. YMMV.

## Installing in the future

We have `criticalup` - like `rustup` but for fetching, verifying and installing
digitally signed Ferrocene tarballs using your subscriber credentials.

You can also use `criticalup` to fetch and verify the install tarballs, ready
for transfer to a non-Internet-connected computer for installation there.
