# The supported host platforms

## Host Platform?

* The machine you can run the toolchain on
* It also has to compile code *for itself*, e.g. proc-macros and `build.rs` files
* A combination of CPU architecture, Operating System and ABI

## The List

* Just `x86_64-unknown-linux-gnu` for now

## `x86_64-unknown-linux-gnu`

* We qualified on Ubuntu 18.04 for x86-64
* This was driven by the needs of our first client
* It comes with GCC 7.5 which is the linker we used for qualification
* More Operating Systems and linkers will be supported in due course

## But what about $MY_FAVOURITE host

* Get in touch!
* If Rust already runs on there, it's a case of porting our test suite
* If Rust doesn't already run on there ... we can probably fix that for you
