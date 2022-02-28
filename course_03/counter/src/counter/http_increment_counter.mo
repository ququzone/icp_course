import Text "mo:base/Text";
import Nat "mo:base/Nat";

actor {
    public type Key = Text;
    public type StreamingCallbackHttpResponse = {
        token : ?StreamingCallbackToken;
        body : [Nat8];
    };
    public type StreamingCallbackToken = {
        key : Key;
        sha256 : ?[Nat8];
        index : Nat;
        content_encoding : Text;
    };
    public type StreamingStrategy = {
        #Callback : {
        token : StreamingCallbackToken;
        callback : shared query StreamingCallbackToken -> async ?StreamingCallbackHttpResponse;
        };
    };
    public type HeaderField = (Text, Text);
    public type HttpRequest = {
        url : Text;
        method : Text;
        body : [Nat8];
        headers : [HeaderField];
    };
    public type HttpResponse = {
        body : Blob;
        headers : [HeaderField];
        streaming_strategy : ?StreamingStrategy;
        status_code : Nat16;
    };


    stable var currentValue: Nat = 0;

    public func increment() : async () {
        currentValue += 1;
    };

    public query func get(): async Nat {
        currentValue
    };

    public func set(n: Nat): async () {
        currentValue := n;
    };

    public shared query func http_request(request: HttpRequest): async HttpResponse {
        {
            body = Text.encodeUtf8(
                "<html><body><h1>Current counter value: " # Nat.toText(currentValue) # "</h1></body></html>"
            );
            headers = [];
            streaming_strategy = null;
            status_code = 200;
        }
    }
};
