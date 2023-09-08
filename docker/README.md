# Dockerfile for Ferrocene

Ferrocene 23.06 is only supported inside a Ubuntu 18.04 environment.

This [`Dockerfile`](./Dockerfile) creates an Ubuntu 18.04 container and installs
Ferrocene and an `aarch64-unknown-linux-gnu` toolchain to act as a target
linker/assembler.

Change to the directory where you have downloaded Ferrocene and run:

```console
docker build . -t ferrocene-23.06 -f ./path/to/this/Dockerfile
```

## License

Licensed under either of

* Apache License, Version 2.0 ([LICENSE-APACHE](../LICENSE-APACHE) or
  <http://www.apache.org/licenses/LICENSE-2.0>)
* MIT license ([LICENSE-MIT](../LICENSE-MIT) or
<http://opensource.org/licenses/MIT>) at your option.

## Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall be
dual licensed as above, without any additional terms or conditions.
