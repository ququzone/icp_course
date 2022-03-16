# microblog

```
dfx canister call microblog set_name "(\"123456\", \"ququzone\")"
dfx canister call microblog follow "(\"123456\", principal \"$(dfx canister id microblog2)\")"
dfx canister call microblog2 set_name "(\"123456\", \"microblog2\")"
dfx canister call microblog2 post "(\"123456\", \"First post 2\")"

dfx canister --network=ic call bozv6-eqaaa-aaaal-qaqra-cai follow "(\"123456\", principal \"eaeyc-diaaa-aaaal-qaqnq-cai\")"
dfx canister --network=ic call bozv6-eqaaa-aaaal-qaqra-cai follow "(\"123456\", principal \"bvk5z-yiaaa-aaaal-qapwa-cai\")"
dfx canister --network=ic call bozv6-eqaaa-aaaal-qaqra-cai follow "(\"123456\", principal \"frog5-3aaaa-aaaal-qaqia-cai\")"
dfx canister --network=ic call bozv6-eqaaa-aaaal-qaqra-cai set_name "(\"123456\", \"ququzone\")"

dfx deploy --network=ic --with-cycles=400000000000
dfx canister --network=ic stop --all
dfx canister --network=ic delete --all
```
