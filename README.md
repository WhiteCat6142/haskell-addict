## Build with Stack

```bash
mkdir haskell-addict
cd haskell-addict
git clone git@github.com:WhiteCat6142/haskell-addict.git
# copy stack.yaml & package.yaml to the upper directory
stack build
# example
stack exec fib-exe
stack exec -- hanoi-exe +RTS -s
```
