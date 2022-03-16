import List "mo:base/List";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";
import Time "mo:base/Time";

actor {
    public type Message = {
        author: ?Text;
        content: Text;
        timestamp: Int;
    };

    public type Microblog = actor {
        follow: shared(Principal) -> async ();
        follows: shared query () -> async [Principal];
        post: shared (Text) -> async ();
        posts: shared query (since: Time.Time) -> async [Message];
        timeline: shared (since: Time.Time) -> async [Message];
    };

    stable var name: ?Text = null;
    stable var followed: List.List<Principal> = List.nil();
    stable var messages: List.List<Message> = List.nil();

    public shared (msg) func follow(opt: Text, id: Principal): async () {
        assert(opt == "123456");
        followed := List.push(id, followed);
    };

    public shared query func follows(): async [Principal] {
        List.toArray(followed)
    };

    public shared (msg) func post(opt: Text, message: Text): async () {
        assert(opt == "123456");
        messages := List.push({
            author = name;
            content = message;
            timestamp = Time.now();
        }, messages);
    };

    public shared query func posts(since: Time.Time): async [Message] {
        var result: List.List<Message> = List.nil();

        label f for (msg in Iter.fromList(messages)) {
            if (msg.timestamp > since) {
                result := List.push(msg, result);
            } else {
                break f;
            }
        };

        List.toArray(result)
    };

    public shared func timeline(since: Time.Time): async [Message] {
        var result: List.List<Message> = List.nil();

        for (id in Iter.fromList(followed)) {
            let canister: Microblog = actor(Principal.toText(id));
            let msgs = await canister.posts(since);
            for (msg in Iter.fromArray(msgs)) {
                result := List.push(msg, result);
            };
        };

        List.toArray(result)
    };

    public shared func set_name(opt: Text, _name: Text) {
        assert(opt == "123456");
        name := ?_name;
    };

    public shared query func get_name() : async ?Text {
        name
    };
};
