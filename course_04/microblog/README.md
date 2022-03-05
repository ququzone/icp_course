# microblog

```
dfx identity get-principal

dfx canister call microblog post "(\"First post\")"
dfx canister call microblog posts "()"

dfx canister call microblog follow "(principal \"$(dfx canister id microblog2)\")"
dfx canister call microblog follows "()"
dfx canister call microblog2 post "(\"First post 2\")"
dfx canister call microblog timeline "()"
```
