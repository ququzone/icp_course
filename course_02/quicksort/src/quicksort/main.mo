import Array "mo:base/Array";

actor {
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

    public func qsort(arr: [Int]): async [Int] {
        return quicksort(Array.thaw(arr));
    };
};
