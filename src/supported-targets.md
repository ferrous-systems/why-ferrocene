# The supported target platforms

## Target Platform?

* The machine you can run the compiled code on
* A combination of CPU architecture, Operating System and ABI

## The List

* `x86_64-unknown-linux-gnu` (the supported host)
* `aarch64-unknown-none`

## `aarch64-unknown-none`

* Aarch64 mode (A64 instructions) Armv8-A
* `no-std` mode - no Rust `libstd`, only `libcore` and `liballoc`
* Driven by our lead client's requirements
* Bring your existing OS and call its C API from Rust
* Must use the `aarch64-unknown-linux-gnu` GCC 7.5 linker from Ubuntu 18.04
  * With `-ffreestanding` and the other flags in our User Manual

## But what about $MY_FAVOURITE target

* Get in touch!
* If Rust already targets it, it's a case of porting our test suite
* If Rust doesn't already target it ... we can probably fix that for you
