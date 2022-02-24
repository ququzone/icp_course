# quicksort

## Flow

### moc

```bash
export PATH=$(dfx cache show):$PATH
moc --package base $(dfx cache show)/base -r src/quicksort/sort.mo
```

### canister

```bash
dfx start
dfx deploy
// open ui canister and input canister id to load quicksort canister
```

### deploy to Candid UI

https://a4gq6-oaaaa-aaaab-qaa4q-cai.raw.ic0.app
