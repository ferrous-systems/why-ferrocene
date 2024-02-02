# Ferrocene is just Rust

## No, really...

* We didn't write a new Rust toolchain
* We qualified The Rust Toolchain

## Non-divergence

One of the Ferrocene pillars is that the standard library and the compiler must not diverge from upstream.

## The model works

We've been doing this since 2021, backporting the `master` branch of `rust-lang/rust` into our tree.

## Patches

* Of course, some changes were required
* So, we upstreamed all of them
* Like [#93717], [#108659], [#111936], [#108898]...
* [#111992], [#112314], [#112418], [#112454], ...

[#93717]: https://github.com/rust-lang/rust/pull/93717
[#108659]: https://github.com/rust-lang/rust/pull/108659
[#111936]: https://github.com/rust-lang/rust/pull/111936
[#108898]: https://github.com/rust-lang/rust/pull/108898
[#111992]: https://github.com/rust-lang/rust/pull/111992
[#112314]: https://github.com/rust-lang/rust/pull/112314
[#112418]: https://github.com/rust-lang/rust/pull/112418
[#112454]: https://github.com/rust-lang/rust/pull/112454

## Virtuous Cycle

* Sometimes we find bugs that upstream missed
* So we upstreamed the fixes
* Like [#108905] or [#114613].

[#108905]: https://github.com/rust-lang/rust/pull/108905
[#114613]: https://github.com/rust-lang/rust/pull/114613

## So what's left?

* Support for the [LynxOS-178] target
  * A proprietary safety-critical focused RTOS
* The temporary implementation [of a feature we proposed] and will implement upstream
* Our build and test infrastructure

[LynxOS-178]: https://www.lynx.com/products/lynxos-178-do-178c-certified-posix-rtos
[of a feature we proposed]: https://github.com/rust-lang/compiler-team/issues/659

## Continuous Test

* We developed our own *Continuous Integration* infrastructure
  * Separate and parallel to that used by The Rust Project
  * They have different goals!
* Having multiple independent, parallel, rock solid CI pipelines can only
  benefit Rust
* Ours produces the artefacts we need for qualification
