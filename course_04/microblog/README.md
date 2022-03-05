# microblog

```
dfx identity get-principal

dfx canister call microblog post "(\"First post\")"
dfx canister call microblog post "(\"Second post\")"
dfx canister call microblog post "(\"Third post\")"
dfx canister call microblog posts "()"

dfx canister call microblog follow "(principal \"$(dfx canister id microblog2)\")"
dfx canister call microblog2 follow "(principal \"$(dfx canister id microblog)\")"
dfx canister call microblog follows "()"
dfx canister call microblog2 post "(\"First post 2\")"
dfx canister call microblog timeline "()"

dfx canister call microblog posts "(1_646_501_329_921_515_000)"
```
