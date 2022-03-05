import List "mo:base/List";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";

actor {
    public type Message = Text;

    public type Microblog = actor {
        follow: shared(Principal) -> async ();
        follows: shared query () -> async [Principal];
        post: shared (Text) -> async ();
        posts: shared query () -> async [Message];
        timeline: shared () -> async [Message];
    };

    stable var followed: List.List<Principal> = List.nil();
    stable var messages: List.List<Message> = List.nil();

    public shared (msg) func follow(id: Principal): async () {
        assert(Principal.toText(msg.caller) == "6wqca-imgxf-edewp-ranox-mnbro-pem6r-kqzkb-k4dln-ly263-7kauq-lae");
        followed := List.push(id, followed);
    };

    public shared query func follows(): async [Principal] {
        List.toArray(followed)
    };

    public shared (msg) func post(message: Text): async () {
        assert(Principal.toText(msg.caller) == "6wqca-imgxf-edewp-ranox-mnbro-pem6r-kqzkb-k4dln-ly263-7kauq-lae");
        messages := List.push(message, messages);
    };

    public shared query func posts(): async [Message] {
        List.toArray(messages)
    };

    public shared func timeline(): async [Message] {
        var result: List.List<Message> = List.nil();

        for (id in Iter.fromList(followed)) {
            let canister: Microblog = actor(Principal.toText(id));
            let msgs = await canister.posts();
            for (msg in Iter.fromArray(msgs)) {
                result := List.push(msg, result);
            };
        };

        List.toArray(result)
    }
};
