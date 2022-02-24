import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Text "mo:base/Text";
import Int "mo:base/Int";

func quicksort(arr: [var Int]): [Int] {
    func sort(low: Nat, high: Nat) {
        if (low < high) {
            var p = arr[low];
            var i = low;
            var j = high;
            while (i < j) {
                while(arr[j] >= p and i < j) {
                    j -= 1;
                };

                while(arr[i] <= p and i < j) {
                    i += 1;
                };

                let temp = arr[j];
                arr[j] := arr[i];
                arr[i] := temp;
            };
            arr[low] := arr[i];
            arr[i] := p;
            if (j > 0) {
                sort(low, j - 1);
            };
            sort(j + 1, high);
        }
    };
    sort(0, arr.size() - 1);

    Array.freeze(arr);
};

Debug.print(Text.join(", ", Array.map(quicksort([var 10, 1, 9, 3, 2, 5]), Int.toText).vals()));
