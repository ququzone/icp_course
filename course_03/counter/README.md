# counter

```bash
dfx start
dfx deploy
dfx canister call counter get
dfx canister call counter increment
dfx canister call counter set '(555)'

// get ui canister id
dfx canister id __Candid_UI
dfx canister id counter

dfx stop

dfx canister call http_counter increment
dfx canister call http_counter set '(555)'

dfx deploy --network=ic --with-cycles=400000000000
```
