# microblog

```
dfx canister call microblog set_name "(\"123456\", \"ququzone\")"
dfx canister call microblog follow "(\"123456\", principal \"$(dfx canister id microblog2)\")"
dfx canister call microblog2 set_name "(\"123456\", \"microblog2\")"
dfx canister call microblog2 post "(\"123456\", \"First post 2\")"
```
